= Appendices
#import "@preview/i-figured:0.2.4"

#show heading: i-figured.reset-counters
#show figure: i-figured.show-figure


#i-figured.outline()

== Figures <figures-appendix>

Figures that are either not included in the text or added in an enlarged form.




#rotate(90deg, reflow: true)[
#figure(caption: [Plot of the MediaPipe (Blue) and Qualisys (Red) left wrist z-axis without processing.], placement: none)[
  #image("images/left_wrist_axis_z_positions_base.png")
]] <fig-left_wrist_axis_z_positions_base>


#rotate(90deg, reflow: true)[
#figure(caption: [Plot of MediaPipe (Blue) and Qualisys (Red) left wrist z-axis after re-arranging the MediaPipe axes.], placement: none)[
  #image(width: 100%, "images/left_wrist_axis_z_positions_apply_axis_transformations.png")
]] <fig-left_wrist_axis_z_positions_apply_axis_transformations>

#rotate(90deg, reflow: true)[
#figure(caption: [Plot of the MediaPipe (Blue) and Qualisys (Red) left wrist z-axis with the time offset removed.], placement: none)[
  #image(width: 100%, "images/left_wrist_axis_z_positions_frame_offset.png")
]] <fig-left_wrist_axis_z_positions_frame_offset>

#rotate(90deg, reflow: true)[
#figure(caption: [Plot of the MediaPipe (Blue) and Qualisys (Red) left wrist z-axis with the MediaPipe signal scaled to match.], placement: none)[
  #image(width: 100%, "images/left_wrist_axis_z_positions_stretch.png")
]] <fig-left_wrist_axis_z_positions_stretch>
