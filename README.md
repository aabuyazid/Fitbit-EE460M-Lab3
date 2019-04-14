# Fitbit-EE460M-Lab3

## Guideline

This lab can be done with a partner.

## Objective

Your objective in this lab is to develop a simplified version of the activity tracking device, Fitbit, on FPGA
that implements a subset of features offered by the Fitbit device and App. A circuit that would provide
input pulses to your Fitbit module will also be synthesized and implemented in this lab.

## Description

The input to the Fitbit module is a sequence of pulses that denote the steps taken by an individual, the
system clock and reset. Your module is expected to output the following information on the 7-segment
display of the Basys board:

1. **Total step count** : One of the outputs of your implementation is the total step count i.e. the total
    number of steps or pulses that have been input to the system. Since the total number of steps
    that can be displayed are limited by the 7-segment display, your circuit will saturate at 9999 and
    would assert the signal SI to 1 as soon as the step count becomes more than 9999, indicating that
    the step count value being displayed is inaccurate and is more than the displayed value of 9999.
    Whenever reset is asserted, the step count will be set to 0000 and SI will go low if it was previously
    high. Note that the reset is active high.
2. **Distance covered** : The displayed value of distance covered should be as per the following
    criterion:
    2048 steps will constitute a mile for distance calculation assuming the size of the steps to be fixed
    at an average value. To make distance calculation in hardware simpler, you are required to display
    the distance in denominations of 0.5 miles i.e. 0.5 miles, 1.0 miles, 1.5 miles and so on. This is
    achieved by rounding down the actual distance covered to the nearest multiple of 0.5, so that the
    following are the display values for the total distance covered:
    [0,0.5) - > 0
    [0.5,1.0) - > 0.
    [1.0, 1.5) - > 1.
    [1.5, 2.0) - > 1.5 and so on.

```
Note that the correct distance should be displayed even when the display count for the number
of steps saturates at 9999.
```
3. **Steps over 32 /sec** : This exhibits how many of the first 9 seconds had an activity of over 32 steps
    per second. If out of the first 9 seconds of simulation, there are 4 seconds in which the number of
    steps taken is more than 32, then you should display 4 on the 4 - segment display. You should
    continue to hold this value on the display after 9 seconds as well, until reset is asserted. Once

# Lab Assignment #


```
reset is deasserted, the 9-second window will start again and you will display the number of
seconds out of the first 9 seconds after reset that had a step count greater than 32.
```
4. **High activity time greater than threshold** : The tracker should recognize and award active seconds
    when the activity being done is more strenuous than regular walking. The criterion for recognizing
    high activity time is “at least **a minute** of activity at a rate of 64 steps per second or more”. For
    e.g., if the tracker records an activity of 64 steps or more in a second for 60 continuous seconds
    for the first time, the high activity timer display should go from 0 to 60 seconds and the counter
    should increment per second for continued activity at a rate higher than 64 steps per second (60,
    61, 62...). It should freeze at the last time instant of high activity if the step rate goes below 64 at
    any second. If the high activity condition is encountered again, the previously frozen display
    should now account for the additional high activity time. Suppose the display was frozen at 67
    seconds, and high activity is determined again for the threshold 60-second interval, the display
    should go from 67 to 127 after high activity at the end of a minute is recorded.

```
Suppose there is activity at a rate equal to or higher than 64 steps per second for a period of 40
seconds, then a period of rest/low activity and then 30 seconds of activity at a rate higher than
64 steps/second, then no high activity time should be recorded.
```
**Display Specifications for the Fitbit tracker:**

Information from the Fitbit module should be displayed on the 7-segment display in a rotating fashion
with a period of 2 seconds. The display should follow the following sequence: Total step count, Distance
covered, Steps over 32(time), High activity time, Total step count, Distance covered...and so on, with each
piece of information being displayed for 2 seconds.

To display a decimal value like distance, represent the decimal point with a _. For e.g., 1.5 should be
represented as 1_5 on the display. You can choose to display a 0 or leave the upper unused digits unlit.

**Pulse generator:**

We require a pulse generator to model the steps taken by an individual. Your pulse generator will be
required to generate a sequence of pulses that will be fed to the Fitbit tracker module. Your generator
should start generating the pulses once the input START signal goes high. When the START signal goes
low, the generator should stop generating any more pulses. It should start afresh when the signal goes
high again. The generator should have at least 4 modes:

1. Walk mode (MODE = 2’b00): In this mode, the generator should output a sequence of pulses at a
    rate of 32 pulses/steps per second.
2. Jog mode (MODE = 2’b01): A sequence of pulses at the rate of 64 pulses/steps per second.
3. Run mode (MODE = 2’b10): A sequence of pulses at the rate of 128 pulses/steps per second.
    (MODE = 10)
4. Hybrid mode (MODE = 2’b11): The sequence of pulses should be as follows:


```
Time 1 st sec 2 nd sec 3 rd sec 4 th sec 5 th sec 6 th sec 7 th sec 8 th sec 9 th sec
```
```
No.of
pulses
```
#### 20 33 66 27 70 30 19 30 33

```
10 th-
73 rd
sec
```
```
74 th-
79 th
sec
```
```
79 th-
144 th
sec
```
```
145 th
sec
onwards
```
```
69 34 124 No
pulses
```
```
You can add other modes for testing your tracker, but the modes above are required to be present.
```
```
Mapping Information:
```
```
MODE – {Switch 3, Switch 2}
```
```
RESET – Switch 1
```
```
START – Switch 0
```
```
SI – LED 0
```
```
Fig. Block Diagram for a top module containing the pulse generator, Fitbit tracker and display controller
```
## Clarifications/Useful Information

1. The tracker can display a maximum step count of 9999. However, it should continue to display
    the correct value for distance, total activity time and high activity time.

PULSE (^)

### GENERATOR

### FITBIT

### TRACKER

### MODULE

### Binary to

### BCD

### Converter

### + BCD to

### 7 - seg

### Display +

### Mux

### START

### CLK, RESET

### To 7-

### Segment

### Display


2. The reset, when asserted, should clear the step counter, distance counter, steps over 32 time
    and high activity time and a 0000(or 0) should be displayed for each of them.
3. Check for the overflow condition (saturation at 9999) in your code and make sure it works.
4. Ensure that there are no inferred latches in your design when you implement it.
5. It is okay if certain display information is updated by your Fitbit module after a constant time
    lag, which you will need to update the registers in your module. This can be made very low by
    using clock(s) with higher frequencies.

## Submission Details

All parts of this lab are to be submitted on Canvas. No hard-copy submission is needed.

1. All Verilog code
2. Bit file and XDC file



