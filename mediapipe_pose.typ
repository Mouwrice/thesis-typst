= MediaPipe Pose Landmarker

The following section describes the MediaPipe Pose Landmarker solution @mediapipe-pose-landmarker. It first provides some context about the broader MediaPipe Framework before going into more detail on the MediaPipe Pose Landmarker solution.

MediaPipe is a collection of on-device machine learning tools and solutions by Google @mediapipe. It consists of two main categories. There are the MediaPipe solutions, which have predefined "Tasks" that are ready to be used in your application @mediapipe-solutions. There are tasks on vision such as the detection and categorisation of objects or the detection of hand gestures @mediapipe-gesture-recognition @mediapipe-object-detection. One of these vision solutions is the MediaPipe Pose Landmarker. Other solutions such as text classification and audio classification are also present @mediapipe-text-classification @mediapipe-audio-classification. On the other hand exists the MediaPipe Framework. It  is the low-level component used to build efficient on-device machine learning pipelines, similar to the premade MediaPipe Solutions @mediapipe-framework. The remainder of this thesis solely addresses the MediaPipe Pose Landmarker Solution from this point forward, and will frequently be referred to as simply "MediaPipe" or "MediaPipe Pose" for the sake of conciseness.

MediaPipe Pose is available on three different platforms. One can use it in Python, on Android and on the web. However, these are only just API's to interact with the actual detection task. The application presented in this thesis is completely written in Python but all the concepts that are discussed are applicable to any platform.

=== Features

The main feature of MediaPipe Pose is of course, just as all body pose estimation tools, to extract the body pose from a given image or video frame. Unlike many other body pose estimation tools, MediaPipe delivers a 3D estimation instead of the more common 2D estimation. However, in the measurement results, this added depth dimensionality is shown to be less than ideal.

MediaPipe has three modes of operation, called the `RunningMode`. MediaPipe can work on still images (`IMAGE`), decoded video frames (`VIDEO`) and a live video feed (`LIVE_STREAM`) @mediapipe-pose-landmarker. Using the live video feed mode has some implications. When running MediaPipe in a real-time setting, the inference time of the model is constraint by this real-time application. When frame inference takes too long to be in the time window the frame gets dropped. Another major aspect of real-time applications is that the inference should not block the main thread and halt the program. This is why the inference in the `LIVE_STREAM` mode is performed asynchronously and results are propagated back using a callback function.

One other feature other than returning the body pose is the creation of an image segmentation mask. MediaPipe has the ability to output a segmentation mask of the detected body pose. This mask could be used for e.g. applying some visual effects and post-processing, but it is not of much use in this implementation.

=== Inference models

MediaPipe Pose relies on two models for the inference of the body pose. The first one is BlazePose and is only designed to return two-dimensional data in the given frame @blazepose. A synthetic depth is obtained via the GHUM model fitted to the 2D points @ghum.

==== BlazePose

BlazePose provides human pose tracking by employing machine learning (ML) to infer 33, 2D landmarks of a body from a single frame @blazepose. A standard for body pose originating from 2020 is the COCO topology @coco. The COCO 2020 Keypoint Detection Task is a challenge to develop a solution to accurately detect and locate the keypoints from the COCO dataset. The original COCO topology only consists of 17 landmarks. With little to no landmarks on the hands and feet. BlazePose extends this topology to a total of 33 landmarks by providing landmarks for the hands and feet as well.

#figure(caption: [BlazePose 33 landmark topology with the original COCO landmarks in green.])[
  #image(width: 100%, "images/blazepose_landmarks.jpg")
]


