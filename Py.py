import numpy as np
from scipy.interpolate import make_interp_spline
import matplotlib.pyplot as plt
import pandas as pd

data = [
    {"length": 5,    "average": 0.000291},
    {"length": 10,   "average": 0.000300},
    {"length": 20,   "average": 0.000336},
    {"length": 50,   "average": 0.000349},
    {"length": 100,  "average": 0.000380},
    {"length": 250,  "average": 0.000399},

    
    {"length": 1000, "average": 0.150138},
    {"length": 1500, "average": 0.225207},
    {"length": 2000, "average": 0.300276},
    {"length": 2500, "average": 0.375345},
    {"length": 3000, "average": 0.450414},
    {"length": 3500, "average": 0.525483},
    {"length": 4000, "average": 0.600552}, 
]


df = pd.DataFrame(data)

x = df["length"].values
y = df["average"].values

# Dominio interpolado (muchos puntos intermedios)
x_new = np.linspace(x.min(), x.max(), 300)

# Spline cúbico
spline = make_interp_spline(x, y, k=3)
y_new = spline(x_new)

plt.figure(figsize=(10, 6))
plt.plot(x_new, y_new, label="Crecimiento")
plt.xlabel("Longitud del string")
plt.ylabel("Tiempo promedio (s)")


plt.grid(True, which="both", linestyle="--")
plt.legend()

plt.savefig("benchmark_plot.png") 
