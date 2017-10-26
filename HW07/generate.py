import numpy as np 

def arrToFile (filename, array):
	nrows, ncols = array.shape
	f = open(filename , 'w')

	for i in range(nrows):
		for j in range(ncols):
			f.write (str(array[i,j]) + "\n")
	f.close()


if __name__ == '__main__':
	A = np.random.random_integers (-10, 10, size = (16,32))
	b = np.random.random_integers( -10, 10, size= (32,1))

	arrToFile ('inputA.inp', A)
	arrToFile ('inputB.inp', b)

	print(A[-1, :].dot(b))