//#include <cudaDefs.h>
//
//cudaError_t error = cudaSuccess;
//cudaDeviceProp deviceProp = cudaDeviceProp();
//
//const unsigned ROWS = 15;
//const unsigned COLS = 20;
//const unsigned BLOCKSIZE = 8;
//
//__global__ void Fill(int* __restrict__  matrix, int rows, int cols, size_t pitch)
//{
//	int row = blockIdx.x * BLOCKSIZE + threadIdx.x;
//	int col = blockIdx.y * BLOCKSIZE + threadIdx.y;
//	if (row >= rows || col >= cols)
//		return;
//
//	int index = row * pitch + col;
//	int value = col * rows + row;
//	
//	matrix[index] = value;
//}
//
//__global__ void increment(int*  __restrict__ matrix, int rows, int cols, size_t pitch)
//{
//	int row = blockIdx.x * BLOCKSIZE + threadIdx.x;
//	int col = blockIdx.y * BLOCKSIZE + threadIdx.y;
//	if (row >= rows || col >= cols)
//		return;
//
//	int index = row * pitch + col;
//	int value = col * rows + row;
//	matrix[index]++;
//}
// int main(int argc, char *argv[])
//{
//	int *dMatrix;
//	size_t pitchBytes = 0;
//	checkCudaErrors(cudaMallocPitch((void**)&dMatrix, &pitchBytes, COLS * sizeof(int), ROWS));
//	size_t pitch = pitchBytes / sizeof(int);
//	
//	dim3 Grid = dim3(getNumberOfParts(ROWS, BLOCKSIZE), getNumberOfParts(COLS, BLOCKSIZE));
//	dim3 BLOCK = dim3(BLOCKSIZE, BLOCKSIZE);
//
//	Fill <<< Grid, BLOCK >>> (dMatrix, ROWS, COLS, pitch);
//	checkDeviceMatrix(dMatrix, pitchBytes, ROWS, COLS, "%-3d ", "dMatrix");
//
//
//	
//	int *matrix = new int[pitch * ROWS];
//	checkCudaErrors(cudaMemcpy2D(matrix, pitchBytes, dMatrix, pitchBytes, COLS * sizeof(int), ROWS, cudaMemcpyKind::cudaMemcpyDeviceToHost));
//	checkHostMatrix(matrix, pitchBytes, ROWS, COLS, "%-3d ", "matrix");
//
//	increment <<< Grid, BLOCK >>> (dMatrix, ROWS, COLS, pitch);
//	checkDeviceMatrix(dMatrix, pitchBytes, ROWS, COLS, "%-3d ", "dMatrixIncrement");
//
//
//	delete[] matrix;
//	cudaFree(dMatrix);
//	return 0;
//}