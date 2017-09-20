import numpy as np;
import matplotlib.pyplot as plt;
from sklearn import datasets, linear_model
from sklearn.metrics import mean_squared_error, r2_score
x =  [ 2 ** i for i in range (10, 20)]
y1 = [0,0,1,2,4,9,17,30,50,103]
y2 = [0,0,0,0,1,3,6,11,21,44]


x2 = [2**j for j in range(5,13)]
y3 = [0,0,1,2,4,9,19,40] #us

plt.loglog(x2,y3,basex = 2,basey = 2)


plt.title("exclusive scan")

plt.show()