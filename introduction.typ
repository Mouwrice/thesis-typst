#import "lib.typ": *


= Introduction

This introductory chapter provides the necessary context for this master's dissertation. It starts by presenting the demo application that will be developed as part of this project and the motivation behind it. Next,it discusses the research questions that will be addressed and the goals to be achieved. Finally, it outlines the structure of the dissertation and provides an overview of the chapters that follow.


== Demo Application

The project aims to develop a demo application that uses on-device body pose estimation to enable air drumming. The application allows users to play virtual drums by moving their hands in the air, as well as use their feet to press down on virtual pedals. The goal is to provide a fun and interactive experience that showcases the capabilities and limitations of on-device body pose estimation.

The main inspiration came from an older sketch performed by Rowan Atkinson as part of his Rowan Atkinson stand up tours during the years 1981 to 1986. In the clip, Rowan bumps into a what appears to be, invisible drum kit. 
#footnote[
  The clip is available on YouTube from the official "Rowan Atkinson Live" channel: #link("https://www.youtube.com/watch?v=A_kloG2Z7tU")[https://www.youtube.com/watch?v=A_kloG2Z7tU #link-icon]
]
There are no actual attributes on stage, the only thing standing on the stage is a drum stool. Various drum sounds can be heard which seem to perfectly match the movements performed by Rowan Atkinson. After the character played by Rowan Atkinson understands that he has stumbled upon an invisible drum kit, he starts playing the drums with his hands and feet. What follows is a neat trick of coordination and timing, as the sounds that we are hearing are obviously either prerecorded or performed by someone off-stage. The demo application aims to capture some of that magic by allowing users to actually play drums without the need for physical drumsticks or a drum kit.

The demo application will be developed using the MediaPipe framework, which provides a sufficiently accurate  implementation of body pose estimation. The application will leverage the body pose estimation provided by MediaPipe to track the user's body movements in real-time. It will then use this information to generate drum sounds based on the user's hand and foot movements. The application will also include a graphical user interface that provides visual feedback to the user.

== On-device body pose estimation

Before diving into the goals and research questions of this project, it is important to provide some context on what is meant by on-device body pose estimation. Body pose estimation is the task of inferring the pose of a person from an image or video. The pose typically consists of the 2D or 3D locations of key body parts, such as the head, shoulders, elbows, wrists, hips, knees, and ankles. In recent developments, more and more key points are commonly found in these estimation tools, sometimes with the ability to achieve complete hand and finger tracking. Body pose estimation has a wide range of applications, including human-computer interaction, augmented reality, and motion capture @object-pose-survey. It can be considered a new form of motion capture based on computer vision.

On-device body pose estimation refers to the ability to perform body pose estimation directly on a device, such as a smartphone or tablet, without the need for specialized hardware or an internet connection. This is made possible by recent advancements in deep learning and computer vision, which have enabled the development of lightweight and efficient models that can run in real-time on mobile devices.

== Traditional motion capture systems

Traditional motion capture systems are used to track the movements of actors or performers in real-time. These systems typically consist of multiple cameras that capture the movements of reflective markers placed on the actor's body. The captured data is then processed to reconstruct the actor's movements in 3D space. Motion capture systems are widely used in the entertainment industry for creating realistic animations for movies, video games, and virtual reality experiences.

== Motivation

Currently traditional motion capture systems are still the most accurate and reliable way to capture human movements. However, they are expensive, require specialized equipment and expertise to set up and operate. On the other hand, on-device body pose estimation offers a more accessible and affordable alternative that can run in real-time on consumer devices. By developing a demo application that uses on-device body pose estimation for air drumming, we can explore the capabilities and limitations of this technology and its potential for interactive applications. This can help inform future research and development efforts in the field of computer vision and human-computer interaction as well as inspire new applications and use cases.

== Goals and research questions

As mentioned, one part of this project is to develop a demo application that uses on-device body pose estimation to enable air drumming. But that is not all. One aspect of this research is to evaluate the performance of the body pose estimation model provided by MediaPipe and identify its limitations. This will involve conducting experiments to measure the accuracy and robustness of the model under different conditions. Another goal, on top of the performance evaluation, is to provide a more pragmatic comparison when it comes to using body pose estimation versus traditional motion capture systems. During the development of the demo application, some properties of the body pose estimation have been identified that need to be considered when developing interactive applications. All of this addresses the lengthy research question: "What are the capabilities and limitations of on-device body pose estimation, specifically MediaPipe Pose, for interactive applications compared to traditional motion capture systems?"

During the measurements some signal stability issues were identified. These issues are caused by jitter and noise in the body pose estimation output. So another goal is to come up with a method that can reduce these issues. This leads to the second research question: "How can jitter and noise in the body pose estimation output be reduced or mitigated to improve the stability of interactive applications?" 

== Structure of the dissertation

Following this introduction, the dissertation is structured as follows:

- @sota[Chapter] provides an overview of the state-of-the-art in body pose estimation and motion capture, focusing on recent developments and advancements in the field.

- @mediapipe-pose[Chapter] introduces the MediaPipe framework and its body pose estimation model, highlighting its key features and capabilities.

- @measuring-accuracy-and-deviation[Chapter] presents the measurements that were conducted to evaluate the performance of the MediaPipe Pose model and identify its limitations.

- @jitter-noise[Chapter] discusses the issues of jitter and noise in the body pose estimation output and proposes a method to reduce these issues.

- @drum-application[Chapter] describes the development of the demo application for air drumming, including the design and implementation of the application.

- @future-work[Chapter] provides some insights into future work that could be done to improve the demo application and address the limitations of on-device body pose estimation.

- Finally, @conclusion[Chapter] concludes the dissertation by summarizing the key findings and contributions of this research.
