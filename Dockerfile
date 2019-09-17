FROM conroycheers/ros2-ros1-env:latest

WORKDIR /ros2_overlay_ws/src
RUN git clone https://github.com/ros-perception/image_common.git --branch ros2
RUN git clone https://github.com/ros-perception/image_transport_plugins.git --branch ros2
RUN git clone https://github.com/ros-perception/vision_opencv.git --branch ros2

RUN apt-get install -y libogg-dev libtheora-dev unzip
RUN ln -s /usr/include/eigen3/Eigen /usr/include/Eigen

WORKDIR /tmp
RUN /bin/bash -c "git clone --depth 1 --branch 3.4.7 https://github.com/opencv/opencv && \
				  git clone --depth 1 --branch 3.4.7 https://github.com/opencv/opencv_contrib"
RUN /bin/bash -c "cd opencv && \
				  mkdir build && \
				  cd build && \
				  cmake -D CMAKE_BUILD_TYPE=RELEASE \
					-D CMAKE_INSTALL_PREFIX=/usr/local \
				    -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/modules \
				    -D ENABLE_NEON=ON \
				    -D ENABLE_VFPV3=ON \
				    -D BUILD_TESTS=OFF \
				    -D INSTALL_PYTHON_EXAMPLES=OFF \
				    -D OPENCV_ENABLE_NONFREE=ON \
				    -D CMAKE_SHARED_LINKER_FLAGS='-latomic' \
				    -D BUILD_EXAMPLES=OFF .."
RUN /bin/bash -c "cd opencv/build && \
				  make -j$(nproc --all) install"
RUN /bin/bash -c "cd opencv/build && ldconfig"

WORKDIR /ros2_overlay_ws
RUN /bin/bash -c "source /ros2_ws/install/setup.bash && colcon build"

WORKDIR /ros2_overlay_ws/src
RUN git clone https://github.com/conroy-cheers/cone_detector.git

WORKDIR /ros2_overlay_ws
RUN /bin/bash -c "source install/setup.bash && \
	colcon build"
