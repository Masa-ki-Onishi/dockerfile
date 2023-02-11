FROM ubuntu:22.04
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
# Setup Locale
RUN apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Set up ROS 2 sources
RUN apt update && apt install -y curl gnupg2 lsb-release
RUN curl http://repo.ros2.org/repos.key | apt-key add -
RUN sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu `lsb_release -cs` main" > /etc/apt/sources.list.d/ros2-latest.list'

# Install ROS 2 Humble
RUN apt update && apt install -y ros-humble-desktop

# Set up environment variables
ENV ROS_DOMAIN_ID 42

# source ROS 2 setup file
RUN echo "source /opt/ros/humble/setup.bash" >> ~/.bashrc

# Entry point
CMD ["bash"]
