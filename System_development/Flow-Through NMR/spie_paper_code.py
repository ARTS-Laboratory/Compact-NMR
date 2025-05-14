#%% This first block imports all of the NMR and water quality data files from the computer, 
# calculates necessary quantities, stores them in arrays, and sorts them all accordingly,
# and calculates the signal limits


#Import Necessary Libraries

import numpy as np
import matplotlib.pyplot as plt
from scipy.optimize import curve_fit
import pandas as pd 
from matplotlib.transforms import Bbox
import scipy
from warnings import simplefilter
simplefilter(action="ignore", category=pd.errors.PerformanceWarning)
import time
def sort_together(arr1, arr2, arr3, arr4, arr5):
    """Sorts multiple arrays based on the order of the first array."""
    
    # Zip the arrays together
    zipped_arrays = zip(arr1, arr2, arr3, arr4, arr5)
    
    # Sort the zipped array based on the first element of each tuple (arr1)
    sorted_zipped_arrays = sorted(zipped_arrays)
    
    # Unzip the sorted tuples back into separate arrays
    sorted_arr1, sorted_arr2, sorted_arr3, sorted_arr4, sorted_arr5 = zip(*sorted_zipped_arrays)
    
    return list(sorted_arr1), list(sorted_arr2), list(sorted_arr3), list(sorted_arr4), list(sorted_arr5)
#Set default fonts and plot colors
plt.rcParams.update({'text.usetex': True})
plt.rcParams.update({'image.cmap': 'viridis'})
plt.rcParams.update({'font.serif': ['Times New Roman', 'Times', 'DejaVu Serif',
                                    'Bitstream Vera Serif', 'Computer Modern Roman', 'New Century Schoolbook',
                                    'Century Schoolbook L', 'Utopia', 'ITC Bookman', 'Bookman',
                                    'Nimbus Roman No9 L', 'Palatino', 'Charter', 'serif']})
plt.rcParams.update({'font.family': 'serif'})
plt.rcParams.update({'font.size': 11})
plt.rcParams.update({'mathtext.rm': 'serif'})
plt.rcParams.update({'mathtext.fontset': 'custom'})
cc = plt.rcParams['axes.prop_cycle'].by_key()['color']
plt.close('all')

# import required module
import os
# assign directory where the data file is
directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/data/nmr_data/copper_water/'
# iterate over files in
# that directory
times = []
larmor_frequencies = []
trial_numbers = []
temp = 123987
files = []
concentrations = []
#Capturing arrays for X and Y datapoints
Y = []

for folder_name in os.listdir(directory):
    print(folder_name)
    k = 0

    for filename in os.listdir(directory + folder_name):
        files.append(filename)
        larmor = []
        larmor.append(filename[0:8])
        number = []
        
        i = 0
        for letter in filename:
            if letter == '.':
                number.append(filename[8:i])
            i = i + 1
            
        m = 0 
        for letter in folder_name:
            if letter == 'm':
                concentrations.append(folder_name[0:m])
            m = m + 1
        
        f = os.path.join(directory, folder_name, filename)
        data = pd.read_csv(f, header=None)
    # checking if it is a file
        X = data[1].values
    #Y.append(data[0].values)
        larmor_frequencies.append(larmor[0])
        trial_numbers.append(number)
        times.append(os.path.getmtime(f))
        Y.append(data[0].values)
        k = k + 1

times, concentrations, larmor_frequencies, trial_numbers, Y = sort_together(times,concentrations, larmor_frequencies, trial_numbers, Y)
directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/water_quality_data/'
temp1 = []
temp2 = []
temp3 = []
temp4 = []
temp5 = []
for folder_name in os.listdir(directory):
    WQ = pd.read_csv(directory+folder_name,encoding='unicode_escape')
    temp1.append(WQ['Time'])
    temp2.append(WQ['Conductivity (µS)'])
    temp3.append(WQ['pH'])
    temp4.append(WQ['Temp (°C)'])
    temp5.append(WQ['turbidity (NTU)'])
WQ_times = []
conductivity = []
pH = []
temperature = []
turbidity = []
for i in temp1:
    for j in i:
        WQ_times.append(j+43200)

i = 0
while i < len(temp2):
    j = 0
    while j < len(temp2[i]):
        conductivity.append(temp2[i][j])
        pH.append(temp3[i][j])
        temperature.append(temp4[i][j])
        turbidity.append(temp5[i][j])
        j = j + 1
    i = i + 1
        
WQ_times, conductivity, pH, temperature, turbidity = sort_together(WQ_times, conductivity, pH, temperature, turbidity)
#for i in WQ['Time']:
#    WQ_times.append(1737652747+25217+14.66667*j)
#    j = j + 1
indecis1 = []
indecis2 = []
i = 0
for b in times:
    j = 0
    for a in WQ_times:
        if a > b:
            if abs(WQ_times[j] - b) > abs(WQ_times[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j-1)
                indecis2.append(i)
                break;
            if abs(WQ_times[j] - b) < abs(WQ_times[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j)
                indecis2.append(i)
                break;     
        j = j + 1
    i = i + 1
times = np.array(times)[indecis2]
concentrations = np.array(concentrations)[indecis2]
larmor_frequencies = np.array(larmor_frequencies)[indecis2]
trial_numbers = np.array(trial_numbers)[indecis2]
Y = np.array(Y)[indecis2]
conductivity = np.array(conductivity)[indecis1]
pH = np.array(pH)[indecis1]
temperature = np.array(temperature)[indecis1]
turbidity = np.array(turbidity)[indecis1]
a = np.argmax(Y[10])
a
i = 0
while i < len(Y):
    Y[i][a] = 0.024875
    Y[i][a-1] = 0.024875
    Y[i][a+1] = 0.024875
    Y[i][a+2] = 0.024875
    Y[i][a+3] = 0.024875
    Y[i][a-2] = 0.024875
    Y[i][a-3] = 0.024875
    i = i + 1
plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
plt.figure(figsize=(7.38, 3.5))


plt.plot(X[0:11000], np.log(np.average(Y[4003:4004],axis=0)[0:11000]), label='sample T2 curve')
#plt.plot(X[0:5000], np.log(np.average(Y[1000:2750],axis=0)[0:5000]), label='1')
#plt.plot(X[0:5000], np.log(Y[500][0:5000]), label='2')
#plt.plot(X[0:5000], np.log(Y[1000][0:5000]), label='3')
#plt.plot(X[0:5000], np.log(Y[1500][0:5000]), label='4')
#plt.plot(X[0:5000], np.log(Y[2000][0:5000]), label='5')
plt.axhline(y=-np.mean([np.max(np.log(Y[4003][7000:7500])),np.mean(np.log(Y[4003][7000:7500]))]),
                        color = 'black', linestyle ='--', 
                        label='signal strength limit')
plt.grid()
plt.legend(facecolor="white",
           framealpha=1)
plt.xlabel("time (s)")
plt.ylabel("amplitude (mV)")
plt.xlim(xmin=0, xmax=6)
plt.ylim(ymin=-4, ymax=-1.27)
limit = -3.4
plt.savefig('SignalLimit.png', bbox_inches='tight', dpi=300)
#After 5.8 seconds the data jumps unphysically on enough samples to disclude the data from fitting
j = 0
for i in X:
    if i >= 5.8:
        break;
    j = j + 1
length = j    
limits = []
i = 0
for curve in Y:
    limits.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
    
signal_limits = []
l = 0
for curve in Y:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if np.log(data) < limits[l] and np.log(i) < limits[l] and np.log(j) < limits[l]:
            signal_limits.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1

Y = Y.tolist()
Y.pop(102)
larmor_frequencies = larmor_frequencies.tolist()
larmor_frequencies.pop(102)
trial_numbers = trial_numbers.tolist()
trial_numbers.pop(102)
times = times.tolist()
times.pop(102)
conductivity = conductivity.tolist()
conductivity.pop(102)
turbidity = turbidity.tolist()
turbidity.pop(102)
pH = pH.tolist()
pH.pop(102)
temperature = temperature.tolist()
temperature.pop(102)
#%% This block defines a moving average function


def moving_average_numpy(data, window_size):
    """
    Calculates the moving average of a list using NumPy's convolve function.

    Args:
      data: A list of numerical data.
      window_size: The number of data points to include in each average.

    Returns:
      A list containing the moving averages.
    """
    if len(data) < window_size:
        raise ValueError("Window size cannot be larger than the data size.")
    
    # Create an array of weights for the window
    weights = np.ones(window_size) / window_size
    
    # Use convolve to calculate the moving average
    # mode='valid' returns output of length len(data)-window_size+1
    return np.convolve(data, weights, mode='valid')
#%% This block calculates the moving average for one of the datapoints in preparation of plotting 
# signal limits


moving_average = []
j = 50
k = 0
for i in Y[4003]:
   moving_average.append(moving_average_numpy(np.log(Y[4003][k:j]),50))
   j = j + 1
   k = k + 1
#%% This block calculates the moving average
avgs = []
for i in moving_average:
    avgs.append(i[0])
#%% This block plots the moving average


plt.figure(figsize=(7.41,3))
plt.scatter(X[0:11000], np.log(Y[4003][0:11000]), label='log of sample T2 curve',s=1)
plt.plot(X[0:len(avgs)],avgs,linewidth=1, label='moving average',color='C1',linestyle='--')
#plt.plot(X[0:5000], np.log(np.average(Y[1000:2750],axis=0)[0:5000]), label='1')
#plt.plot(X[0:5000], np.log(Y[500][0:5000]), label='2')
#plt.plot(X[0:5000], np.log(Y[1000][0:5000]), label='3')
#plt.plot(X[0:5000], np.log(Y[1500][0:5000]), label='4')
#plt.plot(X[0:5000], np.log(Y[2000][0:5000]), label='5')
plt.axhline(y=np.mean([np.max(np.log(Y[4003][7000:7500])),np.mean(np.log(Y[4003][7000:7500]))]),
                        color = 'black', linestyle ='--', 
                        label='signal strength limit')
plt.grid()
plt.legend(facecolor="white",
           framealpha=1)
plt.xlabel("time (s)")
plt.ylabel("log of amplitude")
plt.xlim(xmin=0, xmax=6)
plt.ylim(ymin=-4, ymax=-1.27)
limit = -3.4
plt.savefig('SignalLimit.png', bbox_inches='tight', dpi=300)
plt.show()
#%% This block fixes the concentration array and gets the X values for all of the plots


concentrations = concentrations.tolist()
concentrations.pop(102)
data = pd.read_csv(f, header=None)
X = data[1].values
#%% #This block does what the first block did but with testing instead of training data


directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/SPIE3/'
# iterate over files in
# that directory
times1 = []
larmor_frequencies1 = []
trial_numbers1 = []
temp1 = 123987
files1 = []
concentrations1 = []
#Capturing arrays for X and Y datapoints
Y1 = []

for folder_name in os.listdir(directory):
    print(folder_name)
    k = 0

    for filename in os.listdir(directory + folder_name):
        
        files1.append(filename)
        larmor1 = []
        larmor1.append(filename[0:8])
        number1 = []
        
        i = 0
        for letter in filename:
            if letter == '.':
                number1.append(filename[8:i])
            i = i + 1
            
        if k < 321:
            concentrations1.append(k*25/322)
        if k >= 322:
            concentrations1.append(25)
        
        f = os.path.join(directory, folder_name, filename)
        data = pd.read_csv(f, header=None)
        X1 = data[1].values
        larmor_frequencies1.append(larmor[0])
        trial_numbers1.append(number)
        times1.append(os.path.getmtime(f))
        Y1.append(data[0].values)
        k = k + 1

times1, concentrations1, larmor_frequencies1, trial_numbers1, Y1 = sort_together(times1,concentrations1, larmor_frequencies1, trial_numbers1, Y1)
directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/water_quality/'
temp1 = []
temp2 = []
temp3 = []
temp4 = []
temp5 = []
for folder_name in os.listdir(directory):
    WQ = pd.read_csv(directory+folder_name,encoding='unicode_escape')
    temp1.append(WQ['Time'])
    temp2.append(WQ['Conductivity'])
    temp3.append(WQ['pH'])
    temp4.append(WQ['temp'])
    temp5.append(WQ['Turbidity'])
WQ_times1 = []
conductivity1 = []
pH1 = []
temperature1 = []
turbidity1 = []
for i in temp1:
    for j in i:
        WQ_times1.append(j)

i = 0
while i < len(temp2):
    j = 0
    while j < len(temp2[i]):
        conductivity1.append(temp2[i][j])
        pH1.append(temp3[i][j])
        temperature1.append(temp4[i][j])
        turbidity1.append(temp5[i][j])
        j = j + 1
    i = i + 1

WQ_times1, conductivity1, pH1, temperature1, turbidity1 = sort_together(WQ_times1, conductivity1, pH1, temperature1, turbidity1)
#for i in WQ['Time']:
#    WQ_times.append(1737652747+25217+14.66667*j)
#    j = j + 1
indecis1 = []
indecis2 = []
i = 0
for b in times1:
    j = 0
    for a in WQ_times1:
        if a > b:
            if abs(WQ_times1[j] - b) > abs(WQ_times1[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j-1)
                indecis2.append(i)
                break;
            if abs(WQ_times1[j] - b) < abs(WQ_times1[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j)
                indecis2.append(i)
                break;     
        j = j + 1
    i = i + 1
times1 = np.array(times1)[indecis2]
concentrations1 = np.array(concentrations1)[indecis2]
larmor_frequencies1 = np.array(larmor_frequencies1)[indecis2]
trial_numbers1 = np.array(trial_numbers1)[indecis2]
Y1 = np.array(Y1)[indecis2]
conductivity1 = np.array(conductivity1)[indecis1]
pH1 = np.array(pH1)[indecis1]
temperature1 = np.array(temperature1)[indecis1]
turbidity1 = np.array(turbidity1)[indecis1]
a = np.argmax(Y[10])
a
i = 0
while i < len(Y1):
    Y1[i][a] = 0.024875
    Y1[i][a-1] = 0.024875
    Y1[i][a+1] = 0.024875
    Y1[i][a+2] = 0.024875
    Y1[i][a+3] = 0.024875
    Y1[i][a-2] = 0.024875
    Y1[i][a-3] = 0.024875
    i = i + 1
plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
plt.figure(figsize=(7.38, 3.5))


#After 5.8 seconds the data jumps unphysically on enough samples to disclude the data from fitting
j = 0
for i in X1:
    if i >= 5.8:
        break;
    j = j + 1
length1 = j    
limits1 = []
i = 0
for curve in Y1:
    limits1.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
    
signal_limits1 = []
l = 0
for curve in Y1:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if np.log(data) < limits1[l] and np.log(i) < limits1[l] and np.log(j) < limits1[l]:
            signal_limits1.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1

Y1 = Y1.tolist()

larmor_frequencies1 = larmor_frequencies1.tolist()

trial_numbers1 = trial_numbers1.tolist()

times1 = times1.tolist()

conductivity1 = conductivity1.tolist()

turbidity1 = turbidity1.tolist()

pH1 = pH1.tolist()

temperature1 = temperature1.tolist()

concentrations1 = concentrations1.tolist()
#%% This block adds the testing data to the training arrays


i = 0
while i < len(Y1):
    Y.append(Y1[i])
    larmor_frequencies.append(larmor_frequencies1[i])
    trial_numbers.append(trial_numbers1[i])
    times.append(times1[i])
    conductivity.append(conductivity1[i])
    turbidity.append(turbidity1[i])
    pH.append(pH1[i])
    temperature.append(temperature1[i])
    signal_limits.append(signal_limits1[i])
    concentrations.append(concentrations1[i])
    i = i + 1
#%% This block does the exponential fits and calculates the amplitude. We use the second value in the array for this


parameters = []
covariance = []
M0s = []
i = 0
for curve in Y:
    M0 = curve[1]
    M0s.append(M0)
    def T2(t, R2):
        M = M0*np.exp(-1*t/R2)
        return M
    c = curve_fit(T2, X1[1:signal_limits[i]], curve[1:signal_limits[i]])
    parameters.append(c[0])
    covariance.append(c[1])
    i = i + 1
amp = [] 
for i in Y:
    amp.append(i[1])
#%% This block calculates signal limits


limits = []
i = 0
for curve in Y:
    limits.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
signal_limits = []
l = 0
for curve in Y:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if l > len(Y):
            print(1)
        if np.log(data) < limits[l] and np.log(i) < limits[l] and np.log(j) < limits[l]:
            signal_limits.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1
#%% This block removes bad data


j = 0
k = []
i = 0
while i < len(parameters):
    #parameters[i] = parameters[i][0]
    i = i + 1
for i in parameters:
    if i > 3.0:
        k.append(j)
    elif i < 0.07:
        k.append(j)
    elif i < 0.5 and j < 3800:
        k.append(j)
    elif i < 0.3 and j < 4400:
        k.append(j)
    elif i < 1 and j < 1200:
        k.append(j)
    elif i < 1 and j > 4990:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    #trial_numbers.pop(i-j)
    times.pop(i-j)
    concentrations.pop(i-j)
    amp.pop(i-j)
    Y.pop(i-j)
    j = j + 1
#%% Removes more bad data


j = 0
k = []
i = 0
while i < len(parameters):
    i = i + 1
for i in amp:
    if i > 0.4:
        k.append(j)
    if i < 0.16:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    #trial_numbers.pop(i-j)
    times.pop(i-j)
    concentrations.pop(i-j)
    Y.pop(i-j)
    j = j + 1
#%% Removes more bad data


j = 0
k = []
i = 0
while i < len(parameters):
    #parameters[i] = parameters[i][0]
    i = i + 1
for i in parameters:
    if i < 0.2 and j < 3950:
        k.append(j)
    elif i > 0.25 and j > 4000 and j < 4200:
        k.append(j)
    elif i < 0.3 and j < 3750:
        k.append(j)
    elif i < 0.65 and j < 2050:
        k.append(j)
    elif i < 0.8 and j < 1850:
        k.append(j)
    elif i < 1 and j < 1640:
        k.append(j)
    elif i < 1.4 and j < 1480 and j > 750:
        k.append(j)
    elif i < 1.25 and j > 200 and j < 500:
        k.append(j)
    elif i < 1.35 and j > 500 and j < 750:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    concentrations.pop(i-j)
    amp.pop(i-j)
    Y.pop(i-j)
    j = j + 1
#%% Recalculates signal limits to match the fixed data


limits = []
i = 0
for curve in Y:
    limits.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
signal_limits = []
l = 0
for curve in Y:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if l > len(Y):
            print(1)
        if np.log(data) < limits[l] and np.log(i) < limits[l] and np.log(j) < limits[l]:
            signal_limits.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1
#%% prepares system validation data
means = []
j = 0
temp = 5
temp1 = []
for i in concentrations:
    if temp == i:
        j = j + 1
    if temp != i:
        temp = i
        temp1.append(j)
        j = j + 1

concs = [5,10,12.5,25,50,75,100,200,400,800,1000]
i = 4178
while i < 4481:
    concs.append(concentrations[i])
means = []
j = 0
for i in temp1:
    means.append(1/np.mean(parameters[j:int(i)]))
    j = i
means.append(1/np.mean(parameters[j:]))
#%% Linear fit on the data to compare
from scipy import stats
slope, intercept, r_value, p_value, std_err = stats.linregress(concs,means[1:12])
print(r_value)
X = [0, 1000]
Y = [intercept,1000*slope+intercept]
#%% Plots the validation data and the linear fit


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
plt.figure(figsize=(4, 1))

plt.grid(zorder=1)
plt.scatter(concs,means[1:12], marker='.',zorder=3, label='measured data',s=100)
plt.plot(X,Y, label='linear fit', color='black',zorder=2,linewidth=0.75)
plt.xlim(0,1000)
plt.ylim(0,12)
plt.xlabel("MP concentration (mg/L)")
plt.ylabel("T2 rate (1/s)")
plt.legend(facecolor="white",
           framealpha=1, fontsize=9, loc='upper left')

plt.savefig('system_validation.png', bbox_inches='tight',dpi=300)
#%% Fixes units of conductivity


con = []
for i in conductivity:
    con.append(i/1000)
#%% Plots T2 fits and conductivity


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'

fig, ax1 = plt.subplots(figsize=(7.03, 3))

ax2 = ax1.twinx()
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
ax1.grid(zorder=1)
ax1.plot(np.arange(0,len(parameters)),parameters[0:len(parameters)],zorder=2, color='C0', linewidth = 0.5, label='T2')
ax2.plot(np.arange(0,len(parameters)),conductivity[0:len(parameters)],zorder=2, color='C1', linewidth = 0.5, label='conductivity')
ax1.set_xlabel('data index')
ax1.set_ylabel('T2 time (s)')
ax2.set_ylabel('conductivity (mS)')
fig.legend(fontsize=9,facecolor="white",
           framealpha=1,bbox_to_anchor=(0.7,0.88),ncol=1)
plt.savefig('t2_copper.png',bbox_inches='tight',dpi=300)
plt.show()
#%% Calculates standard deviation of the conductivity 
dev = np.std(con[2010:3400])
#%% Calculates time series parameters


mean = []
amp = []
rms = []
kurtosis = []
std = []
shape_factor = []
skewness = []
crest_factor = []
impulse_factor = []
j = 0
for i in Y[0:4320]:
    m = np.mean(i[1:signal_limits[j]])
    mean.append(m)
    s = np.std(i[1:signal_limits[j]])
    std.append(s)
    amp.append(i[1])
    r = np.sqrt(np.mean(np.array(i[1:signal_limits[j]])**2))
    rms.append(r)
    shape_factor.append(r/m)
    kurtosis.append(scipy.stats.kurtosis(i[1:signal_limits[j]]))
    skewness.append(scipy.stats.skew(i[1:signal_limits[j]]))
    impulse_factor.append(i[1]/m)
    crest_factor.append(i[1]/r)   
    j = j + 1
#%% Takes out bad data from time series parameters
j = 0
k = []
i = 0
for i in mean:
    if i > 0.13 and j < 3950:
        k.append(j)
    elif i < 0.09:
        k.append(j)
    elif i < 0.105 and j < 1800:
        k.append(j)
        
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    concentrations.pop(i-j)
    amp.pop(i-j)
    Y.pop(i-j)
    mean.pop(i-j)
    kurtosis.pop(i-j)
    rms.pop(i-j)
    shape_factor.pop(i-j)
    skewness.pop(i-j)
    impulse_factor.pop(i-j)
    crest_factor.pop(i-j)
    std.pop(i-j)
    j = j + 1
#%% Removes bad data
tur = []
for i in turbidity:
    if i > 35:
        tur.append(0)
    elif i < 100:
        tur.append(i)
turbidity = tur

#%% Imports libraries and calculates concentration

# Data Processing
import pandas as pd
import numpy as np

# Modelling
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_squared_error, confusion_matrix, precision_score, recall_score, ConfusionMatrixDisplay
from sklearn.model_selection import RandomizedSearchCV, train_test_split
from scipy.stats import randint
from sklearn.inspection import PartialDependenceDisplay
# Tree Visualisation
from sklearn.tree import export_graphviz
from IPython.display import Image
import graphviz

concentration = []

for i in concentrations[0:len(parameters)]:
    
    concentration.append(float(i))
#%% Calculates T2_times as new variable


T2_times = []
for i in parameters:
    T2_times.append(i[0])
#%% Creates variable for machine learning

X = [mean ,amp ,rms ,kurtosis, std, shape_factor, skewness, crest_factor, impulse_factor, temperature[0:3916], pH[0:3916], conductivity[0:3916],T2_times[0:3916]]
features=['Mean' ,'Amplitude' ,'RMS' ,'Kurtosis', 'Standard Deviation', 'Shape Factor', 
          'Skewness', 'Crest Factor', 'Impulse Factor', 'Water Temperature',
         'pH', 'Conductivity','T2']
X = np.array(X).transpose()
#%% Tests the shape of said variable

for i in X:
    print(np.shape(i))
    print(len(i))
#%% Saves data into CSV


import csv
#j = 0
#with open('t2_curves.csv', 'w',newline='') as csvfile:
#    csv_writer = csv.writer(csvfile)
#    csv_writer.writerow(Y)
#j = j + 1
#j = 0
#for i in X:
#    with open(features[j] + '.csv', 'w',newline='') as csvfile:
#        csv_writer = csv.writer(csvfile)
#        for val in i:
#            csv_writer.writerow([val])
#    j = j + 1
#with open('concentration.csv', 'w',newline='') as csvfile:
#    csv_writer = csv.writer(csvfile)
#    for val in conc:
#        csv_writer.writerow([val])
#%% Creates variable with all feature names


features=['mean' ,'amplitude' ,'RMS' ,'kurtosis', 'standard deviation', 'shape factor', 
          'skewness', 'crest factor', 'impulse factor', 'water temperature',
         'pH', 'conductivity','T2']
#%% Creates concentration variable
conc = []
for i in concentrations:
    conc.append(float(i))
#%% Imports necessary libraries and prepares cross validation


from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.model_selection import GridSearchCV
from sklearn.model_selection import cross_validate
def cross_validation(reg_model, housing_prepared, housing_labels, cv):
    scores = cross_val_score(
      reg_model, housing_prepared,
      housing_labels,
      scoring="neg_mean_squared_error", cv=cv)
    rmse_scores = np.sqrt(-scores)
    print("Scores:", rmse_scores)
    print("Mean:", rmse_scores.mean())
    print("StandardDeviation:", rmse_scores.std())
#%% Prepares model for cross validation and hyperparameter tuning


#kf = KFold(n_splits=10, shuffle=True, random_state=42)
rf = RandomForestRegressor()
params = {'max_depth':[3,11,20],'n_estimators':[100,200,300],
              'min_samples_leaf':[1,3,5],'min_samples_split':[1,3,5]}
#clf = GridSearchCV(estimator=rf, param_grid=params,cv=10)
#clf.fit(X, conc)
#rf = clf.best_estimator_
#%% Gets best results from previous block


#print (clf.best_score_, clf.best_params_)
#rf = clf.best_estimator_
#%% Tests training and splitting datasets for non-CV model


X_train, X_test, y_train, y_test = train_test_split(X, conc[0:3916], test_size=0.3,shuffle=True)
#%% Creates model for non-CV


rf = RandomForestRegressor()
#cv_results = cross_validate(rf, X_test, y_test, cv=10, return_estimator=True)
#val_score = []
#for i in range(len(cv_results['estimator'])):
#  val_score.append(cv_results['estimator'][i].score(X_test, y_test))
#a = np.argmax(val_score)
#a
#%% Fits model for non CV


#rf = RandomForestRegressor()
rf.fit(X_train, y_train)
#%% Creates predictions from model on test dataset

y_pred = rf.predict(X_test)
#%% Calculates error


mse = mean_squared_error(y_test, y_pred)
print(f'Mean Squared Error: {mse}')
#%% Sees how many datapoints were inaccurate
y_err = y_test-y_pred
j = 0
for i in y_err:
    if i != 0:
        j = j + 1
j
#%% Calculates R2


import sklearn
print(sklearn.metrics.r2_score(y_test, y_pred))
#%% Calculates importances and plots them


importances = rf.feature_importances_
std = np.std([tree.feature_importances_ for tree in rf.estimators_], axis=0)
plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
forest_importances = pd.Series(importances, index=features)

fig, ax = plt.subplots(figsize=(7.465, 3))

ax.semilogy()
forest_importances.plot.bar(yerr=std, ax=ax,zorder=2)
ax.grid(zorder=1)
ax.set_ylabel("feature importance")
#ax.set_xlabel("feature")
plt.savefig('feature_importance.png', bbox_inches='tight',dpi=300)
fig.tight_layout()
plt.show()
#%% Calculates partial dependence


from sklearn.inspection import partial_dependence
#results = partial_dependence(estimator=rf,X=X_test,features=(0,1,2,3,4,5,6,7,8))
fig, ax = plt.subplots(figsize=(15, 10))
ax.set_title("Partial Dependence Plots")
a = PartialDependenceDisplay.from_estimator(
    estimator=rf,
    X=X_test,
    features=(0,1,2,3,4,5,6,7,8,9,10,11,12), # the features to plot
    random_state=5,
    ax=ax,
    feature_names=(['Mean' ,'Amplitude' ,'RMS' ,'Kurtosis', 'Standard Deviation', 'Shape Factor', 
          'Skewness', 'Crest Factor', 'Impulse Factor', 'Larmor Frequency', 'Water Temperature',
         'pH','conductivity','T2'])
)
plt.show()
#%% Prepares arrays to plot PDP


independent = []
dependent = []
j = 0
for i in a.pd_results:
    independent.append(a.pd_results[j]['grid_values'][0])
    dependent.append(a.pd_results[j]['average'][0])
    j = j + 1
#%% Normalizes for PDP


from sklearn.preprocessing import normalize
ind = []
for i in independent:
    temp = []
    for j in i:
        min_val = np.min(i)
        max_val = np.max(i)
        j = (j - min_val) / (max_val - min_val)
        temp.append(j)
    ind.append(temp)
#%% Plots PDP


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
fig, ax = plt.subplots(figsize=(7.45, 3))

j = 0
#for i in ind:
#    plt.plot(ind[j],dependent[j],label=features[j])
#    j = j + 1
j = 12
ax.plot(ind[j],dependent[j],label=features[j])
j = 11
ax.plot(ind[j],dependent[j],label=features[j])
j = 10
ax.plot(ind[j],dependent[j],label=features[j])
j = 9
ax.plot(ind[j],dependent[j],label=features[j])
#j = 8
#ax.plot(ind[j],dependent[j],label=features[j])
#j = 0
#ax.plot(ind[j],dependent[j],label=features[j])
#x1, x2, y1, y2 = [0.4, 0.95, 80, 120]
#axins = ax.inset_axes(
#    [0.6, 0.25, 0.2, 0.3],
#    xlim=(x1, x2), ylim=(y1, y2))
#axins.grid()
#axins.plot(ind[13],dependent[13])
#axins.plot(ind[8],dependent[8],linewidth=0.75)
#axins.plot(ind[9],dependent[9],linewidth=0.75)
#axins.plot(ind[10],dependent[10],linewidth=0.75)
#axins.plot(ind[12],dependent[12],linewidth=0.75)
#axins.plot(ind[0],dependent[0],linewidth=0.75)

#axins.imshow(ind[8], origin="lower")
#ax.indicate_inset_zoom(axins, edgecolor="black")
ax.legend(title='Parameter',fontsize=9,facecolor="white",
          framealpha=1,ncol=2, loc='upper right')

#plt.legend(bbox_to_anchor=(1.0, 1), loc='upper left')
ax.grid()
plt.xticks(np.arange(0, 1.01, 0.2))
plt.xlabel('normalized predictor value')
plt.xlim(xmin=0, xmax=1)
plt.ylim(ymin=1.869)
plt.ylabel('Cu(II) ion concentration (mg/L)')
plt.savefig('RandomForest.png', bbox_inches='tight',dpi=300)
plt.show()
#%% Plots scatter plot of results


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
plt.figure(figsize=(7.37, 2.5))
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
plt.grid(zorder=1)
plt.plot([np.min(y_test)-0.02,np.max(y_test)+0.02],[np.min(y_test)-0.02,np.max(y_test)+0.02], color='black', label='measured values',zorder=2, linewidth=0.75)
plt.scatter(y_test,y_pred, marker='.', label='predicted values',zorder=3,s=100)
plt.xlim(xmin=np.min(y_test)-2, xmax=np.max(y_test)+10)
plt.ylim(ymin=np.min(y_test)-2, ymax=np.max(y_test)+20)
plt.xlabel("measured Cu(II) ion concentration (mg/L)")
plt.ylabel("predicted Cu(II) ion concentration (mg/L)")
#plt.legend(facecolor="white",
#           framealpha=1, fontsize=9, loc='upper left')

plt.savefig('scater_plot.png', bbox_inches='tight',dpi=300)
plt.show()
#ax.axline((0, 0), slope=1)
#%% Calculates R2 value - this is 1/T2


pars = []
for i in parameters:
    pars.append(1/i)
#%% Plots validation data


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
plt.figure(figsize=(7.3, 3))
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
plt.grid(zorder=1)
plt.scatter(pars,concentration, marker='.',zorder=2)
plt.xlabel("measured T2 time (mg/L)")
plt.ylabel("predicted MP concentration (mg/L)")
#plt.legend(facecolor="white",
#           framealpha=1, fontsize=9, loc='upper left')

plt.savefig('system_validation.png', bbox_inches='tight',dpi=300)
#%% Creates method to normalize an array


def normalize_array(arr):
  """
  Normalizes a NumPy array to the range [0, 1].

  Args:
    arr: The NumPy array to normalize.

  Returns:
    A new NumPy array that is normalized.
  """
  arr_min = np.min(arr)
  arr_max = np.max(arr)
  
  # Avoid division by zero if the array has constant values
  if arr_max - arr_min == 0:
      return np.zeros_like(arr)  # Return an array of zeros with the same shape
  
  normalized_arr = (arr - arr_min) / (arr_max - arr_min)
  return normalized_arr
#%% Imports already saved and processed data


Z = []
filenames = []
import os
# assign directory where the data file is
directory = 'C:/Users/DRH6/Desktop/feature_data/lab_data/'
for filename in os.listdir(directory):
    filenames.append(filename)
    data = pd.read_csv(directory + filename, header=None)
    Z.append(data[0].values)
z = []
for i in Z:
    z.append(normalize_array(i))
#%% Takes this data into separate normalized arrays
z = []
zs = []
for i in Z:
    zs.append(normalize_array(i))
z.append(zs[5])
z.append(zs[0])
z.append(zs[7])
z.append(zs[10])
z.append(zs[9])
z.append(zs[8])
z.append(zs[2])
z.append(zs[3])
z.append(zs[4])
z.append(zs[6])
z.append(zs[14])
z.append(zs[15])
#%% Normalizes time series parameters


m = normalize_array(mean)
a = normalize_array(amp)
r = normalize_array(rms)
k = normalize_array(kurtosis)
s = normalize_array(std)
sf = normalize_array(shape_factor)
sk = normalize_array(skewness)
cf = normalize_array(crest_factor)
i = normalize_array(impulse_factor)
t = normalize_array(temperature)
p = normalize_array(pH)
#tur = normalize_array(turbidity)
c = normalize_array(conductivity)
T = normalize_array(T2_times)
norms = []
norms.append(m)
norms.append(a)
norms.append(r)
norms.append(k)
norms.append(s)
norms.append(sf)
norms.append(sk)
norms.append(cf)
norms.append(i)
norms.append(t)
norms.append(p)
#norms.append(tur)
#norms.append(c)
#norms.append(T)
#%% Calculates times in a way that allows plotting on a continuous X-axis


#plt.plot(Z[12],Z[5])
#plt.show()
j = 0
k = 0
for i in Z[12]:
    if i - j > 4000:
        print(k)
    j = i
    k = k + 1
TIMES = []
i = 0
for j in Z[12]:
    temp = 0
    if i < 1158:
        TIMES.append((j-Z[12][0])/3600)
    elif i < 3162:
        if i == 1158:
            temp = temp
        temp = temp + Z[12][i]-Z[12][1158]+TIMES[1157]*3600
        temp = temp/3600
        TIMES.append(temp)
    elif i < 3628:
        if i == 3162:
            temp = temp
        temp = temp + Z[12][i]-Z[12][3162]+TIMES[3161]*3600
        temp = temp/3600
        TIMES.append(temp)
    elif i < len(Z[12]):
        if i == 3628:
            temp = temp
        temp = temp + Z[12][i]-Z[12][3628]+TIMES[3627]*3600
        temp = temp/3600
        TIMES.append(temp)
    i = i + 1
#%% Plots conductivity and T2 data


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'

fig, ax1 = plt.subplots(figsize=(6.92, 3))

ax2 = ax1.twinx()
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
ax1.grid(zorder=1)
ax1.plot(TIMES,Z[11],zorder=2, color='C0', linewidth = 0.5, label='T2')
ax2.plot(TIMES,Z[13],zorder=2, color='C1', linewidth = 0.5, label='conductivity')
ax1.axvline(TIMES[1158], 0, 13.5, color='black', linewidth=1,linestyle='--')
ax1.axvline(TIMES[3162], 0, 13.5, color='black', linewidth=1,linestyle='--')
ax1.axvline(TIMES[3628], 0, 13.5, color='black', linewidth=1,linestyle='--',label='measurement cutoff')
ax1.set_xlabel('time (hr)')
ax1.set_ylabel('T2 time (s)')
ax2.set_ylabel('conductivity (mS)')
fig.legend(fontsize=9,facecolor="white",
           framealpha=1,bbox_to_anchor=(0.7,0.88),ncol=1)
plt.savefig('t2_copper.png',bbox_inches='tight',dpi=300)
plt.show()
#%% Plots normalized time series parameters


z = norms
import matplotlib.pyplot as plt
plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
fig, ax = plt.subplots(figsize=(6.6, 4))

j = len(z)-1
for i in z:
    if j < 9:
        plt.plot(TIMES,z[j]+j,label=features[j],linewidth=0.5)
    elif j >= 9:
        plt.plot(TIMES,z[j]+j,label=features[j],linewidth=0.5, linestyle='--')
    j = j - 1
    
plt.vlines(TIMES[1158], 0, 12.5, color='black', linewidth=0.5,linestyle='--')
plt.vlines(TIMES[3162], 0, 12.5, color='black', linewidth=0.5,linestyle='--')
plt.vlines(TIMES[3628], 0, 12.5, color='black', linewidth=0.5,linestyle='--')
#plt.plot(np.arange(0,len(norms[j])),norms[j]+1,label=features[j],linewidth=0.5)
#j = 8
#plt.plot(np.arange(0,len(norms[j])),norms[j]+2,label=features[j],linewidth=0.5,color='red')
#j = 6
#plt.plot(np.arange(0,len(norms[j])),norms[j]+3,label=features[j],linewidth=0.5,color='black')
#ax.legend(title='Parameter',fontsize=9,facecolor="white",
#          framealpha=1,ncol=4,bbox_to_anchor=(0.045,1.28), loc='upper left')

#plt.legend(bbox_to_anchor=(1.0, 1), loc='upper left')
ax.grid()
#plt.xticks(np.arange(0, 1.01, 0.2))
plt.xlabel('time (hr)')
plt.ylim(ymin=0,ymax=11.5)
plt.yticks(np.arange(0.5,11.5,1),features[0:11])
plt.ylabel('normalized feature value')
plt.savefig('norms.png', bbox_inches='tight',dpi=300)
plt.show()
#%%  Does what the first cell did but with Creek data


directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/spie_data/creek_2/'
# iterate over files in
# that directory
times = []
larmor_frequencies = []
trial_numbers = []
temp = 123987
files = []
concentrations = []
#Capturing arrays for X and Y datapoints
Y = []

for folder_name in os.listdir(directory):
    print(folder_name)
    k = 0

    for filename in os.listdir(directory + folder_name):
        files.append(filename)
        larmor = []
        larmor.append(filename[0:8])
        number = []
        
        i = 0
        for letter in filename:
            if letter == '.':
                number.append(filename[8:i])
            i = i + 1
        
        f = os.path.join(directory, folder_name, filename)
        data = pd.read_csv(f, header=None)
    # checking if it is a file
        X = data[1].values
    #Y.append(data[0].values)
        larmor_frequencies.append(larmor[0])
        trial_numbers.append(number)
        concentrations.append(number)
        times.append(os.path.getmtime(f))
        Y.append(data[0].values)
        #df[os.path.getmtime(f)] = data[0].values
        k = k + 1


#%% Sorts creek data


times, larmor_frequencies, trial_numbers, Y,concentrations = sort_together(times,larmor_frequencies, trial_numbers, Y,concentrations)
#%% Imports water quality data from the creek


directory = 'C:/Users/DRH6/OneDrive - University of South Carolina/Desktop/water_quality_2/'
temp1 = []
temp2 = []
temp3 = []
temp4 = []
temp5 = []
for folder_name in os.listdir(directory):
    WQ = pd.read_csv(directory+folder_name,encoding='unicode_escape')
    temp1.append(WQ['Time'])
    temp2.append(WQ['Conductivity'])
    temp3.append(WQ['pH'])
    temp4.append(WQ['temp'])
    temp5.append(WQ['Turbidity'])
WQ_times = []
conductivity = []
pH = []
temperature = []
turbidity = []
for i in temp1:
    for j in i:
        WQ_times.append(j)

i = 0
while i < len(temp2):
    j = 0
    while j < len(temp2[i]):
        conductivity.append(temp2[i][j])
        pH.append(temp3[i][j])
        temperature.append(temp4[i][j])
        turbidity.append(temp5[i][j])
        j = j + 1
    i = i + 1
        
WQ_times, conductivity, pH, temperature, turbidity = sort_together(WQ_times, conductivity, pH, temperature, turbidity)
#%% Matches time between NMR and WQ data

indecis1 = []
indecis2 = []
i = 0
for b in times:
    j = 0
    for a in WQ_times:
        if a > b:
            if abs(WQ_times[j] - b) > abs(WQ_times[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j-1)
                indecis2.append(i)
                break;
            if abs(WQ_times[j] - b) < abs(WQ_times[j-1] - b) and abs(a-b) < 15:
                indecis1.append(j)
                indecis2.append(i)
                break;     
        j = j + 1
    i = i + 1
#%% Selects the correct time values


times = np.array(times)[indecis2]
concentrations = np.array(concentrations)[indecis2]
larmor_frequencies = np.array(larmor_frequencies)[indecis2]
trial_numbers = np.array(trial_numbers)[indecis2]
Y = np.array(Y)[indecis2]

conductivity = np.array(conductivity)[indecis1]
pH = np.array(pH)[indecis1]
temperature = np.array(temperature)[indecis1]
turbidity = np.array(turbidity)[indecis1]
#%% Gets rid of bad data


a = np.argmax(Y[10])
i = 0
while i < len(Y):
    Y[i][a] = 0.024875
    Y[i][a-1] = 0.024875
    Y[i][a+1] = 0.024875
    Y[i][a+2] = 0.024875
    Y[i][a+3] = 0.024875
    Y[i][a-2] = 0.024875
    Y[i][a-3] = 0.024875
    i = i + 1
#%%
#After 5.8 seconds the data jumps unphysically on enough samples to disclude the data from fitting
j = 0
for i in X:
    if i >= 5.8:
        break;
    j = j + 1
length = j    


#%% Calculates signal limits


limits = []
i = 0
for curve in Y:
    limits.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
signal_limits = []
l = 0
for curve in Y:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if np.log(data) < limits[l] and np.log(i) < limits[l] and np.log(j) < limits[l]:
            signal_limits.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1

#%%
#Calculating T2 Times (curve_fit parameters)
#Calculating curve_fit covariance
#Calculating Concentration in an array
#Here we drop the first spin echo


parameters = []
covariance = []
M0s = []
i = 0
for curve in Y:
    M0 = curve[1]
    M0s.append(M0)
    def T2(t, R2):
        M = M0*np.exp(-1*t/R2)
        return M
    c = curve_fit(T2, X[1:signal_limits[i]], curve[1:signal_limits[i]])
    parameters.append(c[0])
    covariance.append(c[1])
    i = i + 1
amp = [] 
for i in Y:
    amp.append(i[1])
#%% Converts to lists


Y = Y.tolist()

larmor_frequencies = larmor_frequencies.tolist()

trial_numbers = trial_numbers.tolist()

times = times.tolist()

conductivity = conductivity.tolist()

turbidity = turbidity.tolist()

pH = pH.tolist()

temperature = temperature.tolist()
#%% Removes bad data


j = 0
k = []
i = 0
while i < len(parameters):
    parameters[i] = parameters[i][0]
    i = i + 1
for i in parameters:
    if i > 4:
        k.append(j)
    if i < 1.25:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    Y.pop(i-j)
    amp.pop(i-j)
    j = j + 1

j = 0
k = []
i = 0
while i < len(parameters):
    i = i + 1
for i in amp:
    if i > 0.4:
        k.append(j)
    if i < 0.1:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    Y.pop(i-j)
    amp.pop(i-j)
    j = j + 1
#%% Recalculates signal limits


limits = []
i = 0
for curve in Y:
    limits.append((np.mean(np.log(curve)[7000:7500])+np.max(np.log(curve)[7000:7500]))/2)
signal_limits = []
l = 0
for curve in Y:
    i = 1
    j = 1
    k = 1
    for data in curve[1:length]:
        if np.log(data) < limits[l] and np.log(i) < limits[l] and np.log(j) < limits[l]:
            signal_limits.append(k)
            break;
        j = i
        i = data
        k = k + 1
    l = l + 1
#%% Calculates time series parameters


mean = []
amp = []
rms = []
kurtosis = []
std = []
shape_factor = []
skewness = []
crest_factor = []
impulse_factor = []
j = 0
for i in Y:
    m = np.mean(i[1:signal_limits[j]])
    mean.append(m)
    s = np.std(i[1:signal_limits[j]])
    std.append(s)
    amp.append(i[1])
    r = np.sqrt(np.mean(np.array(i[1:signal_limits[j]])**2))
    rms.append(r)
    shape_factor.append(r/m)
    kurtosis.append(scipy.stats.kurtosis(i[1:signal_limits[j]]))
    skewness.append(scipy.stats.skew(i[1:signal_limits[j]]))
    impulse_factor.append(i[1]/m)
    crest_factor.append(i[1]/r)   
    j = j + 1
#%% Gets rid of bad data
j = 0
k = []
for i in mean:
    if i > 0.13 and j < 980:
        k.append(j)
    elif i < 0.09:
        k.append(j)        
    j = j + 1
 #%%   Gets rid of bad data
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    #concentrations.pop(i-j)
    amp.pop(i-j)
    Y.pop(i-j)
    mean.pop(i-j)
    kurtosis.pop(i-j)
    rms.pop(i-j)
    shape_factor.pop(i-j)
    skewness.pop(i-j)
    impulse_factor.pop(i-j)
    crest_factor.pop(i-j)
    std.pop(i-j)
    j = j + 1
#%% Gets rid of bad data
j = 0
k = []
for i in kurtosis:
    if i > -0.1:
        k.append(j)
    j = j + 1
 #%%   Gets rid of bad data
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    turbidity.pop(i-j)
    pH.pop(i-j)
    temperature.pop(i-j)
    conductivity.pop(i-j)
    larmor_frequencies.pop(i-j)
    trial_numbers.pop(i-j)
    times.pop(i-j)
    #concentrations.pop(i-j)
    amp.pop(i-j)
    Y.pop(i-j)
    mean.pop(i-j)
    kurtosis.pop(i-j)
    rms.pop(i-j)
    shape_factor.pop(i-j)
    skewness.pop(i-j)
    impulse_factor.pop(i-j)
    crest_factor.pop(i-j)
    std.pop(i-j)
    j = j + 1
#%% Calculates T2_times

T2_times = []
for i in parameters:
    T2_times.append(i)
larmor = []
for i in larmor_frequencies:
    larmor.append(float(i))
concentration = []
for i in concentrations:
    concentration.append(float(i))
T2 = []
for i in T2_times:
    T2.append(i[0])
#%% Creates dataset for ML model


X = [mean ,amp ,rms ,kurtosis, std, shape_factor, skewness, crest_factor, impulse_factor, temperature, pH, conductivity,T2]
features=['mean' ,'amplitude' ,'RMS' ,'kurtosis', 'standard deviation', 'shape factor', 
          'skewness', 'crest factor', 'impulse factor', 'water temperature',
         'pH', 'conductivity','T2']
X = np.array(X).transpose()
#%% Creates model predictions on dataset


y_pred_c = rf.predict(X)
#%% PLots predictions


plt.plot(np.arange(0,len(y_pred_c)),y_pred_c)
plt.savefig('creek_prediction.png', bbox_inches='tight', dpi=300)
plt.show()
#%% Calculate partial dependence
fig, ax = plt.subplots(figsize=(15, 10))
ax.set_title("Partial Dependence Plots")
a = PartialDependenceDisplay.from_estimator(
    estimator=rf,
    X=X,
    features=(0,1,2,3,4,5,6,7,8,9,10,11,12), # the features to plot
    random_state=5,
    ax=ax,
    feature_names=(['Mean' ,'Amplitude' ,'RMS' ,'Kurtosis', 'Standard Deviation', 'Shape Factor', 
          'Skewness', 'Crest Factor', 'Impulse Factor', 'Water Temperature',
         'pH', 'conductivity', 'T2'])
)
#%% Prepare to graph PDP


independent = []
dependent = []
j = 0
for i in a.pd_results:
    independent.append(a.pd_results[j]['values'][0])
    dependent.append(a.pd_results[j]['average'][0])
    j = j + 1
ind = []
for i in independent:
    temp = []
    for j in i:
        min_val = np.min(i)
        max_val = np.max(i)
        j = (j - min_val) / (max_val - min_val)
        temp.append(j)
    ind.append(temp)
#%% Get rid of bad data


a = np.argmax(y_pred_c)
times1 = []
for i in times:
    times1.append((i-times[0])/3600)
times1.pop(a)
y_pred_c.pop(a)
#%% Plot model predictions


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
plt.figure(figsize=(7.583, 3))
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
plt.grid(zorder=1)

#plt.scatter(times1[0:a],y_pred_c[0:a],zorder=2,color='C0')
#plt.scatter(times1[a:],y_pred_c[a+1:],zorder=2,color='C0')
plt.plot(times1,y_pred_c[0:1063],zorder=2,color='C0',linewidth=0.5)

plt.xlabel('time (hr)')
plt.ylabel('predicted Cu(II) ion concentration (mg/L)')
plt.savefig('predicted_magnetic_content.png',bbox_inches='tight',dpi=300)
plt.show()
#%% Plot conductivity data


from matplotlib.font_manager import FontProperties
plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
plt.figure(figsize=(6.5/2, 4))
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
plt.grid(zorder=1)
times1 = []
for i in times:
    times1.append((i-times[0])/3600)
con = []
for i in conductivity:
    con.append((i/1000))
plt.plot(times1,con,zorder=2)
plt.xlabel('time (hr)')
plt.ylabel('conductivity (mS)')
plt.savefig('conductivity.png',bbox_inches='tight',dpi=300)
plt.show()
#%% Plot conductivity and T2 Data


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
dev = 0.002899
fig, ax1 = plt.subplots(figsize=(6.8, 3))

ax2 = ax1.twinx()
#plt.plot(np.arange(len(y_pred)),y_pred-y_test, linestyle = 'dotted')
#plt.axhline(y = np.mean(y_pred-y_test))
ax1.grid(zorder=1)
ax1.plot(times1,parameters[0:len(times1)],zorder=2, color='C0', linewidth = 0.5, label='T2')
plt.axhline(np.mean(con)+3*dev,color='black',linestyle='--')
ax2.plot(times1,con[0:len(times1)],zorder=2, color='C1', linewidth = 0.5, label='conductivity')
plt.axhline(np.mean(con)-3*dev,color='black',linestyle='--',label='$\pm$3$\sigma$ of conductivity sensor')
ax1.set_xlabel('time (hr)')
ax1.set_ylabel('T2 time (s)')
#ax2.set_ylim(0,1.4)
ax2.set_ylabel('conductivity (mS)')
fig.legend(fontsize=9,facecolor="white",
           framealpha=1,ncol=1,bbox_to_anchor=(0.60, 0.37), loc='upper right')
plt.savefig('t2_creek.png',bbox_inches='tight',dpi=300)
plt.show()
#%% Plot T2 data
plt.plot(np.arange(0,len(T2_times)),T2_times)
plt.xlabel('trial number')
plt.ylabel('T2 time (s)')
plt.savefig('creek_t2_time.png')
plt.show()
#%% Calculate importances


importances = rf.feature_importances_
std = np.std([tree.feature_importances_ for tree in rf.estimators_], axis=0)
#%% plot importances


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
forest_importances = pd.Series(importances, index=features)

fig, ax = plt.subplots()
ax.figsize=(6.5, 3)
forest_importances.plot.bar(yerr=0, ax=ax)
ax.set_ylabel("feature importance")
#ax.set_xlabel("feature")
plt.savefig('feature_importance_creek.png', bbox_inches='tight',dpi=300)
fig.tight_layout()
plt.show()
#%% plot PDP


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
plt.figure(figsize=(7.45, 2))

j = 10
#while j < len(ind):
#    plt.plot(ind[j],dependent[j],label=features[j])
#    j = j + 1
plt.plot(ind[j],dependent[j],label=features[j])
j = 11
plt.plot(ind[j],dependent[j],label=features[j])
j = 12
plt.plot(ind[j],dependent[j],label=features[j])
j = 9
plt.plot(ind[j],dependent[j],label=features[j])
plt.legend(title='Parameter',fontsize=9,facecolor="white",
           framealpha=1,ncol=2,bbox_to_anchor=(1,0.4), loc='lower right')
#plt.legend(bbox_to_anchor=(1.0, 1), loc='upper left')
plt.grid()
plt.xticks(np.arange(0, 1.01, 0.2))
plt.xlabel('scaled predictor value')
plt.xlim(xmin=0, xmax=1)
#plt.ylim(ymin=1.869)
plt.ylabel('Cu(II) ion concentration (mg/L)')
plt.savefig('partial_dependence_creek.png', bbox_inches='tight', dpi=300)
plt.show()
#%% Re-calculate time series parameters and normalize them


j = 0
k = []
i = 0
while i < len(parameters):
    #parameters[i] = parameters[i][0]
    i = i + 1
for i in parameters:
    if i > 4:
        k.append(j)
    if i < 0.6:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    Y.pop(i-j)
    amp.pop(i-j)
    j = j + 1
j = 0
k = []
i = 0
while i < len(parameters):
    i = i + 1
for i in amp:
    if i > 0.4:
        k.append(j)
    if i < 0.1:
        k.append(j)
    j = j + 1
j = 0
for i in k:
    #Larmor.pop(i-j)
    parameters.pop(i-j)
    Y.pop(i-j)
    amp.pop(i-j)
    j = j + 1
amp = []
for i in Y:
    amp.append(i[1])
#%%
m = normalize_array(mean)
a = normalize_array(amp)
r = normalize_array(rms)
k = normalize_array(kurtosis)
s = normalize_array(std)
sf = normalize_array(shape_factor)
sk = normalize_array(skewness)
cf = normalize_array(crest_factor)
i = normalize_array(impulse_factor)
t = normalize_array(temperature)
p = normalize_array(pH)
tur = normalize_array(turbidity)
c = normalize_array(conductivity)
T = normalize_array(T2_times)
norms = []
norms.append(m)
norms.append(a)
norms.append(r)
norms.append(k)
norms.append(s)
norms.append(sf)
norms.append(sk)
norms.append(cf)
norms.append(i)
norms.append(t)
norms.append(p)
#norms.append(tur)
#norms.append(c)
#norms.append(T)
time = []
for i in times:
    time.append((i-times[0])/3600)
#%% Plot normalized time series parameters


plt.rcParams.update({'font.size': 9})  # increase the font size
plt.rcParams['font.family'] = 'Serif'
sf = 0.8
fig, ax = plt.subplots(figsize=(6.56, 4))

j = len(norms)-1
for i in norms:
    if j < 9:
        plt.plot(time,norms[j]+j,label=features[j],linewidth=0.5)
    if j >= 9:
        plt.plot(time,norms[j]+j,label=features[j],linewidth=0.5, linestyle='--')
    j = j - 1
#plt.plot(np.arange(0,len(norms[j])),norms[j]+1,label=features[j],linewidth=0.5)
#j = 8
#plt.plot(np.arange(0,len(norms[j])),norms[j]+2,label=features[j],linewidth=0.5,color='red')
#j = 6
#plt.plot(np.arange(0,len(norms[j])),norms[j]+3,label=features[j],linewidth=0.5,color='black')
#ax.legend(title='Parameter',fontsize=9,facecolor="white",
#          framealpha=1,ncol=4,bbox_to_anchor=(0.045,1.28), loc='upper left')

#plt.legend(bbox_to_anchor=(1.0, 1), loc='upper left')
ax.grid()
#plt.xticks(np.arange(0, 1.01, 0.2))
plt.xlabel('time (hr)')
plt.ylim(ymin=0)
plt.yticks(np.arange(0.5,11.5,1),features[0:11])
plt.ylabel('normalized feature value')
plt.savefig('creek_norms.png', bbox_inches='tight',dpi=300)
plt.show()
#%% Save data to CSV


j = 0
with open('t2_curves.csv', 'w',newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerow(Y)
j = j + 1
import csv

j = 0
for i in X:

    with open(features[j] + '.csv', 'w',newline='') as csvfile:
        csv_writer = csv.writer(csvfile)
        for val in i:
            csv_writer.writerow([val])
    j = j + 1
    
with open('time.csv', 'w',newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    for val in time:
        csv_writer.writerow([val])