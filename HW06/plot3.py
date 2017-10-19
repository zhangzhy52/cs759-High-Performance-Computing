import numpy as np
import matplotlib.pyplot as plt
import sys

if len(sys.argv) != 1:
    print('Usage: {0:s} input'.format(sys.argv[0]))
    exit()

inclu32 = [0.626752, 0.627328, 0.598912,0.560192, 0.64336, 0.733664, 0.82832, 1.71837, 2.84163, 4.74774,6.99552]
exclu32 = [0.056928, 0.056032, 0.04944, 0.039968 ,0.037248, 0.02576, 0.018624, 0.018656, 0.033312,0.064992,0.117088]

inclu = [0.817344, 0.506688, 0.520576, 0.5616, 0.640128 ,0.604672, 0.896992, 1.67594, 2.89133,4.54602,7.76291]
exclu = [0.070048, 0.043808, 0.044032, 0.04096, 0.035456, 0.02016, 0.019456, 0.026528, 0.03712,0.060192,0.112576]


N = [2**k for k in range(10, 21)]
#N2, time2 = np.loadtxt(sys.argv[2], usecols=[0,1], unpack=True)

plt.loglog(N,inclu32 , basex= 2, basey =2 ,color = 'blue',ls = ':', label = 'Inclusive32')
plt.loglog(N,exclu32 , basex= 2, basey =2 ,color = 'red',ls = ':', label = 'exclusive32')
plt.loglog(N,inclu , basex= 2, basey =2 ,color = 'blue', label = 'Inclusive1024')
plt.loglog(N,exclu , basex= 2, basey =2 ,color = 'red', label = 'exclusive1024')
#plt.plot(N2, time2, color = 'red')
plt.title('euler01')
plt.xlabel('N')
plt.ylabel('time (ms)')
plt.savefig('problem3.pdf')
plt.show()
