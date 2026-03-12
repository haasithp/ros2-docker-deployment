# Base image: ROS 2 Humble with desktop/GUI tools for Gazebo
FROM osrf/ros:humble-desktop

# Set environment variables so the container doesn't hang waiting for timezone inputs
ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_DISTRO=humble

# Update and install core build tools, Gazebo dependencies, and X11 testing apps
RUN apt-get update && apt-get install -y \
    python3-colcon-common-extensions \
    python3-rosdep \
    python3-vcstool \
    git \
    build-essential \
    ros-humble-gazebo-ros-pkgs \
    ros-humble-xacro \
    x11-apps \
    && rm -rf /var/lib/apt/lists/*

# Initialize and update rosdep
RUN rosdep init || true && rosdep update

# Create the ROS 2 workspace structure
WORKDIR /ros2_ws
RUN mkdir src

# Automatically source the ROS 2 Humble environment every time you open a terminal
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

CMD ["bash"]
