# cs759project

getE, getG, getH, getZ are functions helped to calculate the gradient matrix.

For every .m file starting with test, you can simply run it inside matlab.

nvcc -ptx myfun.cu
This generates the file named myfun.ptx.

Construct CUDAKernel Object with CU File Input
With a .cu file and a .ptx file you can create a CUDAKernel object in MATLAB that you can then use to evaluate the kernel:
k = parallel.gpu.CUDAKernel('myfun.ptx','myfun.cu');

The class gpuArray provides GPU versions of many functions that we can use to create data arrays.

test12-3 through test12-11 are experiment running without gpud. test 12-15 used Gpu acceleration.

The output of every step is printed to the console. ans means the current frequncy, for example in test12_15, the desire partial set is {1, 1.5, 2.5}, you can check the data in every loop. Diff means the norm of the difference of desired and current partials. Done is a boolean variable indicating whether the loop ends.


The audio file has 3 pieces: first part each note has partials of {f, 2f, 3f} which is traditional musical instrument made of uniform string. Second part is {f, 1.5f , 2.5f}, third part is {f, 2.5f, 3.5f}
