#import "lib.typ": *

== Results

In this section all the measurement results are listed and discussed. The results go over the effect of the different MediaPipe Pose models (`LITE`, `FULL`, and `HEAVY`) and the accuracy and frame rate that was achieved. All measurements are performed with `GL version: 3.2 (OpenGL ES 3.2 NVIDIA 550.78)` on a ` NVIDIA GeForce RTX 2060` GPU and an `Intel(R) Core(TM) i7-9750H (12) @ 2,60 GHz` CPU, unless specified otherwise. The actual inference is executed on the GPU while the rest of the application just runs on the CPU with minimal overhead. It is the inference that is the most time-consuming element.

The results discuss the accuracy and signal stability of the MediaPipe result, as well as some aspects that affect the signal. The accuracy is the deviation from the MediaPipe recordings using the techniques from the previous chapter. The signal stability is the absolute value of the derivates of these deviations. The derivative is numerically computed by taking the difference of two succeeding deviation values. By taking the absolute value, we get a measure of how much the deviation differs per frame and thus how stable the signal is. The lower this value, the better the signal stability. All of these values are taken per frame and per tracked marker. They are then described in box plots with a corresponding table. Indicating the mean, standard deviation, min, max, and some percentiles.
Since there is too much data to be included in this thesis text, all measurement results are made publicly available on a GitHub repository.
#footnote[Follow this link to the GitHub repository: #link("https://github.com/Mouwrice/DrumPyAnalysis")[Mouwrice/DrumPyAnalysis #link-icon]. All measurement results are located in the `measurements` folder. Every measurement is in a separate folder, with the folder name being a very brief description of the measurement. Inside every measurement folder are the actual results, grouped by the MediaPipe model that was used.]



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
    table.header[Stability (mm)][X][Y][Z],
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

MediaPipe has three different models available, each with a different size. The larger the model, the more accurate it results should be since the inference model has a larger network that does the inference. Using a larger model negatively impacts the real-time performance, of course. Comparing these different models, we found that the average accuracy does not drastically increase given a large model. The achievable frame rate, however, can drop significantly given these large models, dependent on the hardware used.

For each model, 3 results are provided, each result being from one specific recording. The recordings are all drumming motions but with increasing levels of intensity. The first recording is of small movements (`maurice_drum_small`). The second one features normal movements (`maurice_drum_regular`) and the last one contains fast and big movements (`maurice_drum_fast`). The accuracy is taken from a total of 10 tracked markers, being the `Left Elbow`, `Right Elbow`, `Left Wrist`, `Right Wrist`, `Left Hip`, `Right Hip`, `Left Heel`, `Right Heel`, `Left Foot Index`, `Right Foot Index`.

==== LITE

The `LITE` model is 3 MB in size and is the smallest model available.

The total deviation of all three recordings are displayed in @mau-drum-small-lite-total, @mau-drum-regular-lite-total, and @mau-drum-fast-lite-total, respectively. We can immediately draw some conclusions from these results. The Y and Z axis (horizontal and vertical) have a relatively good accuracy compared to the x-axis (depth). The depth is actually very imprecise and unstable, having a high mean deviation and a high standard deviation makes this depth not very usable. It also indicates that the wider the range of movements and the speed at which they are performed results in a slight drop in accuracy. Almost all deviation values are slightly higher than their corresponding values from a recording featuring less and slower movement.

Despite the x-axis being very imprecise, the Y and Z axis consistently achieve an accuracy of minimum 1 centimetre. For an air drumming application, this level of accuracy is already pretty usable.

#show table.cell.where(x: 0): set text(weight: "bold")


#figure(
  caption: [The total deviation from the `maurice_drum_small` measurement. Model: `LITE`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],    [ 46.216412],     [ 6.504117],     [ 8.755020],
    [std ],    [ 52.435068],     [ 8.534992],     [ 9.435842],
    [min ],    [  0.000424],     [ 0.001266],     [ 0.000092],
    [25% ],    [  7.747909],     [ 1.523800],     [ 2.533034],
    [50% ],    [ 26.830197],     [ 3.518769],     [ 5.717354],
    [75% ],    [ 65.330929],     [ 7.591232],     [10.964000],
    [max ],    [304.913545],     [91.105333],     [69.909789],
  )
] <mau-drum-small-lite-total>

#figure(
  caption: [The total deviation from the `maurice_drum_regular` measurement. Model: `LITE`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],   [ 44.065230],    [  6.498654],    [ 10.911481],
    [std ],   [ 55.829339],    [  7.804492],    [ 12.150179],
    [min ],   [  0.000830],    [  0.000079],    [  0.000673],
    [25% ],   [  8.900595],    [  2.055750],    [  3.500705],
    [50% ],   [ 24.601205],    [  4.378533],    [  7.580231],
    [75% ],   [ 57.471564],    [  8.009390],    [ 13.549875],
    [max ],   [460.941039],    [164.103709],    [140.990013],
  )
] <mau-drum-regular-lite-total>

#figure(
  caption: [The total deviation from the `maurice_drum_fast` measurement. Model: `LITE`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 64.872857],    [  7.181918],    [ 10.046277],
    [std ],      [ 70.935324],    [  9.058099],    [ 14.284985],
    [min ],      [  0.006952],    [  0.000276],    [  0.000796],
    [25% ],      [  9.690526],    [  2.168622],    [  2.386345],
    [50% ],      [ 31.462373],    [  4.908393],    [  5.571245],
    [75% ],      [113.099430],    [  8.903545],    [ 12.760656],
    [max ],      [680.599720],    [226.170262],    [592.765323],
  )
] <mau-drum-fast-lite-total>


==== FULL

The `FULL` models is double the size of the `LITE` model, at 6 MB. But that does not mean the deviation is halved. Compared to the `LITE` model, the average accuracy is increased by 1 and at most 2 mm. The standard deviation is reduced a bit using this heavier model. Some outlier values are also reduced. This indicates that the `FULL` model provides a cleaner result but only with a marginal increase in accuracy.

#figure(
  caption: [The total deviation from the `maurice_drum_small` measurement. Model: `FULL`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 40.883051],     [ 5.702290],     [ 7.874736],
    [std ],      [ 50.636690],     [ 6.940303],     [ 8.912165],
    [min ],      [  0.000027],     [ 0.000366],     [ 0.000008],
    [25% ],      [  5.576486],     [ 1.458272],     [ 2.017663],
    [50% ],      [ 19.581533],     [ 3.285286],     [ 4.814794],
    [75% ],      [ 56.780453],     [ 7.264643],     [ 9.913902],
    [max ],      [309.870406],     [75.601338],     [82.893488],
  )
] <mau-drum-small-full-total>

#figure(
  caption: [The total deviation from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 44.054789],     [ 5.877316],     [10.028784],
    [std ],      [ 52.458578],     [ 6.611694],     [10.963382],
    [min ],      [  0.000578],     [ 0.000225],     [ 0.001258],
    [25% ],      [  8.880800],     [ 1.829242],     [ 2.919620],
    [50% ],      [ 24.080457],     [ 4.135115],     [ 6.481524],
    [75% ],      [ 64.801731],     [ 7.475370],     [13.322674],
    [max ],      [423.136841],     [68.750352],     [91.792725],

  )
] <mau-drum-regular-full-total>

#figure(
  caption: [The total deviation from the `maurice_drum_fast` measurement. Model: `FULL`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 57.356438],    [  6.444404],    [  9.623760],
    [std ],      [ 71.275673],    [  8.949972],    [ 15.462130],
    [min ],      [  0.002776],    [  0.001176],    [  0.000118],
    [25% ],      [  5.237184],    [  1.277760],    [  1.798388],
    [50% ],      [ 17.238973],    [  3.093675],    [  4.298769],
    [75% ],      [102.966444],    [  7.503870],    [ 11.247950],
    [max ],      [679.421116],    [117.911612],    [586.803848],
  )
] <mau-drum-fast-full-total>


==== HEAVY

The `HEAVY` model is the largest of them all at a size of 26 MB. At this level, we have clearly reached a point of diminishing returns. Despite increasing the model size by a factor of 4, the improvements are not a big jump up. The jump in accuracy from `FULL` to `HEAVY` is similar to the jump from `LIGHT` to `FULL`, again increasing the accuracy by 1 mm. The x-axis also gets an increase in accuracy but proves to still be too unstable and imprecise to be of any use. At this point, the axis lateral to the image frames (Y and Z) are considerably accurate, reaching an average accuracy of 5 and 7 mm respectively. Just as with the smaller models, larger movements lead to a slight drop in accuracy, there is especially an increase in outliers.

#figure(
  caption: [The total deviation from the `maurice_drum_small` measurement. Model: `HEAVY`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 38.662930],     [ 4.880106],     [ 6.931904],
    [std ],      [ 46.034748],     [ 6.095308],     [ 7.833226],
    [min ],      [  0.000757],     [ 0.000524],     [ 0.000945],
    [25% ],      [  5.908032],     [ 1.228680],     [ 1.864810],
    [50% ],      [ 17.719570],     [ 2.879538],     [ 3.958334],
    [75% ],      [ 61.890476],     [ 5.876115],     [ 8.929086],
    [max ],      [293.278487],     [90.609627],     [65.955275],
  )
] <mau-drum-small-heavy-total>

#figure(
  caption: [The total deviation from the `maurice_drum_regular` measurement. Model: `HEAVY`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 48.331793],     [ 5.311494],     [ 9.191098],
    [std ],      [ 66.957378],     [ 6.810102],     [10.310719],
    [min ],      [  0.006057],     [ 0.000938],     [ 0.000114],
    [25% ],      [  9.469759],     [ 1.529734],     [ 2.387941],
    [50% ],      [ 25.329217],     [ 3.363876],     [ 5.430044],
    [75% ],      [ 61.941299],     [ 6.533454],     [12.837094],
    [max ],      [622.943655],     [67.798017],     [90.548038],
  )
] <mau-drum-regular-heavy-total>

#figure(
  caption: [The total deviation from the `maurice_drum_fast` measurement. Model: `HEAVY`, Marker type: `Landmark`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Deviation (mm)][X][Y][Z],
    [mean],      [ 61.698936],    [  5.610732],    [  7.894003],
    [std ],      [ 69.377889],    [  7.535471],    [ 12.391467],
    [min ],      [  0.007052],    [  0.000091],    [  0.000255],
    [25% ],      [  7.327052],    [  1.214547],    [  1.887956],
    [50% ],      [ 25.502218],    [  2.906578],    [  4.056903],
    [75% ],      [112.404883],    [  7.307336],    [  9.338038],
    [max ],      [678.986135],    [121.335236],    [587.988858],
  )
] <mau-drum-fast-heavy-total>


==== Signal stability

One metric that has been left out, so far, is the signal stability. The deviation tables above hint that a heavier model might not just provide a small increase in accuracy, but also provide an increase in signal stability. This is hinted at by the lower standard deviation and the lower 75% percentile values.
Having a more stable signal, meaning less outliers and a more consistent deviation difference between frames, is also an important aspect. The following tables plot the signal stability for every model on the `maurice_drum_regular` measurement. Remember that the signal stability is calculated as the absolute difference in deviation between consecutive frames, the lower the values the better.


#figure(
  caption: [The signal stability from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Stability (mm)][X][Y][Z],
    [mean],     [  7.764771],    [  1.352941],    [  2.096501],
    [std ],     [ 10.085330],    [  2.809363],    [  4.220660],
    [min ],     [  0.000014],    [  0.000023],    [  0.000073],
    [25% ],     [  1.026297],    [  0.208817],    [  0.217875],
    [50% ],     [  3.969899],    [  0.595858],    [  0.739438],
    [75% ],     [ 10.707028],    [  1.440624],    [  2.116421],
    [max ],     [118.670178],    [116.634008],    [107.199950],
  )
] <drum-regular-lite-sta-table>

#figure(
  caption: [The signal stability from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Stability (mm)][X][Y][Z],
    [mean],     [  7.579568],     [ 1.106332],     [ 1.694458],
    [std ],     [ 10.574589],     [ 2.057231],     [ 3.608910],
    [min ],     [  0.000109],     [ 0.000078],     [ 0.000012],
    [25% ],     [  0.752476],     [ 0.165129],     [ 0.176408],
    [50% ],     [  3.633556],     [ 0.468424],     [ 0.560157],
    [75% ],     [ 10.260663],     [ 1.137847],     [ 1.569148],
    [max ],     [112.231639],     [46.151331],     [52.179156],
  )
] <drum-regular-full-sta-table>

#figure(
  caption: [The signal stability from the `maurice_drum_regular` measurement. Model: `FULL`, Marker type: `Landmark`, Marker: `Left Wrist`.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Stability (mm)][X][Y][Z],
    [mean],     [  6.122471],     [ 0.979171],     [ 1.511921],
    [std ],     [  8.788107],     [ 1.873792],     [ 3.426255],
    [min ],     [  0.000077],     [ 0.000090],     [ 0.000053],
    [25% ],     [  0.736543],     [ 0.133611],     [ 0.139911],
    [50% ],     [  2.849786],     [ 0.392975],     [ 0.450573],
    [75% ],     [  8.104202],     [ 0.981124],     [ 1.274915],
    [max ],     [108.713253],     [40.173077],     [51.322185],
  )
] <drum-regular-heavy-sta-table>

@drum-regular-lite-sta-table, @drum-regular-full-sta-table and @drum-regular-heavy-sta-table clearly demonstrate that a larger model not only increases accuracy but also the signal stability. The effect is modest, with the most significant difference being the values going from the `LITE` model to the `FULL` model. This effect is also noticeable when viewing the inference visualization, where we can see that the `FULL` model provides a more stable result. The markers are less jittery and their movements are 'smoother'.


==== Conclusion

Now that we have compared the accuracy of all three models, we have a clear view of the expected accuracy.
For any lateral movement, that is movement lateral to the image frame, the horizontal and vertical axis, an accuracy of 5-10 mm can be achieved with some deviations from that accuracy of at most 1 centimetre. There is however also the possibility for some jitter to occur in the resulting signal which can some major deviations from the actual movement, but these are only of short duration.

The depth axis, the x-axis, is considerably less accurate. The accuracy is around 40-60 mm with some deviations of up to 100 mm. The depth is as mentioned _"obtained via the GHUM model fitted to 2D point porjections."_ Unfortunately, this depth is not very usable for an air drumming application. The depth is also very unstable, with a high standard deviation and a high number of outliers. This is especially the case when the movements are fast and big.

Comparing the models, there is little accuracy to be gained from choosing a larger model. However, larger models provide a more stable signal, which can be essential as the drumming application mostly looks at the relative movements instead of absolute values.  As we are developing an application to be used live, the largest model that can achieve real-time inference is preferred. The inference time is of course dependent on the hardware, which means that in some cases the `HEAVY` model can be used but in other cases the `LITE` model is the only one that can be properly run in real-time, @inference-time.


=== Achievable framerate <inference-time>

The frame rate that can be achieved should be high enough for a proper real-time application. The higher the frame rate, the more responsive the application will feel and the more accurate the tracking can be. A higher frame rate also allows for faster motions to be captured, which is handy in the case of fast drumming motions. The frame rate is dependent on the hardware used, but also on the model that is used. The larger the model, the more computationally expensive it is to run the inference. The following table (@framerate-table) lists the maximum frame rate that can be achieved for each model, as well as the device that was used to run the inference.


#figure(
  caption: [The maximum framerate (fps) that can be achieved for each model with different devices.],
  placement: none
)[
  #table(
    columns: (auto, 2fr, 2fr, 2fr),
    align: (left, right, right, right),
    table.header[Device (fps)][`LITE`][`FULL`][`HEAVY`],
    [CPU Intel Core i7-10750H], [25], [20], [7],
    [GPU Intel UHD Graphics 630], [19], [17], [11],
    [CPU AMD Ryzen 5 5600X], [40], [30], [10],
    [GPU NVIDIA RTX 2060], [45], [42], [40],
  )
] <framerate-table>

The table shows that the `LITE` model can be run in real-time on all devices. The `FULL` model can also be run in real-time on most devices, but the `HEAVY` model is too computationally expensive to run in real-time on most devices. The `HEAVY` model can only be run in real-time on the NVIDIA RTX 2060 GPU. It is no surprise that the GPU is the most performant of the four devices. However, despite being able to run the `HEAVY` model at a constant 40 fps, the GPU's performance on the smaller models is surprisingly not a lot higher. We can conclude that the GPU has a lot of power but lacks the speed of a CPU
#footnote[A CPU typically has a higher clock speed than a GPU, allowing to perform many more consecutive operations per second. A GPU is mainly designed to perform many operations simultaneously.
], hence the good results for the `HEAVY` model and the not much improved results for the smaller models. This difference between power and speed also becomes apparent when comparing the Intel Core i7-10750H and the AMD Ryzen 5 5600X. The AMD Ryzen 5 5600X has a higher clock speed and can run the `FULL` model at 30 fps, while the Intel Core i7-10750H can only run the `FULL` model at 20 fps. The `HEAVY` model is too computationally expensive for both devices.
On the `LITE` model, however, they are on par with the GPU's. The Intel Core i7-10750H can run the `LITE` model at 25 fps, while the AMD Ryzen 5 5600X can run the `LITE` model at 40 fps. The Intel UHD Graphics 630 and the NVIDIA GeForce 2060 GPU can run the `LITE` model at 19 and 45 fps respectively. 

The conclusion is that the `FULL` model is the best model to use for real-time applications. It provides a good balance between accuracy and frame rate. The `HEAVY` model is too computationally expensive to run in real-time on most devices, while the `LITE` model is somewhat unstable to rely on. The `FULL` model can be run in real-time on most (modern) devices, providing a good balance between accuracy and frame rate.
If the device is not powerful enough to run the `FULL` model in real-time, the `LITE` model can be used as a fallback.


=== Jitter

One aspect that leads to a less stable signal is jitter. Jitter is the sudden, unintended variation in the position of a tracked marker. In the recordings, we see that this jitter mostly occurs when the tracked body part is either fast-moving or occluded in any way. This is mostly present when crossing arms in our recordings. As shown in @jitter-example-right-wrist, the jitter is clearly visible around the 20-second mark. This jitter is not present in all recordings but is a factor that can lead to a less stable signal. Jitter occurs less frequently in the larger models, which partly explains the increased signal stability using these models. When developing an application that relies on the stability of the signal, it is important to acknowledge that jitter can occur and that it can lead to a less stable signal.

#figure(
  caption: [A case of jitter in the `maurice_drum_fast` measurement around the 20 seconds mark. Model: `LITE`, Marker type: `Landmark`, Marker: `Right Wrist`.],
  placement: none,
)[
  #image("measurements/maurice_drum_fast/LITE/Right_Wrist_y.svg")
] <jitter-example-right-wrist>


=== Noise

Another aspect that can lead to a less stable signal is noise. Noise is the random variation in the position of a tracked marker. This noise is mostly present when the tracked body part is not moving at all. It can be seen in the trajectories that larger models produce a less noisy signal than smaller models. This is shown in @noise-example-right-heel. The noise is clearly visible in the `LITE` model, while the `FULL` and `HEAVY` models have a much more stable signal. It should be noted that the noise is rather small and is still in line with the accuracy values that were discussed earlier. The signal stability tables also clearly show that the noise is present in the `LITE` model but is reduced in the `FULL` and `HEAVY` models. (@noise-example-right-heel-stability)

#show table.cell.where(x: 0): set text(weight: "bold")
#figure(
  caption: [The signal stability from a noisy signal in the the `maurice_drum_regular` measurement. Models: `LITE`, `FULL`, `HEAVY`. Marker type: `Landmark`. Marker: `Right Heel`.],
  placement: auto,
  grid(
  columns: (auto),
  rows: (auto, auto, auto),
  gutter: 1em,
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),

      table.header[`LITE` Stability][X][Y][Z],
      [mean],      [8.537066],     [1.053139],     [2.158305],
      [std ],      [8.288110],     [1.261807],     [2.967522],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`FULL` Stability][X][Y][Z],
      [mean],      [6.025950],     [0.589802],     [1.300819],
      [std ],      [8.030914],     [0.914598],     [2.288527],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`HEAVY` Stability][X][Y][Z],
      [mean],      [5.830511],     [0.441127],    [1.026949],
      [std ],      [6.083284],     [0.685263],    [1.925742],
    )
  ],
  )
) <noise-example-right-heel-stability>

#figure(
  placement: auto,
  grid(
    columns: (auto, auto),
    rows: (auto, auto),
[#image("measurements/maurice_drum_regular/LITE/Right_Wrist_y.svg")
],
[#image("measurements/maurice_drum_regular/FULL/Right_Wrist_y.svg")
],
[#image("measurements/maurice_drum_regular/HEAVY/Right_Wrist_y.svg")
]
),
  caption: [A noisy signal in the `maurice_drum_regular` measurement. Models: `LITE` (top left), `FULL` (top right), `HEAVY` (bottom left). Marker type: `Landmark`. Marker: `Right Heel`.],
) <noise-example-right-heel>


=== Resolution

Following the description of the model network of the MediaPipe Pose Task, we know that the input has a fixed size of 256x256x3. This means that the resolution of the input image is 256x256 pixels. As a result of this fixed input size, we should see no significant difference in accuracy when using different resolutions. There might be a slight difference in the accuracy due to the image being resized to fit the input size, but this difference should be negligible. This hypothesis is tested by comparing the deviation of the `maurice_drum_regular` measurement at different resolutions. The resolutions used are 1080p, 720p, and 480p.
#footnote[The original measurement video was also captured in 1080p but was encoded again with the same encoding settings used to achieve the smaller resolution videos, except for the resolution, of course. This was done to make sure that the video quality and encoding are the same. It is also the reason for slightly different results for the 1080p resolution in previous tables, which the very attentive reader might have noticed.] The deviation values are shown in @resolution-deviations. The deviation values are very similar.
Thus follows that the resolution of the input image does not significantly affect the accuracy of the model. This is good news, as it means that the model can be used on different devices with different resolutions without a significant loss in accuracy.

#figure(
  caption: [The accuracy of different resolutions of the `maurice_drum_regular` measurement. Model: `FULL`. Marker type: `Landmark`.],
  placement: auto,
  grid(
  columns: (auto),
  rows: (auto, auto, auto),
  gutter: 1em,
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),

      table.header[`1080p` Deviation (mm)][X][Y][Z],
      [mean],   [40.076227],     [10.396079],     [12.230394],
      [std ],   [49.000929],     [10.724212],     [14.250999],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`720p` Deviation (mm)][X][Y][Z],
      [mean],   [39.937372],     [10.387030],     [12.473164],
      [std ],   [48.821626],     [10.771447],     [14.450003],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`480p` Deviation (mm)][X][Y][Z],
      [mean],  [41.670763],     [11.361194],     [11.975922],
      [std ],  [48.763101],     [11.131461],     [14.568390],
    )
  ],
  )
) <resolution-deviations>


=== World Landmarks

All previous results are from measurements with the `Landmark` as marker type. These are points that have coordinates in the image frame with an added depth value. MediaPipe also provides `WorldLandmarks` as a marker type. These are real-world 3D coordinates. The values are in meters and are relative to the midpoint between the hips. MediaPipe tries to predict the size of the person in the frame and uses this to scale the world landmarks. `WorldLandmarks` allows to decouple the marker locations from the image frame. With them, one can track the movements relative to the person instead of the image frame. This can be useful when the person is moving around in the frame or when the person is moving towards or away from the camera. As this adds another layer of uncertainty (the scale of the person in the frame is but a prediction), the accuracy of the `WorldLandmarks` is expected to be lower than the `Landmarks`.

The deviation values for the `WorldLandmarks` are shown in @world-landmarks-deviations. The deviation values are indeed higher than the deviation values for the `Landmarks`.
#footnote[Note that the depth values are somewhat improved with the `WorldLandmarks` marker type. This is attributed to a better scaling factor than the somewhat arbitrary scaling factor of 0.5 that was chosen in the x-axis alignment. The depth values are still as inaccurate as before, but the entire scaling of the depth axis is just a bit better. These `WorldLandmark` depth values would still converge to zero if the Golden-section search is applied.]
The same can be observed for the signal stability in @world-landmarks-stability. For the most accuracy tracking the regular `Landmarks` should be used. However, if the application requires tracking movements that are relative to the person instead of the image frame, then the `WorldLandmarks` need to be used. One might also opt for a combination of both, as MediaPipe always outputs both types of landmarks.

#figure(
  caption: [The accuracy of `WorldLandmarks` compared to the accuracy of `Landmarks`. Model: `FULL`. Measurement: `maurice_drum_regular`.],
  placement: none,
  grid(
  columns: (auto),
  rows: (auto, auto, auto),
  gutter: 1em,
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),

      table.header[`Landmark` Deviation (mm)][X][Y][Z],
      [mean],    [ 44.054789],     [ 5.877316],     [10.028784],
      [std ],    [ 52.458578],     [ 6.611694],     [10.963382],
      [min ],    [  0.000578],     [ 0.000225],     [ 0.001258],
      [25% ],    [  8.880800],     [ 1.829242],     [ 2.919620],
      [50% ],    [ 24.080457],     [ 4.135115],     [ 6.481524],
      [75% ],    [ 64.801731],     [ 7.475370],     [13.322674],
      [max ],    [423.136841],     [68.750352],     [91.792725],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`WorldLandmark` Deviation (mm)][X][Y][Z],
      [mean],    [ 40.064675],     [10.425273],    [ 12.136874],
      [std ],    [ 49.167113],     [10.624388],    [ 13.952320],
      [min ],    [  0.003811],     [ 0.000245],    [  0.001166],
      [25% ],    [  7.237019],     [ 3.242694],    [  2.720210],
      [50% ],    [ 22.192832],     [ 7.156534],    [  7.904396],
      [75% ],    [ 57.645794],     [13.916220],    [ 16.739466],
      [max ],    [364.849119],     [81.609742],    [147.278370],
    )
  ],
  )
) <world-landmarks-deviations>

#figure(
  caption: [The stability of `WorldLandmarks` compared to the stability of `Landmarks`. Model: `FULL`. Measurement: `maurice_drum_regular`.],
  placement: none,
  grid(
  columns: (auto),
  rows: (auto, auto, auto),
  gutter: 1em,
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),

      table.header[`Landmark` Stability (mm)][X][Y][Z],
      [mean],     [  7.579568],     [ 1.106332],     [ 1.694458],
      [std ],     [ 10.574589],     [ 2.057231],     [ 3.608910],
      [min ],     [  0.000109],     [ 0.000078],     [ 0.000012],
      [25% ],     [  0.752476],     [ 0.165129],     [ 0.176408],
      [50% ],     [  3.633556],     [ 0.468424],     [ 0.560157],
      [75% ],     [ 10.260663],     [ 1.137847],     [ 1.569148],
      [max ],     [112.231639],     [46.151331],     [52.179156],
    )
  ],
  [
    #table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[`WorldLandmark` Stability (mm)][X][Y][Z],
      [mean],      [ 3.967809],     [ 1.851960],     [ 2.493500],
      [std ],      [ 6.406780],     [ 2.779646],     [ 4.056749],
      [min ],      [ 0.000046],     [ 0.000069],     [ 0.000042],
      [25% ],      [ 0.377586],     [ 0.276647],     [ 0.221359],
      [50% ],      [ 1.447640],     [ 0.808166],     [ 0.881040],
      [75% ],      [ 4.694866],     [ 2.216550],     [ 3.038803],
      [max ],      [87.592255],     [29.960801],     [48.716450],
    )
  ],
  )
) <world-landmarks-stability>
