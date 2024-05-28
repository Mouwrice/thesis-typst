#import "lib.typ": *

= A brief overview of the State Of The Art <sota>

In this section, we will provide a brief overview of some recent body pose estimation tools and papers that have been published. Moreover, for every tool or paper, we will provide a short summary of the key features and limitations. 

Some rather strict requirements for this specific demo application were set at the beginning of the project. 
The tool should be able to run on-device in real-time, and should be able to provide 3D pose estimation.
By on-device, we mean that the tool should be able to run on consumer-grade hardware, such as a smartphone or a laptop. Another important requirement is the amount of detail that can be tracked. For a drumming demo application, it is essential that the hands and feet are properly detected and tracked. In many of the papers that we will discuss in this section, the tools often lack one of these requirements.

== Human Motion

The Human Library is an open-source tool, based on web technologies, that provides a wide range of detection tasks. One of which is body pose tracking. In full the name is "Human: AI-powered 3D Face Detection & Rotation Tracking, Face Description & Recognition, Body Pose Tracking, 3D Hand & Finger Tracking, Iris Analysis, Age & Gender & Emotion Prediction, Gaze Tracking, Gesture Recognition" @human. It also comes with a library, human-motion, which is focused on the 3D motion visualisation of the face, body, and hands @human-motion.

Many of the requirements for this project are met by the Human Library. It has an excellent amount of detail that can be tracked, and it can run on-device. However, during testing, we could not get the performance to be high enough for real-time applications. The body pose was only updated every second or so. Even if some setup optimizations could be made on our side, we do not believe that the performance could be improved enough to be used in a real-time application.

== Volumetric Capture

This tool is quite different from the other tools in this section. It is not really a body pose estimation tool, as it does not explicitly provide any precise markers or skeleton. Instead, it provides a volumetric representation of the human body @volumetric-capture. This means that it provides a 3D model of the human body. It does so with a set of calibrated depth cameras, such as the Intel RealSense camera. It requires quite a lot of specific hardware and multiple cameras, so it clearly does not conform with the set requirements. This tool is also not really suitable for our application, as we need precise tracking of the hands and feet using traditional markers. However, it is an interesting tool that could be used in other applications. For example, it has potential in the use of Mixed Reality applications. An overview of the Volumetric Capture tool can be seen in @volumetric-capture-overview.

#figure(caption: ["The Volumetric Capture tool overview taken from the official documentation @volumetric-capture."])[
  #image("images/volumetric-capture.jpg")
] <volumetric-capture-overview>

Volumetric Capture was developed by the 3D vision team of the Visual Computing Lab.
#footnote[#link("https://vcl.iti.gr/")[https://vcl.iti.gr/ #link-icon]]
Unfortunately, according to the documentation and releases on GitHub, the project seems to be abandoned.
#footnote[
  #link("https://github.com/VCL3D/VolumetricCapture/releases")[https://github.com/VCL3D/VolumetricCapture/releases #link-icon]
]
The last release was in 2020 and is only available on Windows 10. This limited compatibility and support appears to be common for many of the tools in this section. Many tools go along with some research paper, but once the research is done, the tool is abandoned. This lack of updates and maintenance is less than ideal for use in an actual application.


== MMPose: RTMPose

#figure(caption: [RTMPose official logo.])[
  #image("images/rtmpose.jpg")
]

To quote from the official GitHub page: "MMPose is an open-source toolbox for pose estimation based on PyTorch. It is a part of the OpenMMLab project." 
#footnote[The OpenMMLab project is a collection of "open source projects for academic research and industrial applications. OpenMMLab covers a wide range of research topics of computer vision, e.g., classification, detection, segmentation and super-resolution." #link("https://openmmlab.com/")[https://openmmlab.com/ #link-icon]] @mmpose

The model of interest in the collection of models is RTMPose @rtmpose. RTMPose is a pose estimation toolkit that works in real-time and with multiple persons in the frame. The model is quite fast and can run on consumer-grade hardware. They boast with achieved frame rates of  90+ FPS on an Intel i7-11700 CPU and 430+ FPS on an NVIDIA GTX 1660 Ti GPU. However, it does not provide 3D pose estimation, it is limited to two dimensions. Despite this, it is available on many different platforms and devices such as Windows, Linux, and ARM-based processors. This tool ticks many of the boxes for our project, but the lack of 3D pose estimation was a dealbreaker. But, as shown in the measurements of MediaPipe Pose in the next section, the 3D pose estimation is not always as accurate as one might hope. It is even so that the depth, the third dimension, is not used in the final application. Given the uncovered limitations of the MediaPipe Pose tool, RTMPose might be a better alternative for our usecase. Especially since it has a way higher achievable frame rate than MediaPipe Pose.

== AlphaPose

#figure(caption: [The AlphaPose logo.])[
  #image(width: 80%, "images/alphapose.jpg")
]

AlphaPose is yet another open-source, multi-person pose estimator @alphapose, based on the research paper "RMPE: Regional Multi-person Pose Estimation" @alphapose-paper. It is one of the earlier body pose estimation tools originating from 2017. Being an older tool, its accuracy and performance are not as high as some of the newer tools, such as RTMPose. Besides, it is one of those tools that is not maintained once the research paper has been published, making it unfit for actual usage.

== OpenPose 

#figure(caption: [OpenPose keypoints example.])[
  #image("images/openpose.gif")
] <openpose-example>

OpenPose, released in 2018, is the first real-time multi-person system to jointly detect human body, hand,
facial, and foot keypoints (in total 135 keypoints) on single images (@openpose-example). It is based on the research paper "OpenPose: Realtime Multi-Person 2D Pose Estimation using Part Affinity Fields" @openpose-paper. OpenPose is a popular tool that is still maintained to this day. It supports all major operating systems and can run on consumer-grade hardware. OpenPose supports the detection and tracking of the poses of multiple people in the frame. As we do not need to track multiple individuals, this feature can be disabled, leading to an increase in performance according to the documentation. OpenPose stands out as it also provides 3D key point detection using triangulation from multiple views. This is a feature that is not present in many of the other tools in this section. OpenPose is a strong candidate for our application, but the lack of 3D pose estimation using a single camera is a dealbreaker.


== MindPose

MindPose is the last tool that we will discuss in this section. It is the result of an open-source project jointly developed by the MindSpore
#footnote[
   MindSpore is an open-source AI framework developed by Huawei. It is a deep learning and machine learning framework that is used for training and inference of AI models. #link("https://www.mindspore.cn/")[https://www.mindspore.cn/ #link-icon]
]
team @mindpose. MindPose is a toolbox or python framework that allows for the training and inference of pose estimation models. Unfortunately, the project seems to be abandoned and unfinished. The project also appears to be rather bare bones, with no examples and few documentation. It provides support for three body pose estimation models from 2018 and 2019. The models are HRNet, SimpleBaseline and UDP @hrnet @simplebaseline @udp. These models do not seem to focus on real-time applications, and they do not provide 3D pose estimation. The project is not suitable for our application, but it is interesting to see that Huawei is also working on pose estimation tools.

