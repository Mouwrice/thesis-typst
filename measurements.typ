#import "lib.typ": *

= Measuring accuracy and deviation <measuring-accuracy-and-deviation>

The following chapter discusses the accuracy and deviation of a body pose estimation tool. More specifically, the outputs of the MediaPipe Pose landmark detection solution are compared to that of a traditional optical tracking system.
All base measurements are taken from a Qualisys Oqus MRI #footnote()[The Oqus MRI is one of Qualisys' traditional optical motion capture cameras, requiring physical trackers on the body that reflect incoming infrared light from the camera. #link("https://www.qualisys.com/cameras/oqus-mri/")[https://www.qualisys.com/cameras/oqus-mri/ #link-icon]] system setup at the Art and Science Interaction Lab at De Krook in Ghent, provided by IDLab-Media #footnote()[The Art and Science Lab is a _" highly modular research infrastructure aimed at interaction research"_, provided by IDLab-Media, one of the research teams within the research group IDLab from Ghent University and imec. #link("https://media.idlab.ugent.be/about/")[https://media.idlab.ugent.be/about/ #link-icon]].

#include("measurement_methods.typ")

#include("measurement_results.typ")

