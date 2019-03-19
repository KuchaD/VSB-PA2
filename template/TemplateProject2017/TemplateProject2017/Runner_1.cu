//#include <cudaDefs.h>
//
//cudaError_t error = cudaSuccess;
//cudaDeviceProp deviceProp = cudaDeviceProp();
//
///*
// ============================================================================
// Name        : VSB-PAII.cu
// Author      : Dave
// Version     :
// Copyright   : Your copyright notice
// Description : CUDA compute reciprocals
// ============================================================================
// */
//
// /*
//  ============================================================================
//  Name        : cuda1.cu
//  Author      : david
//  Version     :
//  Copyright   : Your copyright notice
//  Description : CUDA compute reciprocals
//  ============================================================================
//  */
//
//
//#define CUDA_CHECK_RETURN(value) CheckCudaErrorAux(__FILE__,__LINE__, #value, value)
//
//constexpr unsigned int THREAD_PER_BLOCK = 256;
//constexpr unsigned int MEMBLOCK = 2;
//
//__global__ void VectorAdd(int* __restrict__ A, int* __restrict__ B, int* __restrict__ C, int M)
//{
//	unsigned int offset = threadIdx.x + blockIdx.x *  THREAD_PER_BLOCK;
//	unsigned int skip = gridDim.x * THREAD_PER_BLOCK;
//
//	while (offset < M)
//	{
//		C[offset] = A[offset] + B[offset];
//		offset += skip;
//	}
//}
//__global__ void VectorAddMN(int* __restrict__ A, int* __restrict__ B, int* __restrict__ C, int M, int N)
//{
//	const int i = blockIdx.x * blockDim.x + threadIdx.x;
//	const int j = blockIdx.y * blockDim.y + threadIdx.y;
//	if (i < M && j < N)
//	{
//		C[i * M + j] = A[i * M + j] + B[i * M + j];
//	}
//}
//
//__global__ void VectorAddMN_2(int *A, int *B, int *C, int M, int N)
//{
//	const int i = blockIdx.x * blockDim.x + threadIdx.x;
//	const int j = blockIdx.y * blockDim.y + threadIdx.y;
//	if (i < M && j < N)
//	{
//
//		for (int i = 0; i < M * N; ++i) {
//			int row = i / N;
//			int col = i % N;
//
//			C[row + col] = A[row + col] + B[row + col];
//		}
//	}
//}
//void CV1_1()
//{
//
//	//Time
//	cudaEvent_t startEvent, stopEvent;
//	float elapsedTime;
//	cudaEventCreate(&startEvent);
//	cudaEventCreate(&stopEvent);
//	cudaEventRecord(startEvent, 0);
//
//	
//	const unsigned int M = 10;
//	const unsigned int bytes = M * sizeof(int);
//
//	//Host allocate
//	int *A_vectorHost = (int*)malloc(bytes);
//	int *B_vectorHost = (int*)malloc(bytes);
//	int *C_vectorHost = (int*)malloc(bytes);
//
//
//	//Allocate the DEVICE memory to be able to copy data from HOST.
//	int *A_vectorDevice;
//	cudaMalloc((void**)&A_vectorDevice, bytes);
//
//	int *B_vectorDevice;
//	cudaMalloc((void**)&B_vectorDevice, bytes);
//
//	int *C_vectorDevice;
//	cudaMalloc((void**)&C_vectorDevice, bytes);
//
//
//	for (int i = 0; i < M; i++)
//	{
//		A_vectorHost[i] = i;
//		B_vectorHost[i] = i;
//		C_vectorHost[i] = 0;
//	}
//
//	cudaMemcpy(A_vectorDevice, A_vectorHost, bytes, cudaMemcpyHostToDevice);
//	cudaMemcpy(B_vectorDevice, B_vectorHost, bytes, cudaMemcpyHostToDevice);
//	cudaMemcpy(C_vectorDevice, C_vectorHost, bytes, cudaMemcpyHostToDevice);
//
//	dim3 dimBlock(THREAD_PER_BLOCK, THREAD_PER_BLOCK);
//	dim3 dimGrid(1, MEMBLOCK);
//
//
//	VectorAdd <<< dimGrid, dimBlock >>> (A_vectorDevice, B_vectorDevice, C_vectorDevice, M);
//
//	
//
//
//	cudaMemcpy(C_vectorHost, C_vectorDevice, bytes, cudaMemcpyDeviceToHost);
//
//	for (int i = 0; i < 10; i++)
//	{
//		printf("\n %d", C_vectorHost[i]);
//	}
//
//	free(A_vectorHost);
//	free(B_vectorHost);
//	free(C_vectorHost);
//
//	A_vectorHost = NULL;
//	B_vectorHost = NULL;
//	C_vectorHost = NULL;
//
//	cudaFree(A_vectorDevice);
//	cudaFree(B_vectorDevice);
//	cudaFree(C_vectorDevice);
//
//
//	//Time
//	cudaEventRecord(stopEvent, 0);
//	cudaEventSynchronize(stopEvent);
//	cudaEventElapsedTime(&elapsedTime, startEvent, stopEvent);
//
//	printf("Time to get device properties: %f ms", elapsedTime);
//	cudaEventDestroy(startEvent);
//	cudaEventDestroy(stopEvent);
//}
//
//void CV1_2()
//{
//	const unsigned int M = 10;
//	const unsigned int N = 10;
//
//	//Host allocate
//	int *A_Host = (int*)malloc(M*N * sizeof(int));
//	int *B_Host = (int*)malloc(M*N * sizeof(int));
//	int *C_Host = (int*)malloc(M*N * sizeof(int));
//
//	for (int i = 0; i < M; i++)
//	{
//		for (int j = 0; j < N; j++)
//		{
//			A_Host[i * M + j] = i * j;
//			B_Host[i * M + j] = i * j;
//
//		}
//	}
//
//	int *A_Device;
//	cudaMalloc(&A_Device, M*N * sizeof(int));
//
//	int *B_Device;
//	cudaMalloc(&B_Device, M*N * sizeof(int));
//	int *C_Device;
//	cudaMalloc(&C_Device, M*N * sizeof(int));
//
//	cudaMemcpy(A_Device, A_Host, M*N * sizeof(int), cudaMemcpyHostToDevice);
//	cudaMemcpy(B_Device, B_Host, M*N * sizeof(int), cudaMemcpyHostToDevice);
//	cudaMemcpy(C_Device, C_Host, M * sizeof(int), cudaMemcpyHostToDevice);
//
//	dim3 dimBlock(M, N);
//	dim3 dimGrid(1, 1);
//
//	VectorAddMN << <dimGrid, dimBlock >> > (A_Device, B_Device, C_Device, M, N);
//
//	cudaMemcpy(C_Host, C_Device, M*N * sizeof(int), cudaMemcpyDeviceToHost);
//
//
//	for (int i = 0; i < M; i++)
//	{
//		std::cout << i << "| ";
//		for (int j = 0; j < N; j++)
//		{
//			std::cout << C_Host[i * M + j] << "   ";
//		}
//		std::cout << std::endl;
//	}
//
//	free(A_Host);
//	free(B_Host);
//	free(C_Host);
//	cudaFree(A_Device);
//	cudaFree(B_Device);
//	cudaFree(C_Device);
//};
//
//
//void CV1_2_2()
//{
//	const unsigned int M = 10;
//	const unsigned int N = 10;
//
//	// M rows N cols
//	int** A_Host = new int*[M];
//	int** B_Host = new int*[M];
//	int** C_Host = new int*[M];
//
//
//	A_Host[0] = new int[M * N];
//	B_Host[0] = new int[M * N];
//	C_Host[0] = new int[M * N];
//
//	for (int i = 1; i < M; ++i) {
//		A_Host[i] = A_Host[i - 1] + N;
//		B_Host[i] = B_Host[i - 1] + N;
//		C_Host[i] = C_Host[i - 1] + N;
//	}
//
//	//Fill
//	for (int i = 0; i < M; ++i) {
//		for (int j = 0; j < N; ++j) {
//			A_Host[i][j] = i * j;
//			B_Host[i][j] = i * j;
//		}
//	}
//
//
//	int *A_Device;
//	cudaMalloc((void **)&A_Device, sizeof(int) * M * N);
//
//
//	int *B_Device;
//	cudaMalloc((void **)&B_Device, sizeof(int) * M * N);
//
//
//	int *C_Device;
//	cudaMalloc((void **)&C_Device, sizeof(int) * M * N);
//
//	cudaMemcpy(A_Device, A_Host[0], M*N * sizeof(int), cudaMemcpyHostToDevice);
//	cudaMemcpy(B_Device, B_Host[0], M*N * sizeof(int), cudaMemcpyHostToDevice);
//	cudaMemcpy(C_Device, C_Host[0], M*N * sizeof(int), cudaMemcpyHostToDevice);
//
//	dim3 dimBlock(M, N);
//	dim3 dimGrid(1, 1);
//
//	VectorAddMN_2 <<< dimGrid, dimBlock >>> (A_Device, B_Device, C_Device, M, N);
//
//	cudaMemcpy(C_Host, C_Device, M*N * sizeof(int), cudaMemcpyDeviceToHost);
//
//
//	for (int i = 0; i < M; i++)
//	{
//		std::cout << i << "| ";
//		for (int j = 0; j < N; j++)
//		{
//			std::cout << C_Host[i][j] << "  ";
//		}
//		std::cout << std::endl;
//	}
//
//	free(A_Host);
//	free(B_Host);
//	free(C_Host);
//	cudaFree(A_Device);
//	cudaFree(B_Device);
//	cudaFree(C_Device);
//};
////
////int main(int argc, char *argv[])
////{
////
////	CV1_1();
////
////}
////
//
