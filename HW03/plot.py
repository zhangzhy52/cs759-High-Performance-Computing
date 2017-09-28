import numpy as np
import matplotlib.pyplot as plt


x = [2**k for k in range(8,14)]
# Solid Lines
yFrontVec = [0.082074, 0.161935, 0.306689 ,0.525691, 1.492864,3.380838   ] #part A. red
yMidVec = 	[0.088187, 0.169663,  0.292279, 0.444489, 1.124300, 2.217549 ] #part B blue 
yEndVec = 	[0.012133, 0.022229,0.035988, 0.048562,0.095694 , 0.135469 ]	#part C orange

#dashed Lines
yFrontList = [0.052170,0.096540,0.157200,0.210364 , 0.420017 , 0.592714 ]
yMidList = [0.224682, 0.694812, 2.041958, 5.274613, 25.182352, 84.050400 ]
yEndList = [0.052641, 0.096823, 0.158046, 0.209362, 0.418997,0.594995]


plt.figure(1)
plt.loglog(x, yFrontVec, basex= 2, basey =2 ,color = 'r', label = 'Insert front of vector')
plt.loglog(x, yMidVec, basex = 2, basey =2 ,color = 'b', label = 'Insert mid of vector')
plt.loglog(x, yEndVec, basex = 2, basey =2 ,color = 'orange', label= 'Insert end of vector')


plt.loglog(x, yFrontList, basex =2 ,basey = 2, color = 'red', dashes=[15,10], label = 'Insert front of List')
plt.loglog(x, yMidList, basex =2 ,basey = 2, color = 'b', dashes=[10,5], label = 'Insert mid of List')
plt.loglog(x, yEndList, basex =2 ,basey = 2, color = 'orange', dashes=[10,5], label = 'Insert end of List')

plt.ylabel ('Log 2 of ms')
plt.xlabel ('log 2 of dataSize')
plt.legend(loc = 0)



plt.show()