== Results

The following section compares the results achieved by the method with measurements without any post-processing. Results of recordings at 30  fps and 60 fps are discussed, as well as the impact of the memory size of the method.

=== 30 fps

The `maurice_drum_fast` recording at 30 fps is used to compare the results. The method is applied to the recording and the results are compared to the original measurements.

The parameters are set to a memory size of 2 frames, the peak $d = 0.015$, and the tightness $s = 0.7$. Visually, these parameters produce the best results. The noise is reduced, and the jitter is less pronounced, while still allowing a given range of motion. To confirm that the method does, in fact, reduce these elements, we should expect to see a better signal stability. @maurice_drum_fast_stability_30fps shows the stability of the signal with and without processing. For the Y and Z axis, the mean is reduced by around 0.5 mm. The impact of the method on the stability is most noticeable in the percentiles. There we can observe reductions ranging from 0.5 mm to 1.8 mm. This impact is better displayed in the box plots from @maurice_drum_fast_stability_30fps-boxplot. The box plot shows the distribution of the signal stability. The processed signal has a smaller range and a smaller median. The outliers are also reduced. The method has a positive impact on the signal stability.

One might argue that the X axis is also improved. However, given the results from the measurement chapter, we know that the X axis is far from accurate. The increase in stability for the X axis is purely attributed to the method reducing the noise and jitter. The method does not improve the actual accuracy of the X axis, even though the results might suggest otherwise.


#show table.cell.where(x: 0): set text(weight: "bold")
#figure(
  caption: [The signal stability from the `maurice_drum_fast` measurement without processing (top) and with processing (bottom). Model: `LITE`, Marker type: `Landmark`],
  placement: none,
  grid(
    columns: (auto),
    rows: (auto, auto, auto),
    gutter: 1em,
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Stability unprocessed (mm)][X][Y][Z],
        [mean],     [  9.230469],    [  1.814981],    [  2.656927],
        [std ],     [ 13.762306],    [  4.700073],    [  8.271183],
        [min ],     [  0.000365],    [  0.000031],    [  0.000004],
        [25% ],     [  1.143315],    [  0.210036],    [  0.251675],
        [50% ],     [  4.848148],    [  0.634218],    [  0.849195],
        [75% ],     [ 13.118014],    [  1.727039],    [  2.558757],
        [max ],     [676.041508],    [180.404176],    [592.605731],
      )
    ],
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Stability processed (mm)][X][Y][Z],
        [mean],     [  5.940251],    [  1.419173],    [  2.109245],
        [std ],     [  9.745013],    [  3.663793],    [  8.273394],
        [min ],     [  0.000060],    [  0.000002],    [  0.000004],
        [25% ],     [  0.870641],    [  0.072621],    [  0.070995],
        [50% ],     [  3.905946],    [  0.258439],    [  0.251171],
        [75% ],     [  9.016494],    [  0.967466],    [  1.169109],
        [max ],     [674.856917],    [116.912891],    [593.312640],
      )
    ]
  )
) <maurice_drum_fast_stability_30fps>

#figure(
  caption: [The signal stability from the `maurice_drum_fast` measurement in a boxplot, without processing (top) and with processing (bottom). Model: `LITE`, Marker type: `Landmark`],
  placement: auto,
  grid(
    columns: (auto),
    rows: (auto, auto, auto),
    [
      #image("../images/measurements/maurice_drum_fast/LITE/total_signal_stability.png"
      )
    ],
    [
      #image("../images/measurements/maurice_drum_fast_processed/LITE/total_signal_stability.png"
      )
    ]
  )
) <maurice_drum_fast_stability_30fps-boxplot>

Before we conclude that the method achieves its goal, we should also consider the impact of the method on the accuracy. 
#footnote[Remember that the accuracy has been defined as the deviation from the Qualisys recordings.]
@maurice_drum_fast_dev_30fps clearly shows that the method has no negative impact on the accuracy. The accuracy is ever so slightly improved, but the improvement is not significant enough to conclude that the method improves the accuracy.


#figure(
  caption: [The deviation from the `maurice_drum_fast` measurement without processing (top) and with processing (bottom). Model: `LITE`, Marker type: `Landmark`],
  placement: none,
  grid(
    columns: (auto),
    rows: (auto, auto, auto),
    gutter: 1em,
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Deviation unprocessed (mm)][X][Y][Z],
        [mean],  [ 64.872857],    [  7.181918],    [ 10.046277],
        [std ],  [ 70.935324],    [  9.058099],    [ 14.284985],
        [min ],  [  0.006952],    [  0.000276],    [  0.000796],
        [25% ],  [  9.690526],    [  2.168622],    [  2.386345],
        [50% ],  [ 31.462373],    [  4.908393],    [  5.571245],
        [75% ],  [113.099430],    [  8.903545],    [ 12.760656],
        [max ],  [680.599720],    [226.170262],    [592.765323],
      )
    ],
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Deviation processed (mm)][X][Y][Z],
        [mean],  [ 62.469941],    [  7.216940],    [ 10.001153],
        [std ],  [ 70.122023],    [  9.067662],    [ 14.967685],
        [min ],  [  0.000379],    [  0.000839],    [  0.000065],
        [25% ],  [  9.050388],    [  2.007845],    [  2.220629],
        [50% ],  [ 27.936964],    [  4.717725],    [  4.811401],
        [75% ],  [112.598154],    [  8.676960],    [ 12.744544],
        [max ],  [679.639393],    [146.986826],    [594.480109],
      )
    ]
  )
) <maurice_drum_fast_dev_30fps>

Lastly, we can see the reduction in jitter clearly in the Y axis, trajectory plots from the Right Wrist marker in @maurice_drum_fast_jitter. The jitter around the 20-second marker is reduced, and the trajectory is smoother. The method has a positive impact on the jitter.


#figure(
  caption: [The signal stability from the `maurice_drum_fast` measurement in a boxplot, without processing (top) and with processing (bottom). Model: `LITE`, Marker type: `Landmark`],
  placement: none,
  grid(
    columns: (auto),
    rows: (auto, auto, auto),
    [
      #image("../images/measurements/maurice_drum_fast/LITE/Right_Wrist_y.svg"
      )
    ],
    [
      #image("../images/measurements/maurice_drum_fast_processed/LITE/Right_Wrist_y.svg"
      )
    ]
  )
) <maurice_drum_fast_jitter>

A final note on the memory size of the method. The above results are achieved with a memory size of 2 frames. This is the minimum memory size that can be used, as we need at least two frames to calculate the direction vector $arrow(v)$. The explanation of the method already made clear a concern that increasing the memory size might make the method less responsive. During the experimentation, we found this concern to be true. Setting the memory size to 4 caused some markers to lag behind the changes in the actual movement. Even higher memory sizes could cause the markers to lag even more. The method is most effective with a memory size of 2 frames at 30 fps.



=== 60 fps

The `maurice_drum_60fps` recording at 60 fps is used to compare the results. The following results are with parameters set to a memory size of 2 frames, the peak $d = 0.01$, and the tightness $s = 0.7$. The results are displayed in @maurice_drum_60fps_stability. Just like with the 30 fps recording, the method has a positive impact on the signal stability. However, the impact is less pronounced than with the 30 fps recording. This is somewhat surprising, as it was expected that the method would have a more significant impact on the 60 fps recording. More frames per second should allow the method to better predict the direction vector $arrow(v)$ and a narrower interpolation function. As the frames are closer together, the possible range of movement should be smaller.

#figure(
  caption: [The signal stability from the `maurice_drum_60fps` measurement without processing (top) and with processing (bottom). Model: `LITE`, Marker type: `Landmark`],
  placement: none,
  grid(
    columns: (auto),
    rows: (auto, auto, auto),
    gutter: 1em,
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Stability unprocessed (mm)][X][Y][Z],
        [mean],     [  6.084695],    [  1.456349],     [ 1.782536],
        [std ],     [  7.498098],    [  3.513297],     [ 3.320853],
        [min ],     [  0.000074],    [  0.000007],     [ 0.000027],
        [25% ],     [  1.302660],    [  0.168504],     [ 0.187517],
        [50% ],     [  3.542529],    [  0.510763],     [ 0.676077],
        [75% ],     [  8.028906],    [  1.362623],     [ 1.968414],
        [max ],     [102.800047],    [122.740564],     [83.073242],
      )
    ],
    [
      #table(
        columns: (auto, 2fr, 2fr, 2fr),
        align: (left, right, right, right),
        table.header[Stability processed (mm)][X][Y][Z],
        [mean],      [ 4.251094],  [1.277513],  [1.539274],
        [std ],      [ 4.003413],  [3.142163],  [3.161759],
        [min ],      [ 0.000385],  [0.000002],  [0.000005],
        [25% ],      [ 1.167122],  [0.082504],  [0.075393],
        [50% ],      [ 3.173341],  [0.344433],  [0.348346],
        [75% ],      [ 6.307637],  [1.050543],  [1.529996],
        [max ],      [38.699978],  [63.47007],  [47.21325],
      )
    ]
  )
) <maurice_drum_60fps_stability>

At 60 fps it is however possible to increase the memory size without causing the markers to lag behind the actual movement. Using more frames to predict the current position leads to a more stable prediction. But even at just 4 frames it is shown that the prediction is a bit too stable. The stability shown in @maurice_drum_60fps_mem4_stability is slightly worse than with a memory size of 2 frames.

#figure(
  caption: [The signal stability from the `maurice_drum_60fps` measurement with a memory size of 4 frames with processing. Model: `LITE`, Marker type: `Landmark`],
  placement: none,
  table(
      columns: (auto, 2fr, 2fr, 2fr),
      align: (left, right, right, right),
      table.header[Stability processed (mm)][X][Y][Z],
      [mean],      [ 4.209328],     [ 1.327719],     [ 1.634284],
      [std ],      [ 4.037256],     [ 3.022464],     [ 3.120164],
      [min ],      [ 0.000018],     [ 0.000010],     [ 0.000007],
      [25% ],      [ 1.179050],     [ 0.136544],     [ 0.149714],
      [50% ],      [ 3.084383],     [ 0.431487],     [ 0.511141],
      [75% ],      [ 6.089892],     [ 1.167036],     [ 1.695795],
      [max ],      [40.776414],     [54.463532],     [53.594910],
  )
) <maurice_drum_60fps_mem4_stability>

A possible explanation for the less pronounced impact of the method on the 60 fps recording could be attributed to the jitter. When closely looking at the jitter, we can see that the duration (in time) is the same across the 30fps and 60fps recordings. For example where the jitter would last 2 frames in the 30 fps recording, it would last 4 frames in the 60 fps recording. This means that the method has less of an impact on the 60 fps recording, as the jitter is already less pronounced. At 60 fps the jitter has a smoother curve instead of the sharp peaks at 30 fps.



As with the 30 fps recording, the method does not have a negative impact on the accuracy.


=== Conclusion

At 30 frames per second the method has a positive impact on the signal stability and the jitter. The same is true for the 60 frames per second recording, but the impact is less pronounced due to the smoother, stretched out, jitter.

The method does not have a negative impact on the accuracy. The method does not improve the accuracy, but it does not worsen it either.
