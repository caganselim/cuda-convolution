/*
 * CUDA Convolution Library
 *
 * v1.0.0
 *
 * C.S. Coban
 *
 */

#include <stdio.h>
#include <string.h>

//Cuda Libs
#include <cuda.h>
#include <cuda_runtime.h>
#include <vector_types.h>
#include "device_launch_parameters.h"

//OpenCV Libs
#include "opencv2/opencv.hpp"
#include "helperLibs/helper_cuda.h"
#include "helperLibs/helper_functions.h"

//CUDA Error Checker
static inline void _safe_cuda_call(cudaError err, const char* msg, const char* file_name, const int line_number)
{
	if(err!=cudaSuccess)
	{
		fprintf(stderr,"%s\n\nFile: %s\n\nLine Number: %d\n\nReason: %s\n",msg,file_name,line_number,cudaGetErrorString(err));
		std::cin.get();
		exit(EXIT_FAILURE);
	}
}

#define SAFE_CALL(call,msg) _safe_cuda_call((call),(msg),__FILE__,__LINE__)

//Allocate filter kernel in constant memory on device
__constant__ int filter_kernel[] =
{
  1, 4, 6, 4, 1,
  4, 16, 24, 16, 4,
  6, 24, 36, 24, 6,
  4, 16, 24, 16, 4,
  1, 4, 6, 4, 1,
};

//Set block size
#define BLOCK_SIZE 16

/* KERNELS */


__global__ void conv_globalMem( unsigned char* input,
								unsigned char* output,
								int width,
								int height,
								int inputWidthStep,
								int outputWidthStep,
								int radius, int weight){

	int xIndex = blockIdx.x*blockDim.x + threadIdx.x;
	int yIndex = blockIdx.y*blockDim.y + threadIdx.y;


	//Only valid threads perform memory I/O
	if((xIndex < width) && (yIndex < height)){

		//Allocate values
		int3 acc = make_int3(0,0,0);
		int3 val = make_int3(0,0,0);

		int output_tid = yIndex * outputWidthStep + (3 * xIndex);

		for (int i = -radius; i <= radius; i++) {
			for (int j = -radius; j <= radius; j++) {

				//Skip violations (which will lead to zero by default
				if ((xIndex + i < 0) || (xIndex + i >= width) || (yIndex + j < 0) || (yIndex + j >= height)) continue;

				//Get kernel value
				int temp = filter_kernel[i + radius + (j+radius)*((radius << 1) + 1)];

				//Location of colored pixel in input
				int input_tid = (yIndex + j) * inputWidthStep + (3 * (xIndex + i));

				//Fetch the three channel values
				const unsigned char blue	= input[input_tid];
				const unsigned char green = input[input_tid + 1];
				const unsigned char red	= input[input_tid + 2];


				val.x = int(blue)*temp;
				val.y = int(green)*temp;
				val.z = int(red)*temp;

				//Perform cumulative sum
				acc.x += val.x;
				acc.y += val.y;
				acc.z += val.z;
			}
		}

		acc.x = acc.x/weight;
		acc.y = acc.y/weight;
		acc.z = acc.z/weight;

		output[output_tid] = static_cast<unsigned char>(acc.x);
		output[output_tid + 1] = static_cast<unsigned char>(acc.y);
		output[output_tid + 2] = static_cast<unsigned char>(acc.z);

	}

} //end of convGlobal


/*Convolution Wrapper*/

void convolution( const cv::Mat& input, cv::Mat& output ){

	//Calculate the bytes to be transferred
	const int inputBytes = input.step * input.rows;
	const int outputBytes = output.step * output.rows;

	//Instantiate device pointers
	unsigned char *d_input, *d_output;

	//Allocate device memory
	SAFE_CALL(cudaMalloc<unsigned char>(&d_input,inputBytes),"CUDA Malloc Failed");
	SAFE_CALL(cudaMalloc<unsigned char>(&d_output,outputBytes),"CUDA Malloc Failed");

	//Calculate required threads and gridSize size to cover the whole image

	//Specify a reasonable blockSize size
	const dim3 blockSize(BLOCK_SIZE,BLOCK_SIZE); //16x16 threads = 256 thread per block

	//Calculate gridSize size to cover the whole image
	const dim3 gridSize((input.cols + blockSize.x - 1)/blockSize.x, (input.rows + blockSize.y - 1)/blockSize.y);

	SAFE_CALL(cudaMemcpy(d_input,input.ptr(),inputBytes,cudaMemcpyHostToDevice),"CUDA Memcpy Host To Device Failed");

	//Launch the convolution kernel
	int radius = 2;
	int weight = 256;

	conv_globalMem<<<gridSize,blockSize>>>(d_input,d_output,input.cols,input.rows,input.step,output.step, radius, weight);

	//Synchronize to check for any kernel launch errors
	SAFE_CALL(cudaDeviceSynchronize(),"Kernel Launch Failed");

	//Copy back data from destination  device memory to OpenCV output image
	SAFE_CALL(cudaMemcpy(output.ptr(),d_output,outputBytes,cudaMemcpyDeviceToHost),"CUDA Memcpy Host To Device Failed");

	//Free the device memory
	SAFE_CALL(cudaFree(d_input),"CUDA Free Failed");
	SAFE_CALL(cudaFree(d_output),"CUDA Free Failed");


}
