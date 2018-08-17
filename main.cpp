//System includes
#include <iostream>
#include "opencv2/opencv.hpp"

//Required for CUDA vector types
#include <cuda_runtime.h>
#include <cuda.h>
#include <vector_types.h>
#include "convolution.h"


using namespace cv;
using namespace std;

int main(){

	Mat input = imread("colosseo.jpg", IMREAD_COLOR);  // Read the img

	Mat output = input.clone(); //Call constructor

	//Call the wrapper function
	convolution(input,output);

    //Show the input and output
    imshow("Input",input);
    imshow("Output",output);

    waitKey(0);

    return 0;

}
