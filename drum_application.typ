#import "lib.typ": *

= The Air Drumming Application (DrumPy)

The Air Drumming application is a demo application that showcases the use of on-device body pose estimation.
#footnote[
  DrumPy is the official application name, referring to the main technology, Python, with which it is made.
] 
The application uses the MediaPipe library to estimate the 3D pose of a person in real-time. The estimated pose is then used to detect drumming gestures and generate drum sounds. It is a fun and interactive way to explore the capabilities of body pose estimation. 

The following section describes the key components of the application without going into too much detail. For a more in-depth explanation, please refer to the source code and documentation. 
#footnote[
  The application and source code are publicly available on GitHub: #link("https://github.com/Mouwrice/DrumPy")[Mouwrice/DrumPy #link-icon]. Note that this application is as much part of this thesis as the measurements and results presented in the previous sections, and should be considered as such.
]

The application is designed to be easy to use and understand, with a simple command-line interface and graphical user interface. The user can start the application by simply launching the executable or from the command line to set some options such as which camera should be used, which model should be used etc. The application captures video frames from the camera, estimates the body pose of the person in the frame, and generates drum sounds based on the detected gestures. The user can play the drums by moving their hands and arms in the air, as if they were playing a real drum set. The feet are also tracked to detect the kick drum pedal. The application provides visual feedback by showing the estimated pose on the screen.
One feature of the application is velocity-based volume control. The volume of the drum sounds is controlled by the velocity of the drumming gestures. The harder the user hits the drums, the louder the drum sounds will be. This feature adds a level of realism to the drumming experience and makes it more engaging for the user.

When launching the application, a calibration phase is initiated. During this phase, the user is asked to perform a series of drumming gestures to calibrate the position of specific drum elements such as the snare drum, hi-hat, and cymbals. This calibration step is necessary to map the detected gestures to the correct drum sounds. These steps are outputted to the user in a console that is displayed on the screen. For example, the first element to be calibrated is the `Snare Drum`, the user should then repeatedly hit the snare drum at the position where they want the snare drum to be. The application will then use this information to calibrate the snare drum position. After a minimum of 10 successful hits and the positions of these hits are consistent, the calibration is considered successful, and the next element is calibrated. This process is repeated for all drum elements. Every calibration step along with information about the detected hit is outputted to the user in the console as shown in the example below, @calibration-console-output.

For more usage information along with an installation guide, please refer to the README file in the source code repository.
#footnote[
  #link("https://github.com/Mouwrice/DrumPy?tab=readme-ov-file#installation")[https://github.com/Mouwrice/DrumPy?tab=readme-ov-file#installation #link-icon]
]

#figure(
  placement: none,
  caption: [Console output of the calibration process.],
  )[
  ```console
  Snare Drum calibration start

  Calibrating Snare Drum
          Hit count: 0

  Volume: 1.000
  Left Wrist: Snare Drum 
  Distance: 0.000
  Velocity: -0.867
  Position: [-0.128, 0.099, -0.827]


  Calibrating Snare Drum
          Hit count: 1

  Volume: 1.000
  Left Wrist: Snare Drum 
  Distance: 0.006
  Velocity: -1.056
  Position: [-0.148, 0.110, -0.824]


  Calibrating Snare Drum
          Hit count: 2

  Volume: 1.000
  Left Wrist: Snare Drum 
  Distance: 0.015
  Velocity: -1.101
  Position: [-0.188, 0.126, -0.830]
  ```
] <calibration-console-output>

== Technologies

The Air Drumming application is entirely written in Python and uses the following libraries:
- MediaPipe: For on-device body pose estimation.
- Pygame: For the audio and graphical user interface as well as capturing video frames from the camera.
- OpenCV: A library used to read video frames from a file.
- Click: For providing a simple and consistent command-line interface.

The application has been tested on both Linux (Arch Linux) and Windows 11. It should work on other platforms as well, but this has not been tested. Note that unfortunately, GPU support is not available for the MediaPipe library on Windows, so the application will run on the CPU only. This may result in lower performance compared to running the application on a Linux machine with GPU support and a dedicated GPU.

With the help of Nuitka,
#footnote[
  Nuitka is a Python compiler that can compile Python code into standalone executables.
  #link("https://nuitka.net/")[https://nuitka.net/ #link-icon]
]
the application can be compiled into a standalone executable that can be run on any system without the need to install Python or any of the required libraries. This makes it easy to distribute the application to users who do not have Python installed on their system. The compiled executable is available in the GitHub repository for easy download and use. Unfortunately, the compiled executable is only available for Windows currently, as the binary for Linux did not work as expected.

The code repository has been automated with GitHub Actions to automatically build and release the compiled executable for Windows whenever a new release is created. This makes it easy to keep the compiled executable up to date with the latest changes in the codebase.


== Gesture detection

The application uses the estimated 3D pose of the person to detect drumming gestures. For the demo application, the only drumming gestures detected are downward movements to hit the drums. After the hit detection, the drum element that is hit is determined by the position of the marker where a hit has been detected. The drum element closest to the marker is considered to be the drum element that has been hit. The velocity of the hit is calculated based on the speed of the downward movement. The harder the user hits the drums, the louder the drum sounds will be. The velocity controls the volume of the drum sounds, as mentioned earlier.

From the measurement results, we know that the depth values are not reliable and therefore are not used in the hit detection and drum positions. This means that the entire air drumming application works at a 2D level, it does not make use of any depth information. This is a limitation of the application but has not proved to be a problem in practice as most drumming gestures are made in the same plane.

From the measurements, we also know that `WorldLandmarks` are less reliable than the regular `Landmarks`. 
For a more reliable hit detection, the application uses the regular `Landmarks` to detect the drumming gestures and to store the positions of the drum elements. Regular `Landmarks` have coordinates relative to the image frame, while `WorldLandmarks` have coordinates relative to the detected hip midpoint. If the `WorldLandmarks` are used, the drum elements would move with the user, which is not desirable. The drum elements should be fixed in space, so the regular `Landmarks` are used instead.


=== Hit detection

The hit detection is based on the observation that a downward movement is made when hitting a drum, followed by a slight upward movement. A downward movement is defined as having a consecutive series of positions where the vertical position is decreasing. An upward movement is defined as having a consecutive series of positions where the vertical position is increasing. At first, this might seem a bit counterintuitive, as one would expect the hit to be detected when the marker reaches the position of the drum element, just as in real life. In real life, the drum makes a sound when the drumstick hits the drum. However, the application is meant for air drumming, where there is no physical drum to hit. If we were to detect the hit when the marker reaches the position of the drum element, a hit might be detected when the user is still moving their hand downwards to hit the drum. This would reduce the immersion and realism. Instead, our method tries to find the point where the user expects the drum to be hit, not when the drum would actually be hit in real life. This is why the hit detection is based on the vertical trend of the marker and not the actual position of the marker.
 
Consider the following example vertical trajectory of a marker, @vertical-trajectory-example. The hit detection algorithm looks for a downward movement followed by an upward movement. Or in other words, it looks for a peak or breakpoint in the vertical trajectory. When such a peak is detected, a hit is registered.
It does so by keeping a memory of a certain number of previous positions and calculating the trend of the vertical position. Given a range of positions, a downward trend is detected when the average decrease in vertical position is greater than a certain threshold. An upward trend is detected when the average increase in vertical position is greater than a certain threshold. This allows to tweak the sensitivity of the hit detection algorithm. For example, a higher threshold would require a more pronounced downward movement to be detected as a hit. The threshold can also be lowered to allow for more subtle movements to be detected as hits. This is the case for the hit detection of the feet. The feet are tracked to detect the kick drum pedal. When using a pedal, the user might not immediately lift their foot after hitting the pedal. Setting the upward threshold to a lower value allows detecting the hit even when there is no real upward movement.
The upward threshold is even set to a negative value, but not as low as the downward threshold. Now a foot induced hit can even be detected when the foot is still slightly moving downwards after the hit.


#figure(caption: [Example vertical trajectory of a marker. Every dot represents a given position at a given time. The horizontal axis is time, the vertical axis is position.], placement: auto)[
  #image("images/vertical_trajectory_example.svg")
] <vertical-trajectory-example>

Another important aspect that affects the hit detection is the notion of the current position.
When the algorithm receives the position of marker $F$ from the example (@vertical-trajectory-example), it has no way of knowing that this point $F$ is the "hit point". It would need to be able to look ahead. Of course, this is not possible, this is why the current position is defined as being some time in the past. For example, if we take the current position to be the position of the marker 2 frames ago, we have the artificial ability of looking ahead 2 frames to detect if an upward trend follows the current position. Note that there is a tradeoff between the current position and the number of frames used to detect the upward trend. The more frames are used to detect the trend, the more accurate the hit detection will be, but the less responsive it will be. This is because the hit detection will be delayed by the number of frames used to detect the upward trend. The current position is a compromise between accuracy and responsiveness.

=== Finding the nearest drum element

Every element of the drum set has a position which is set during the calibration fase. During the calibration any detected hit will result in the position of the element to be updated and the calibrated drum element to play its sound. 

After a hit is registered, a corresponding drum element needs to be found. The application calculates the distance between the hit position and the position of each drum element. The drum element closest to the hit position is considered to be the drum element that has been hit. This is a simple way to determine which drum element has been hit and works well in practice. The distance is calculated using the Euclidean distance formula, which calculates the distance between two points in 2D space (the location of the hit and the location of the drum element).
There is also a threshold distance that is used to determine if a hit is close enough to a drum element to be considered a hit on that drum element. If the distance between the hit position and the drum element is less than the threshold distance, the hit is considered to be on that drum element. This threshold distance can be adjusted to make the hit detection more or less sensitive. A lower threshold distance will require the hit to be closer to the drum element to be considered a hit, while a higher threshold distance allows hits that are further away to be considered hits on the drum element. This can be useful to fine-tune the hit detection to the user's preferences and playing style. It would be unrealistic if the user would trigger a drum sound when hitting the air far away from the drum element. Setting the threshold too low, however, might result in missed hits. Especially when the threshold gets close to the noise level of the measurements, the hit detection might become unreliable.
