################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
../helperLibs/cuda_drvapi_dynlink.c 

OBJS += \
./helperLibs/cuda_drvapi_dynlink.o 

C_DEPS += \
./helperLibs/cuda_drvapi_dynlink.d 


# Each subdirectory must supply rules for building sources it contributes
helperLibs/%.o: ../helperLibs/%.c
	@echo 'Building file: $<'
	@echo 'Invoking: NVCC Compiler'
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 -gencode arch=compute_50,code=sm_50  -odir "helperLibs" -M -o "$(@:%.o=%.d)" "$<"
	/usr/local/cuda-9.2/bin/nvcc -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs -I/home/cagan/cuda-workspace/cudaAlpha/helperLibs/dynlink -G -g -O0 -keep -std=c++11 --compile  -x c -o  "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


