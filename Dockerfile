FROM conroycheers/ros2-ros1-env:latest

WORKDIR /ros2_overlay_ws/
RUN mkdir src
WORKDIR /ros2_overlay_ws/src
RUN git clone git https://github.com/conroy-cheers/cone_detector.git
