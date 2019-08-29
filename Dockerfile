FROM conroycheers/ros2-ros1-env:latest

WORKDIR /ros2_overlay_ws/src
RUN git clone https://github.com/conroy-cheers/cone_detector.git
RUN git clone https://github.com/ros-perception/image_common.git --branch ros2
RUN git clone https://github.com/ros-perception/image_transport_plugins.git --branch ros2
RUN git clone https://github.com/ros-perception/vision_opencv.git --branch ros2

WORKDIR /ros2_overlay_ws
RUN source install/setup.bash && \
	colcon build
