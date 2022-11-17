FROM ubuntu:20.04

# common variables
ENV ROS_WORKING_DIR=/root/ros2_ws
ENV ROS_WORKING_SRC_DIR=${ROS_WORKING_DIR}/src
ENV ROS_SETUP_SHELL=/opt/ros/foxy/setup.sh

# set locale
RUN  apt-get update && apt-get install locales \
    && locale-gen en_US en_US.UTF-8 \ 
    && update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && export LANG=en_US.UTF-8

# setup sources
RUN  apt-get install -y software-properties-common \
    &&  add-apt-repository universe
RUN  apt-get update &&  apt-get install -y curl gnupg2 lsb-release \
    &&  curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  \
    -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(echo focal) main" |  tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ROS deb packages
RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y ros-foxy-desktop python3-argcomplete ros-dev-tools


# crate package for simple publishing node
RUN . ${ROS_SETUP_SHELL} \
    && mkdir -p ${ROS_WORKING_SRC_DIR} \
    && cd ${ROS_WORKING_SRC_DIR} \
    && ros2 pkg create --build-type ament_python py_pub

COPY ./py_pub ${ROS_WORKING_SRC_DIR}/py_pub

# build package
WORKDIR ${ROS_WORKING_DIR}

RUN rosdep init \
    && rosdep update

RUN rosdep install -i --from-path src --rosdistro foxy -y \
    && colcon build --packages-select py_pub

RUN mkdir /logs

# command to run service
CMD . ${ROS_SETUP_SHELL} && . install/setup.sh && ros2 run py_pub talker
