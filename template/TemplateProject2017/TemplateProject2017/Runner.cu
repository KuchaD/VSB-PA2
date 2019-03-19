//#include <cudaDefs.h>
//#include <time.h>
//#include <math.h>
//#include <random>
//
//using namespace std;
//
//
//cudaError_t error = cudaSuccess;
//cudaDeviceProp deviceProp = cudaDeviceProp();
//
//
//__constant__  __device__  int hodnota;
//
//typedef struct { int x; int y;} Point;
//__constant__  __device__  Point dPoint;
//__constant__  __device__ int dPole[5];
//
//
//
//void Cv1()
//{
//	initializeCUDA(deviceProp);
//
//
//	int hA = 100;
//	int hB = 0;
//	cudaMemcpyToSymbol(static_cast<const void*>(&hodnota), static_cast<const void*>(&hA), sizeof(hodnota));
//	cudaMemcpyFromSymbol(static_cast<void*>(&hB), static_cast<const void*>(&hodnota), sizeof(hodnota));
//
//	cout << hB << endl;
//
//
//
//	Point hL;
//	hL.x = 1;
//	hL.y = 2;
//
//	Point hL2;
//	cudaMemcpyToSymbol(static_cast<const void*>(&dPoint), static_cast<const void*>(&hL), sizeof(hL));
//	cudaMemcpyFromSymbol(static_cast<void*>(&hL2), static_cast<const void*>(&dPoint), sizeof(hL));
//
//	cout << hL2.x << " " << hL2.y << endl;
//
//	int Pole[5] = { 1,2,3,4,5 };
//	int hPole2[5];
//	cudaMemcpyToSymbol(dPole, Pole, sizeof(Pole));
//	cudaMemcpyFromSymbol(hPole2, dPole, sizeof(Pole));
//
//	cout << hPole2[0] << " " << hPole2[1];
//}
//
//
//int main(int argc, char *argv[])
//{
//	initializeCUDA(deviceProp);
//
//	//Cv1();
//	Cv2();
//	system("pause");
//
//}
