= Conclusion <conclusion>

In this thesis, we have presented a method to compare body tracking data from a computer vision model with a motion capture system. Using the method we have shown that an average accuracy of 5-10 mm can be achieved with MediaPipe Pose for the movements relative to the camera. We have shown that the accuracy of the depth estimation is a low lower and suffers from major instability. MediaPipe Pose is able to track the movements of the body in real-time with a frame rate of around 30 frames per second on consumer hardware. And reaching up to 45 fps on a powerful GPU. During the measurements, a jitter phenomenon was observed in the signal which appears to be caused by overlapping body parts such as crossed arms.

We have also shown that the signal stability can be increased by using a simple prediction model combined with an interpolation method between the predicted and the measured value. This method reduces the jitter and noise in the signal. However, the signal is still not perfect. Future work could focus on increasing the signal stability even further.

A drum application was built to demonstrate the capabilities of the system. The application uses the body pose estimation to track the movements of the user and translate these movements to drum sounds. The application was able to track the movements of the user in real-time and play the drum sounds accordingly. The simple yet very effective procedure for detecing drum hits has been described as well. The application technology stack consists of MediaPipe Pose for the body pose estimation, PyGame for the visualisation and sound, and Python for the application logic. The application and its source code have been made publicly available for download and can be found on GitHub.

The future of body pose estimation is promising. The accuracy and performance are shown to already be sufficient to construct a simple real-time air drumming application. The application of body pose estimation is not limited to drumming. It can be used in various applications such as in medical rehabilitation, virtual reality, and human-computer interaction. Future work could focus on increasing the signal stability, improving the depth estimation, and finding new applications for body pose estimation. We have seen that body pose estimation can bring the expensive and complex technology of motion capture to consumer hardware. This opens up a whole new world of possibilities for applications that require body tracking.
