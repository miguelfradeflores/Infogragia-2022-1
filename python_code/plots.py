import matplotlib.pyplot as plt
import numpy as np

# make data
x = np.linspace(0, 10, 100)
y = 4 + 2 * np.sin(2 * x)

# plot
fig, ax = plt.subplots()

ax.plot(x, y, linewidth=2.0)

ax.set(xlim=(0, 8), xticks=np.arange(1, 8),
       ylim=(0, 8), yticks=np.arange(1, 8))



np.random.seed(3)
x1 = 0.5 + np.arange(8)
y1 = np.random.uniform(2, 7, len(x1))

# plot
fig1, ax1 = plt.subplots()

ax1.bar(x1, y1, width=1, edgecolor="white", linewidth=0.7)

ax1.set(xlim=(0, 8), xticks=np.arange(1, 8),
       ylim=(0, 8), yticks=np.arange(1, 8))

plt.show()

