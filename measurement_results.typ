#import "lib.typ": *

== Results

In this section all the measurement results are listed and discussed. The results go over the effect of the different MediaPipe Pose models (LITE, FULL, and HEAVY) and the accuracy and frame rate that was achieved. All measurements are performed with `GL version: 3.2 (OpenGL ES 3.2 NVIDIA 550.78)` on an ` NVIDIA GeForce RTX 2060` GPU and a `Intel(R) Core(TM) i7-9750H (12) @ 2,60 GHz` as CPU, unless specified otherwise. The actual inference is executed on the GPU while the rest of the application just runs on the CPU with minimal overhead. It is the inference that is the most time-consuming element.

The results discuss the accuracy and signal stability of the MediaPipe result. The accuracy is the deviation from the MediaPipe recordings using the techniques from the previous chapter. The signal stability is the absolute value of the derivates of these deviations. The derivative is numerically computer by taking the difference of two succeeding deviation values. By taking the absolute value, we get a measure of how much the deviation differs per frame and thus how stable the signal is. The lower this value, the better the signal stability. All of these values are taken per frame and per tracked marker. They are then described in box plots with a corresponding table. Indicating the mean, standard deviation, min, max, and some percentiles.
Since there is too much data to be included in this thesis text, all measurements are made publicly available on a GitHub repository.
#footnote[Follow this link to the GitHub repository: #link("https://github.com/Mouwrice/DrumPyAnalysis")[Mouwrice/DrumPyAnalysis #link-icon]. All measurement results are located in the `measurements` folder. Every measurement is in a separate folder with the folder name being a very brief description of the measurement. Inside every measurement folder are the actual results grouped by the MediaPipe model that was used.]

To further reduce on data presented in this text, the discussed metrics of each marker are combined into one per measurement. That way, it is also more convenient to address the total accuracy and stability of the signal over a given measurement.

=== Results Example

To further clarify the results in the coming sections, consider the following example. It is a measurement of an air drumming recording which has been tracked by both Qualisys and MediaPipe. The MediaPipe `FULL` model has been used, together with the regular `Landmark` marker type.
#footnote[The complete results of the example here are from the following measurement: #link("https://github.com/Mouwrice/DrumPyAnalysis/tree/main/data/measurements/maurice_drum_regular/FULL")[https://github.com/Mouwrice/DrumPyAnalysis/tree/main/data/measurements/maurice_drum_regular/FULL #link-icon]]

The trajectory of the left wrist marker can be plotted, e.g. the trajectory along the z-axis (vertical axis) in @maurice-drum-regular-left-wrist-full-landmark.

The deviations are plotted in a box plot (@maurice-drum-regular-left-wrist-full-landmark-deviation), as well as the stability of the signal (@maurice-drum-regular-left-wrist-full-landmark-stability).

Lastly, the deviation and stability values are also made available by describing them in a tabular format as shown in @drum-regular-dev-table and @drum-regular-sta-table.

#figure(
  caption: [The trajectory along the z-axis (vertical axis) of the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #image("measurements/maurice_drum_regular/Left Wrist_Axis.Z_positions.svg")
] <maurice-drum-regular-left-wrist-full-landmark>


#figure(
  caption: [Per axis deviation of the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none,
)[
  #image("measurements/maurice_drum_regular/Left Wrist_deviations_seperate.png")
] <maurice-drum-regular-left-wrist-full-landmark-deviation>

#figure(
  caption: [Signal stability of the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #image("measurements/maurice_drum_regular/Left Wrist_signal_stability.png")
] <maurice-drum-regular-left-wrist-full-landmark-stability>

#show table.cell.where(x: 0): set text(weight: "bold")
#figure(
  caption: [The deviation of the signal from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean], [50.453455],[8.921537],[16.330614],
    [std],  [59.822373],  [9.993484],   [15.278144],
    [min],  [0.048005],   [0.002286],   [0.001623],   
    [25%],  [16.249777],  [2.189822],   [7.440695],  
    [50%],  [34.482323],  [5.407212],   [11.327267],
    [75%],  [62.916892],  [11.654837],  [18.541468], 
    [max],  [376.630114], [63.694605],  [87.138306]
  )
]<drum-regular-dev-table>

#show table.cell.where(x: 0): set text(weight: "bold")
#figure(
  caption: [The signal stability from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Stability][X][Y][Z],
[mean],    [ 13.498988],    [ 1.621383],    [ 2.256355],
[std] ,    [ 14.644994],    [ 2.919033],    [ 4.950195],
[min] ,    [  0.000851],    [ 0.000011],    [ 0.000156],
[25%] ,    [  3.090311],    [ 0.238420],    [ 0.163133],
[50%] ,    [  8.675376],    [ 0.552805],    [ 0.459906],
[75%] ,    [ 18.577672],    [ 1.355008],    [ 1.632371],
[max] ,    [111.856248],    [27.770244],    [52.482742],
  )
] <drum-regular-sta-table>




=== Effect of the models

MediaPipe has three different models available, each with a different size. The larger the model, the more accurate it results should be since the inference model has a larger network that does the inference. Using a larger model negatively impacts the performance, of course. Comparing these different models, we found that the average accuracy does not drastically increase given a large model. The achievable frame rate, however, can drop significantly given these large models, dependent on the hardware used.

==== LITE

