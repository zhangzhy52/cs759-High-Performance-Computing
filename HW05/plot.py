import numpy as np
import matplotlib.pyplot as plt
import sys

if len(sys.argv) != 3:
    print('Usage: {0:s} input'.format(sys.argv[0]))
    exit()

N1, time1 = np.loadtxt(sys.argv[1], usecols=[0,1], unpack=True)
N2, time2 = np.loadtxt(sys.argv[2], usecols=[0,1], unpack=True)
plt.plot(N1, time1, color ='blue')
plt.plot(N2, time2, color = 'red')
plt.title('problem2b')
plt.xlabel('# threads')
plt.ylabel('time (ms)')
plt.show()
plt.savefig('problem2b.pdf')