# -*- coding: utf-8 -*-

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from scipy.interpolate import griddata
import matplotlib.cm as cm

# ---- User parameters ----
excel_file = "data.xlsx"

vmin_B = None
vmax_B = None
fallback_frac = 0.10

GAUSS_TO_TESLA = 1e-4

# ---- Read data from Excel ----
# Expected format:
# first row:    x/y, 4, 12, 20, 28, 36
# first column: y values
# body:         magnetic field values in Gauss

df = pd.read_excel(excel_file, header=None)

x_B = df.iloc[0, 1:].to_numpy(dtype=float)
y_B = df.iloc[1:, 0].to_numpy(dtype=float)
Z_B = df.iloc[1:, 1:].to_numpy(dtype=float) * GAUSS_TO_TESLA

# ---- Point cloud for interpolation ----
XB, YB = np.meshgrid(x_B, y_B)

points_B = np.column_stack((XB.ravel(), YB.ravel()))
values_B = Z_B.ravel()

# ---- Interpolation grid ----
x_grid = np.arange(x_B.min(), x_B.max() + 1, 1)
XB_grid_B, YB_grid_B = np.meshgrid(x_grid, y_B)

ZB = griddata(
    points_B,
    values_B,
    (XB_grid_B, YB_grid_B),
    method="cubic"
)

# Fill any missing interpolation points with linear interpolation
if np.isnan(ZB).any():
    ZB_linear = griddata(
        points_B,
        values_B,
        (XB_grid_B, YB_grid_B),
        method="linear"
    )
    ZB = np.where(np.isnan(ZB), ZB_linear, ZB)

# ---- Color range ----
peak_B = np.nanmax(Z_B)

if vmin_B is None:
    vmin_B = (1.0 - fallback_frac) * peak_B

if vmax_B is None:
    vmax_B = (1.0 + fallback_frac) * peak_B

# ---- Mask outside color range ----
ZB_masked = np.ma.masked_outside(ZB, vmin_B, vmax_B)

# ---- Colormap ----
cmapB = cm.viridis.copy()
cmapB.set_bad(color="white")

# ---- Plot ----
plt.figure(figsize=(4, 3))

levels_B = np.linspace(vmin_B, vmax_B, 25)

plt.contourf(
    XB_grid_B,
    YB_grid_B,
    ZB_masked,
    levels=levels_B,
    cmap=cmapB,
    vmin=vmin_B,
    vmax=vmax_B
)

plt.scatter(
    XB.ravel(),
    YB.ravel(),
    c="black",
    s=30
)


plt.xlabel("x (m)")
plt.ylabel("y (m)")
plt.colorbar(label="B (Tesla)")
plt.tight_layout()
plt.savefig('magnetic_field_plot.jpg',dpi=300)









