== Method

The method presented is based on the prediction of points in the image. The idea is to predict the position of the points in the image based on the previous positions. This prediction is then used to correct the pose estimation. Every incoming point is compared to the predicted position,
based on distance. The distance is used to determine if the newly detected point is either caused by jitter or noise, or if it is just caused by the movement of the object.

The method principle is best explained with a figure, @predicion-example. Points $A$ to $D$ are the previous positions of the points. Given the previous points, the predicted position $E$ is calculated. The current position $F$ is then compared to the predicted position $E$. If the distance between the predicted position $E$ and the current position $F$ is smaller than some threshold (e.g. the point $F$ would lie in the striped circle around $E$), the current position $F$ is considered to be caused by noise.
On the other hand, if the distance is larger than some other threshold (e.g. the point $F$ lies outside the blue circle around $E$), the current position $F$ is considered to be caused by jitter. Only if the distance is between these two thresholds, the current position F is considered to be caused by the movement of the object. Based on this information, the current position $F$ is corrected. $F$ could be entirely discarded and replaced with the predicted position. However, this might lead to abrupt changes in positions. A smoother result is achieved by interposing between the predicted position $E$ and the current position $F$.
#figure(caption: [Noise and Jitter reduction method principle. The horizontal axis is the time axis. The vertical axis is the value of the dots. Dots $A$ to $D$ are previous positions, $E$ is the predicted position, $F$ is the current position from MediaPipe.])[
  #image("../images/prediction-example.svg")
] <predicion-example>


=== Prediction

One aspect of the method is the prediction of the position of the points. The prediction is based on the previous positions of the points. Since we are dealing with points that are close together in time, a simple linear prediction is sufficient. To further clarify this: we are tracking the movement of a human, of which the movements are non-cyclic and non-deterministic. This means that the movement of the person is not predictable in the long term. However, in the short term (consecutive frames) the movement is predictable. Advanced prediction methods are therefore not necessary.

Every point has a timestamp $t$ and a value $y$. For every pair of consecutive points $P_1$ $(t_1, y_1)$ and $P_2$ $(t_2, y_2)$ a vector $arrow(v)$ can be computed. The vector $arrow(v)$ is the direction from $P_1$ to $P_2$ with the length of the vector indicating the velocity of the point: $arrow(v) = (P_2 - P_1) / (t_2 - t_1)$. We divide by the time difference to get the change in value per time unit, which is the velocity.
This is done because in a live stream setting, the time difference between frames can vary because of dropped frames, for example.

When a new position $P_3$ $(t_3, y_3)$ is returned by MediaPipe, the predicted position $P'_3$ can be calculated by adding the vector $arrow(v)$ to the last known position $P_2$, multiplied by the time difference between $P_2$ and $P_3$:
$ P'_3 = P_2 + arrow(v).(t_3 - t_2)$
The predicted position $P_3'$ is then compared to the actual position $P_3$ to determine if the point is caused by noise, jitter, or the movement of the object.

The prediction requires keeping a memory of a given amount of previous points. The description above only considers the last 2 points. However, the method can be extended to consider more points. When considering more points, the vector $arrow(v)$ is calculated by averaging the vectors of the last $n$ points. This is done to reduce the effect of noise and jitter in the prediction. When too many points are considered, the prediction might not be reactive enough to more sudden changes in the movement of the object. One might also opt for a weighted average, where the most recent points have a higher weight in the average, to give more importance to the most recent points. Using a weighted average has not been tested in this research.

=== Correction

After the prediction has been made, the correction of the current position is done. The correction is based on the distance between the predicted position and the actual position. The distance is calculated using the Euclidean distance. The principle idea of correction has already been discussed above. Small differences in distance indicate noise, large differences indicate jitter. But, instead of discarding these positions, we interpolate between the predicted position and the actual position.

Consider the interpolation function $f(x)$, with $x >= 0$ the distance between the predicted position and the actual position to a value between 0 and 1: $f(x): [0, infinity[ -> [0, 1]$. A value of 0 means that the predicted position is used, a value of 1 means that the actual position is used. Take $P$ to be the actual position, $P'$ the predicted position and an interpolation factor $b$. The corrected position is than:
$hat(P) = (1 - b).P' + b.P$ .

The chosen interpolation function is: $f(x) = e^(-(log_e (x))^2)$, @interpolation-function. The function is smooth, to avoid abrupt changes in the corrected position.
Secondly, This function is not picked randomly. It has some nice properties. The function remains close to zero for small values of $x$, meaning that the predicted position is mainly used when the distance is small. This is important because small distances indicate noise. The predicted values are assumed to be less noisy than the actual values, as they are based on the previous positions. This noise reduction is why the interpolation should not reach its maximum value of 1 for small distances.
The long tail of the function ensures that large distances are not entirely discarded. Because we are not entirely sure if the large distances are caused by jitter or by the movement of the object, we want to keep some of the actual position.

#figure(caption: [Interpolation function. The horizontal axis is the distance between the predicted position and the actual position. The vertical axis is the interpolation factor. The blue line is $g(x) = x$ which helps see what happens with values of $x$ between $[0, 1]$])[
  #image("../images/interpolation-function.svg")
] <interpolation-function>

It is essential to understand the reasoning behind reaching a maximum value of 1. It is perfectly reasonable for the user to perform a movement that is not predicted by the method, without being an outlier. Consider a person who is standing still and suddenly starts walking. The method will predict the person to be standing still. This action by the user is not an outlier, but the method cannot predict the movement. The method should not discard the actual position in this case. Setting the maximum value of the interpolation function to 1 ensures that the actual position is not discarded in such cases.

Two parameters are used to tune the parameter function. A first parameter determines the distance at which the interpolation function reaches its maximum value. Call this parameter $d$, the interpolation function becomes: $f(x) = e^(-(log_e (x / d))^2)$. The effect of this parameter is shown in @interpolation-function-d. Note that it not only changes the distance at which the interpolation function reaches its maximum value, but also the steepness of the function. By setting $d$ to a lower value, we lower the acceptable range of movement. This is particularly useful as we are working in the image frame where the positions are already normalized to be between 0 and 1.
#footnote[
  Remember the `Landmark` type of marker. The positions are normalized to be between 0 and 1. This means that the distance between two points will be, on average, a lot smaller than 1.
]

#figure(caption: [Interpolation function with $d = 0.5$. The horizontal axis is the distance between the predicted position and the actual position. The vertical axis is the interpolation factor. The blue line is $g(x) = x$ to help visualize the effect of $d$])[
  #image("../images/interpolation-function-d.svg")
] <interpolation-function-d>

A second parameter further controls the “tightness” of the interpolation around the maximum value. Call this parameter $s$, the interpolation function becomes: $f(x) = e^(-s.(log_e (x / d))^2)$ and is shown in @interpolation-function-s. The parameter $s$ controls the falloff of the function. A higher value of $s$ means that the function falls off more quickly on both sides of the maximum value. This means that the interpolation is stricter.

#figure(caption: [Interpolation function with $d = 0.5$ and $s = 4$. The horizontal axis is the distance between the predicted position and the actual position. The vertical axis is the interpolation factor. The blue line is $g(x) = x$ to help visualize the effect of $s$])[
  #image("../images/interpolation-function-s.svg")
] <interpolation-function-s>
