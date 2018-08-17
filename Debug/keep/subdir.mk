################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../keep/convolution.cudafe1.cpp 

C_SRCS += \
../keep/convolution.cudafe1.c \
../keep/convolution.cudafe1.stub.c \
../keep/convolution.fatbin.c 

OBJS += \
./keep/convolution.cudafe1.o \
./keep/convolution.cudafe1.stub.o \
./keep/convolution.fatbin.o 

CPP_DEPS += \
./keep/convolution.cudafe1.d 

C_DEPS += \
./keep/convolution.cudafe1.d \
./keep/convolution.cudafe1.stub.d \
./keep/convolution.fatbin.d 


# Each subdirectory must supply rules for building sources it contributes
keep/%.o: ../keep/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-9.2/bin/nvcc -G -g -O0 -keep-dir /home/cagan/cuda-workspace/cudaAlpha/keep -std=c++11 -gencode arch=compute_50,code=sm_50  -odir "keep" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-9.2/bin/nvcc -G -g -O0 -keep-dir /home/cagan/cuda-workspace/cudaAlpha/keep -std=c++11 --compile  -x c -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

keep/%.o: ../keep/%.cpp
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-9.2/bin/nvcc -G -g -O0 -keep-dir /home/cagan/cuda-workspace/cudaAlpha/keep -std=c++11 -gencode arch=compute_50,code=sm_50  -odir "keep" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-9.2/bin/nvcc -G -g -O0 -keep-dir /home/cagan/cuda-workspace/cudaAlpha/keep -std=c++11 --compile  -x c++ -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


