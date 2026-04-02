# -*- coding: utf-8 -*-
"""
Final plotting script — user-specified visible ranges, outside-range -> white,
no extrapolation, x limited to data range (4..36), single shared Y axis,
aspect ratio equal on both subplots.
Set vmin/vmax for each map below (in Tesla). If left as None, ±10% around
the local peak (max) will be used.
"""

import numpy as np
import matplotlib.pyplot as plt
from scipy.interpolate import griddata
import matplotlib.cm as cm

# ---- User parameters: set these ranges (in Tesla) as you want ----
# If you want the script to compute a default ±10% around the center (max), leave as None.
vmin_A = None   # e.g. 0.00060   # set explicit min for A (Tesla) or None
vmax_A = None   # e.g. 0.00074   # set explicit max for A (Tesla) or None

vmin_B = None   # set explicit min for B (Tesla) or None
vmax_B = None   # set explicit max for B (Tesla) or None

# If using percentage fallback, this fraction will be applied around the local max
fallback_frac = 0.10  # 10%

# ---- Conversion factor (Gauss -> Tesla) ----
GAUSS_TO_TESLA = 1e-4  # 1 G = 1e-4 T

# -------- Dataset A (A645) --------
x_A = np.array([4, 12, 20, 28, 36])
y_A = np.array([0, 5, 15, 25, 35, 45, 55, 65, 75, 85])
Z_A = np.array([
    [2685, 3184, 3309, 3072, 2611],
    [4913, 5374, 5686, 5572, 4801],
    [6315, 6414, 6428, 6426, 6349],
    [6468, 6460, 6466, 6467, 5460],
    [6483, 6467, 6473, 6477, 6470],
    [6486, 6468, 6475, 6472, 6468],
    [6468, 6469, 6460, 6466, 6442],
    [6378, 6436, 6440, 6410, 6307],
    [4900, 5763, 5955, 5570, 4820],
    [2130, 2870, 3100, 2816, 2050]
], dtype=float) * GAUSS_TO_TESLA  # convert to Tesla

# -------- Dataset B (B295) --------
x_B = np.array([4, 12, 20, 28, 36])
y_B = np.array([0, 10, 20, 30, 40, 50])
Z_B = np.array([
    [1133, 1369, 1420, 1380, 1184],
    [2322, 2779, 2814, 2790, 2576],
    [2514, 2929, 2954, 2936, 2730],
    [2512, 2920, 2940, 2925, 2671],
    [2300, 2663, 2695, 2673, 2436],
    [1070, 1340, 1335, 1311, 1100]
], dtype=float) * GAUSS_TO_TESLA  # convert to Tesla

# ---- Point clouds for interpolation ----
XA, YA = np.meshgrid(x_A, y_A)
XB, YB = np.meshgrid(x_B, y_B)
points_A = np.column_stack((XA.ravel(), YA.ravel()))
values_A = Z_A.ravel()
points_B = np.column_stack((XB.ravel(), YB.ravel()))
values_B = Z_B.ravel()

# ---- Interpolation grids (x restricted to actual data range 4..36) ----
x_grid = np.arange(4, 37, 1)  # 1 m resolution for smoothness
XA_grid_A, YA_grid_A = np.meshgrid(x_grid, y_A)  # A: full y-grid (0..85)
XB_grid_B, YB_grid_B = np.meshgrid(x_grid, y_B)  # B: shorter y-grid (0..50)

# ---- Interpolate (cubic inside convex hull; no extrapolation) ----
ZA = griddata(points_A, values_A, (XA_grid_A, YA_grid_A), method='cubic')
if np.isnan(ZA).any():
    ZA_lin = griddata(points_A, values_A, (XA_grid_A, YA_grid_A), method='linear')
    ZA = np.where(np.isnan(ZA), ZA_lin, ZA)

ZB = griddata(points_B, values_B, (XB_grid_B, YB_grid_B), method='cubic')
if np.isnan(ZB).any():
    ZB_lin = griddata(points_B, values_B, (XB_grid_B, YB_grid_B), method='linear')
    ZB = np.where(np.isnan(ZB), ZB_lin, ZB)

# ---- Compute fallback ranges if user left them None (±fallback_frac around local peak) ----
peak_A = 0.6475
peak_B = 0.294

if vmin_A is None or vmax_A is None:
    vmin_A = (1.0 - fallback_frac) * peak_A if vmin_A is None else vmin_A
    vmax_A = (1.0 + fallback_frac) * peak_A if vmax_A is None else vmax_A

if vmin_B is None or vmax_B is None:
    vmin_B = (1.0 - fallback_frac) * peak_B if vmin_B is None else vmin_B
    vmax_B = (1.0 + fallback_frac) * peak_B if vmax_B is None else vmax_B

# ---- Mask outside chosen ranges (these values will be shown as white) ----
ZA_masked = np.ma.masked_outside(ZA, vmin_A, vmax_A)
ZB_masked = np.ma.masked_outside(ZB, vmin_B, vmax_B)

# ---- Colormap: set masked (bad) values to white ----
cmapA = cm.viridis.copy()
cmapA.set_bad(color='white')
cmapB = cm.viridis.copy()
cmapB.set_bad(color='white')

# ---- Plot ----
fig, axes = plt.subplots(1, 2, figsize=(8, 6), sharey=True, constrained_layout=False)
# common x-axis ticks and limits
x_ticks = np.arange(4, 37, 4)
x_limits = (4, 36)

# --- A645 (left) ---
levels_A = np.linspace(vmin_A, vmax_A, 25)
cfA = axes[0].contourf(XA_grid_A, YA_grid_A, ZA_masked, levels=levels_A,
                       cmap=cmapA, vmin=vmin_A, vmax=vmax_A)
axes[0].scatter(XA.ravel(), YA.ravel(), c='black', s=30, zorder=5)
axes[0].set_title("A645")
axes[0].set_xlabel("X (m)")
axes[0].set_ylabel("Y (m)")
axes[0].set_xlim(*x_limits)
axes[0].set_xticks(x_ticks)
axes[0].set_ylim(0, 85)
axes[0].set_aspect('equal', adjustable='box')

cbarA = fig.colorbar(cfA, ax=axes[0], orientation='vertical', shrink=0.9, pad=0.02)
cbarA.set_label("B (Tesla)")

# --- B295 (right) ---
levels_B = np.linspace(vmin_B, vmax_B, 25)
cfB = axes[1].contourf(XB_grid_B, YB_grid_B, ZB_masked, levels=levels_B,
                       cmap=cmapB, vmin=vmin_B, vmax=vmax_B)
axes[1].scatter(XB.ravel(), YB.ravel(), c='black', s=30, zorder=5)
axes[1].set_title("B295")
axes[1].set_xlabel("X (m)")
axes[1].set_xlim(*x_limits)
axes[1].set_xticks(x_ticks)
axes[1].set_ylim(0, 85)   # shared single Y axis (0..85)
axes[1].set_aspect('equal', adjustable='box')

cbarB = fig.colorbar(cfB, ax=axes[1], orientation='vertical', shrink=0.9, pad=0.02)
cbarB.set_label("B (Tesla)")

plt.show()
