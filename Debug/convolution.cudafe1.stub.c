#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wunused-function"
#pragma GCC diagnostic ignored "-Wcast-qual"
#define __NV_CUBIN_HANDLE_STORAGE__ static
#include "crt/host_runtime.h"
#include "convolution.fatbin.c"
extern void __device_stub__Z14conv_globalMemPhS_iiiiii(unsigned char *, unsigned char *, int, int, int, int, int, int);
static void __nv_cudaEntityRegisterCallback(void **);
static void __sti____cudaRegisterAll(void) __attribute__((__constructor__));
void __device_stub__Z14conv_globalMemPhS_iiiiii(unsigned char *__par0, unsigned char *__par1, int __par2, int __par3, int __par4, int __par5, int __par6, int __par7){__cudaLaunchPrologue(8);__cudaSetupArgSimple(__par0, 0UL);__cudaSetupArgSimple(__par1, 8UL);__cudaSetupArgSimple(__par2, 16UL);__cudaSetupArgSimple(__par3, 20UL);__cudaSetupArgSimple(__par4, 24UL);__cudaSetupArgSimple(__par5, 28UL);__cudaSetupArgSimple(__par6, 32UL);__cudaSetupArgSimple(__par7, 36UL);__cudaLaunch(((char *)((void ( *)(unsigned char *, unsigned char *, int, int, int, int, int, int))conv_globalMem)));}
# 53 "../convolution.cu"
void conv_globalMem( unsigned char *__cuda_0,unsigned char *__cuda_1,int __cuda_2,int __cuda_3,int __cuda_4,int __cuda_5,int __cuda_6,int __cuda_7)
# 59 "../convolution.cu"
{__device_stub__Z14conv_globalMemPhS_iiiiii( __cuda_0,__cuda_1,__cuda_2,__cuda_3,__cuda_4,__cuda_5,__cuda_6,__cuda_7);
# 113 "../convolution.cu"
}
# 1 "convolution.cudafe1.stub.c"
static void __nv_cudaEntityRegisterCallback( void **__T4) {  __nv_dummy_param_ref(__T4); __nv_save_fatbinhandle_for_managed_rt(__T4); __cudaRegisterEntry(__T4, ((void ( *)(unsigned char *, unsigned char *, int, int, int, int, int, int))conv_globalMem), _Z14conv_globalMemPhS_iiiiii, (-1)); __cudaRegisterVariable(__T4, __shadow_var(filter_kernel,::filter_kernel), 0, 100UL, 1, 0); }
static void __sti____cudaRegisterAll(void) {  __cudaRegisterBinary(__nv_cudaEntityRegisterCallback);  }

#pragma GCC diagnostic pop
