#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <omp.h>
#include <sys/utsname.h>

int* read_matrix(FILE *fp, int len) {
	int *x = (int *) malloc(sizeof(int) * len * len);
	for (int i = 0; i < len; i++) {
		for (int j = 0; j < len; j++) {
			fscanf(fp, "%d ", &x[i * len + j]);
		}
	}
	return x;
}

int main(int argc, char* argv[]) {
	if (argc != 4) {
		fprintf(stderr, "Usage %s N imageSize featureSize\n", argv[0]);
		return -1;
	}
	int N = atoi(argv[1]);
	int imageSize = atoi(argv[2]);
	int featureSize = atoi(argv[3]);

	if (featureSize > imageSize) {
		fprintf(stderr, "Error! Feature image cannot be larger\n");
		return -1;
	}

	FILE *fp = fopen("problem2.dat", "r");
	int* image = read_matrix(fp, imageSize);
	int* feature = read_matrix(fp, featureSize);
	fclose(fp);

	struct utsname unameData;
	double start_time = omp_get_wtime();
	// Reverse the rows
	int* reversedImage = (int *) malloc(sizeof(int) * imageSize * imageSize);
	for (int i = 0; i < imageSize; i++)
		memcpy(reversedImage + i * imageSize, image + (imageSize - i - 1) * imageSize, imageSize * sizeof(int));

	// cross correlation

	int finalX, finalY, local_finalX[N], local_finalY[N], max = -featureSize * featureSize; // set max to minimum
	int local_max[N];
	for(int i = 0; i < N; i++) {
		local_max[i] = -featureSize * featureSize;
	}

	omp_set_num_threads(N);
	#pragma omp parallel for schedule(dynamic,8) collapse(2)
	for (int i = 0; i <= imageSize - featureSize; i++) {
		for (int j = 0; j <= imageSize - featureSize; j++) {
			int temp = 0;
			int idx = omp_get_thread_num();
			for (int ii = 0; ii < featureSize; ii++) {
				for (int jj = 0; jj < featureSize; jj++) {
					temp += reversedImage[(i + ii) * imageSize + (j + jj)] * feature[ii * featureSize + jj];
				}
			}
			{
				if (temp > local_max[idx]) {
					local_max[idx] = temp;
					local_finalX[idx] = i;
					local_finalY[idx] = j;
				}
			}
		}
	}
	for (int i = 0; i < N; i++) {
		if(local_max[i] > max) {
			max = local_max[i];
			finalX = local_finalX[i];
			finalY = local_finalY[i];
		}
	}
	double end_time = omp_get_wtime();
	uname(&unameData);

	printf("%d\n", N);
	printf("%d\n", imageSize);
	printf("%d\n", featureSize);
	printf("%lf\n", (end_time - start_time) * 1000);
	printf("%s\n", unameData.nodename);
	printf("%d\n", finalX);
	printf("%d\n", finalY);
	printf("%d\n\n", max);


	free(image);
	free(feature);
	free(reversedImage);
	return 0;
}