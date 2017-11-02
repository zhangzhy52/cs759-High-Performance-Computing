import matplotlib.pyplot as plt; plt.rcdefaults()
import numpy as np
import matplotlib.pyplot as plt
 
objects = ("8", "16", "32")
y_pos = np.arange(len(objects))
performance = [25.922592, 24.262848, 24.068800]
 
plt.bar(y_pos, performance, align='center', alpha=0.3)
plt.xticks(y_pos, objects)
plt.ylabel('time')
plt.xlabel("tile size")
plt.title('euler02')
plt.savefig('problem2.pdf')
plt.show()