#import "lib.typ": *

#show: template.with(
  title: [Air Drumming: Applied on-device body pose estimation],
  abstract: [
    #lorem(50)
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

#import "@preview/wordometer:0.1.2": word-count, total-words
#show: word-count

#total-words

= Introduction

== Body pose estimation

= A brief overview of the State Of The Art

#include("mediapipe_pose.typ")

#include("measurements.typ")

= Improving accuracy and reducing jitter

== Methods

== Results

= Drum Application

#include("figures.typ")
