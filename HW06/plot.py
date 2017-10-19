import numpy as np
import matplotlib.pyplot as plt
import sys

if len(sys.argv) != 2:
    print('Usage: {0:s} input'.format(sys.argv[0]))
    exit()


N = range(1,41)
time = np.loadtxt(sys.argv[1], usecols=[0])
#N2, time2 = np.loadtxt(sys.argv[2], usecols=[0,1], unpack=True)
plt.plot(N, time, color ='blue')
#plt.plot(N2, time2, color = 'red')
plt.title('euler01')
plt.xlabel('# threads')
plt.ylabel('time (ms)')
plt.savefig('problem1B.pdf')
plt.show()
