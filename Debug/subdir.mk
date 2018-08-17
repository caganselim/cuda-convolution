################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CU_SRCS += \
../convolution.cu 

CPP_SRCS += \
../main.cpp 

OBJS += \
./convolution.o \
./main.o 

CU_DEPS += \
./convolution.d 

CPP_DEPS += \
./main.d 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cu
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 -gencode arch=compute_50,code=sm_50  -odir "." -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 --compile --relocatable-device-code=false -gencode arch=compute_50,code=compute_50 -gencode arch=compute_50,code=sm_50  -x cu -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

%.o: ../%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 -gencode arch=compute_50,code=sm_50  -odir "." -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 --compile  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


