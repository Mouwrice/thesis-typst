= Future work <future-work>

In this section, some ideas are listed that could be interesting to explore in the future.

== Increasing signal stability

The signal stability has been increased by the method introduced previously, reducing the jitter and noise. However, the signal is still not perfect. It would be interesting to explore other methods to increase the signal stability even further.

As it stands, the method is based on a simple prediction model combined with an interpolation method between the predicted and the measured value. This can be generalized to a statistical problem where the goal is to predict a state given a previous state, together with the uncertainty of the prediction. One could use a Kalman filter to estimate the next state and its uncertainty. The Kalman filter can work as a two-phase process where the first phase is the prediction given the previous state and the second phase is the update phase given the measured value @kalman-filter.
This would allow making a more informed decision on how to interpolate between the predicted and the measured value.

The prediction of every marker is currently independent of the other markers. However, the markers are not independent of each other. It would be interesting to explore methods that consider the dependencies between the markers. Constructing a skeleton model of the human body that takes into account the dependencies and constraint between the markers could be a way to increase the signal stability. For example, the distance between connected markers (by a bone) should be constant. This could be used to correct the predicted value of a marker if the distance between the connected markers is not constant. Another example is that the angle between connected markers is limited to a certain range of values.


== Depth estimation

From the measurements, it was clear that the depth estimation has a low accuracy and suffers from major instability. Future work could focus on improving the depth estimation. This could be achieved in two ways. The first is by simply using a different model or training the computer vision model to more accurately predict the depth. The second way is to use additional sensors to estimate the depth. For example, a depth sensor could be used to measure the depth of the markers. This could be combined with the computer vision model to increase the accuracy of the depth estimation. Or by using a multi-camera setup, the depth could be estimated by triangulating the position of the markers in the different camera views.


== Real-time application

There are various ways to build upon the application. One simple way to improve the application is by simply replacing the currently used MediaPipe model with a better model if one is found. An increase in depth is certainly welcome, but also an increase in performance would be beneficial. Currently, the application runs at around 30 frames per second, which limits the ability to track fast and complex movements. A faster model would allow for a higher frame rate and thus a more responsive application.

Another way to improve the application is by integrating a better prediction model such as the ones mentioned in the previous section.

An entirely different application can be built by using the same principles. Not only is body pose estimation improving, but also hand pose estimation is becoming more accurate. Similar research can be done to discover the feasibility of an application that requires accurate hand and finger tracking. For example, a virtual piano application.

Other future research can focus on the usage of body pose estimation in a different context, such as in a medical rehabilitation setting. Such a system could help medical professionals to analyse the movements of patients. Or it could be used as a tool for patients that need to do exercises at home. The system could provide feedback on the correctness of the exercises and give tips on how to improve the exercises.
