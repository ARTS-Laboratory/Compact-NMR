# Usage 

```
python cpmg.py <pulse_high_time> <tau> <duration> <output_file> [plot]
```

+ <pulse_time_high>: duration in microseconds of the 90 degree pulse. subsequent 180 degree pulses are twice this value
+ <tau>: duration in microseconds of tau. subsequent tau lengths are twice this value
+ <duration>: duration of the entire sequence. this value is in seconds.
+ <output_file>: name of the file in which the sequence is written to. this argument can also interpret relative paths.
+ [plot]: optional argument to display a plot of the first few pulses. if no argument is given, no plot will be displayed

## Examples

```
python cpmg.py 7 625 4 out.txt plot
```
Will generate and plot a 4 second sequence to 'out.txt' containing a 7us 90 degree pulse followed by 625us of low ties, then 14us of high, then 1250us of low, then 14us of high, then 1250us of low...

```
python cpmg.py 4 500 3.5 4us_90degree_.txt
```
Will generate,but not plot, a 3.5 second sequence to '4us_90degree.txt' containing a 4us 90 degree pulse followed by 500us of low ties, then 8us of high, then 1000us of low...
