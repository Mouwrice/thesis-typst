#import "lib.typ": *

= MediaPipe Pose Landmarker <mediapipe-pose>

The following section describes the MediaPipe Pose Landmarker solution @mediapipe-pose-landmarker. It first provides some context about the broader MediaPipe Framework before going into more detail on the MediaPipe Pose Landmarker solution. The features of the solutoin are discussed as well as the motivation behind the choice of this solution for the air drumming application. The inference models used in the solution are also briefly discussed, including BlazePose and GHUM.

MediaPipe is a collection of on-device machine learning tools and solutions by Google @mediapipe. It consists of two main categories. There are the MediaPipe solutions, which have predefined "Tasks" that are ready to be used in your application @mediapipe-solutions. There are tasks on vision such as the detection and categorisation of objects or the detection of hand gestures @mediapipe-gesture-recognition @mediapipe-object-detection. One of these vision solutions is the MediaPipe Pose Landmarker. Other solutions such as text classification and audio classification are also present @mediapipe-text-classification @mediapipe-audio-classification. On the other hand, exists the MediaPipe Framework. It is the low-level component used to build efficient on-device machine learning pipelines, similar to the premade MediaPipe Solutions @mediapipe-framework. The remainder of this thesis solely addresses the MediaPipe Pose Landmarker Solution from this point forward, and will frequently be referred to as simply "MediaPipe" or "MediaPipe Pose" for the sake of conciseness.

MediaPipe Pose is available on three different platforms. One can use it in Python, on Android and on the web. However, these are only just API's to interact with the actual detection task. The application presented in this thesis is completely written in Python but all the concepts that are discussed are applicable to any platform.
#footnote[
  Following the announcement at Google I/O 2024, MediaPipe is now part of the larger Google AI Edge collection of tools and solutions. #link("https://ai.google.dev/edge")[https://ai.google.dev/edge #link-icon]
]

== Features

The main feature of MediaPipe Pose is of course, just as all body pose estimation tools, to extract the body pose from a given image or video frame. Unlike many other body pose estimation tools, MediaPipe delivers a 3D estimation instead of the more common 2D estimation, by introducing depth. However, in the measurement results, this added depth dimensionality is shown to be less than ideal.

The MediaPipe Pose Landmarker solution matches all the requirements set at the beginning of the project. It can run on-device in real-time and provides 3D pose estimation. It only requires a single camera to operate and can run on consumer-grade hardware. A laptop with a webcam is sufficient to run the application. The hands and feet are properly detected and tracked, which is essential for the drumming application. The MediaPipe Pose Landmarker solution is also quite fast and can run in real-time. The MediaPipe Pose Landmarker solution is a perfect fit for the air drumming application. Not only does it meet all the requirements, it is one of the few tools currently available that is ready to be used in a production environment. MediaPipe is not just a research tool; it is a tool that is actively maintained and updated by Google. This is a big advantage over many other tools that are often abandoned once the research paper has been published.
#footnote[
Following the announcement at Google I/O 2024, MediaPipe is now part of the larger Google AI Edge collection of tools and solutions. This once again confirms that MediaPipe is ready to be used in a professional and commercial setting. #link("https://ai.google.dev/edge#mediapipe")[https://ai.google.dev/edge#mediapipe #link-icon]
]
All of these reasons are why MediaPipe has been chosen for this project.


MediaPipe has three modes of operation, called the `RunningMode`. MediaPipe can work on still images (`IMAGE`), decoded video frames (`VIDEO`) and a live video feed (`LIVE_STREAM`) @mediapipe-pose-landmarker. Using the live video feed mode has some implications. When running MediaPipe in a real-time setting, the inference time of the model is constraint by this real-time application. When frame inference takes too long to be in the time window the frame gets dropped. Another major aspect of real-time applications is that the inference should not block the main thread and halt the program. This is why the inference in the `LIVE_STREAM` mode is performed asynchronously and results are propagated back using a callback function.

One other feature other than returning the body pose is the creation of an image segmentation mask. 
#footnote[A segmentation mask is a grayscale image, sometimes just pure black and white, with the goal of partitioning the image into segments. For example, the MediaPipe segmentation mask colours all pixels white where the human silhouette is visible.] 
MediaPipe has the ability to output a segmentation mask of the detected body pose. This mask could be used for e.g. applying some visual effects and post-processing, but it is not of much use in this implementation.

== Inference models

MediaPipe Pose is based on two computer vision models for the inference of the body pose. The first one is BlazePose which is only designed to return two-dimensional data in the given frame @blazepose. A second is the GHUM model, a model that captures 3D meshes given human body scans. A synthetic depth is obtained via the GHUM model fitted to the 2D points @ghum.

The Pose task consists of 3 `.task` files that contain the actual detection task and models. Three models are available: Lite (3 MB size), Full (6 MB size) and Heavy (26 MB size).
The measurement results will prove that the larger models can provide a more accurate and correct result but at reduced inference speeds. There is a trade-off to be made between accuracy and real-time processing. Although the Heavy model is almost 9 times larger than the Lite model, the improvement in accuracy is a lot smaller. The Lite model is not considerably worse and produces fine results for the drumming application.

=== BlazePose

BlazePose provides human pose tracking by employing machine learning (ML) to infer 33, 2D landmarks of a body from a single frame @blazepose. A standard for body pose originating from 2020 is the COCO topology @coco. The COCO 2020 Keypoint Detection Task is a challenge to develop a solution to accurately detect and locate the keypoints from the COCO dataset. The original COCO topology only consists of 17 landmarks. With little to no landmarks on the hands and feet. BlazePose extends this topology to a total of 33 landmarks by providing landmarks for the hands and feet as well. These added landmarks are crucial for the drumming application and is part of the reason MediaPipe was chosen.

#figure(caption: [BlazePose 33 landmark topology with the original COCO landmarks in green.])[
  #image(width: 100%, "images/blazepose_landmarks.jpg")
]

Next some parts of the BlazePose design and tracking model are discussed. It is important to understand some underlying methods discussed here as it helps to interpret the measurement results. A complete and detailed overview is provided in the original paper @blazepose.

The pipeline of MediaPipe is displayed in @mediapipe-pipeline. Before predicting the exact location of all keypoints the pose region-of-interest (ROI) is located within the frame using the _Pose detector_. The _Pose tracker_ then subsequently infers all 33 landmarks from this ROI. When in `VIDEO` or `LIVE_STREAM` mode, the pose detection step is only run on the first frame to reduce the inference time. For any subsequent frames, the ROI is then derived from the previous points.

#figure(caption: [MediaPipe Pose estimation pipeline])[
  #image(width: 100%, "images/mediapipe_pipeline.jpg")
] <mediapipe-pipeline>

As this solution is intended to be used in a real-time setting, the inference needs to be within milliseconds. The MediaPipe team have observed that the position of the torso is most easily and efficiently found by detecting the position of the face. The face has the most high-contrast features of the entire body and thus results in a fast and lightweight inference compared to the rest of the body @mediapipe-blazepose. This, of course, has the logical consequence that the face should be visible within the frame. This means that the "drummer" has to face the camera head on for the best result.

After detecting the face the construction of the pose region-of-interest begins. The human body centre, scale, and rotation are described using a circle. This circle is constructed by predicting two virtual points. One point being the centre of the hips, the other lies on the circle as the extension of the hip midpoint to face bounding box vector. These two points should now describe a circle as shown in @vitruvian-man.

#figure(caption: [MediaPipe Pose detection and alignment using virtual keypoints.])[
  #image("images/mediapipe_vitruvian.jpg")
] <vitruvian-man>

Lastly, we very briefly describe the actual network architecture for the tracking of keypoints.
The model takes an image as input with a fixed size of 256 by 256 pixels and 3 values for each pixel providing RGB values, @mediapipe-network. The model uses "a regression approach that is supervised by a combined heat map/offset prediction of all keypoints" @blazepose, @cnn-pose. The left-hand side outputs the heat maps and offset maps. Both the centre and left-hand side of the network are trained using the provided heatmap and offset loss. Afterwards, the heatmaps and output maps output layers are removed and the regression encoder on the right-hand side is trained. The fixed input layer size indicates that there is no use in increasing the resolution to get an increase in the prediction accuracy. The measurements also confirm this hypothesis.

#figure(caption: [MediaPipe Pose network architecture.])[
  #image("images/mediapipe_network.jpg")
] <mediapipe-network>

=== GHUM (Generative 3D Human Shape and Articulated Pose Models)

As mentioned, MediaPipe Pose offers an extra dimension unlike many other purely 2D pose estimation tools. This third dimension is, of course, depth. It does so by utilising an entirely different model, being the GHUM model @ghum. The GHUM model can construct a full 3D body mesh given image scans of a person. The outputs form an actual 3D mesh of 10,168 vertices for the regular model and 3,194 vertices for the lite model. MediaPipe is quite vague on the exact usage of this model in the pose solution. The only mention of GHUM is in the following sentence: _"Keypoint Z-value estimate is provided using synthetic data, obtained via the GHUM model (articulated 3D human shape model) fitted to 2D point projections."_ @mediapipe-model-card. Nonetheless, in the measurements it is shown that there is some notion of depth, but it is far from accurate. Especially when compared to the other 2D values provided by the BlazePose model.
