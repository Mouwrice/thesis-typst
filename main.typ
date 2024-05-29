#import "lib.typ": *

#show: template.with(
  title: [Air Drumming: Applied on-device body pose estimation],
  abstract: [
   Body pose estimation is a new and exciting field in Computer Vision. It allows for the estimation of the position of key body parts in images or videos. In this paper, we explore the use of MediaPipe, a popular open-source library, for Body Pose Estimation, promising real-time on-device body pose estimation. We present a demo application that uses MediaPipe to estimate the body pose of a user air drumming. We evaluate the performance of the application and discuss the potential for future work in this area. The accuracy of the pose estimation is evaluated, and some issues are discussed. MediaPipe Pose is shown to achieve an average accuracy of 5-10 mm and an average of 30 fps. However, the MediaPipe estimation suffers from noise and jitter. We present a post-processing method that can reduce that noise and jitter. The method is general, and can be applied to any pose estimation model.
  ],
  preface: [#include("preface.typ")],
  authors: (
    (
      name: "Maurice Van Wassenhove",
      department: [Master of Science in Computer Science Engineering],
      organization: [University of Ghent],
      location: [Ghent, Belgium],
      email: "mauricevanwassenhove@fastmail.com"
    ),
  ),
  index-terms: ("Body Pose Estimation", "MediaPipe", "Computer Vision", "Motion Capture", "3D Pose Estimation", "Demo Application"),
  bibliography: bibliography("bib.yml"),
)

#include "introduction.typ"

#include "sota.typ"

#include "mediapipe_pose.typ"

#include "measurements/measurements.typ"

#include "jitter_noise/jitter_noise.typ"

#include "drum_application.typ"

#include "future_work.typ"

#include "conclusion.typ"
