FROM ubuntu:20.04

# set locale

RUN  apt-get update &&  apt-get install locales \
    && locale-gen en_US en_US.UTF-8 \ 
    &&  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8 \
    && export LANG=en_US.UTF-8

# setup sources

RUN  apt-get install -y software-properties-common \
    &&  add-apt-repository universe
RUN  apt-get update &&  apt-get install -y curl gnupg2 lsb-release \
    &&  curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  \
    -o /usr/share/keyrings/ros-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(echo focal) main" |  tee /etc/apt/sources.list.d/ros2.list > /dev/null

# install ROS package

RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y ros-foxy-desktop python3-argcomplete ros-dev-tools


# install python
# RUN apt-get install -y python3.9

RUN chmod +x /opt/ros/foxy/setup.sh

# simple publishing node
RUN . /opt/ros/foxy/setup.sh \
    && mkdir -p ~/ros2_ws/src \
    && cd ~/ros2_ws/src \
    #&& git clone https://github.com/ros/ros_tutorials.git -b foxy-devel \
    && ros2 pkg create --build-type ament_python py_pub
    #&& cd .. \
    #&& rosdep install -i --from-path src --rosdistro foxy -y

COPY ./py_pub /root/ros2_ws/src/py_pub
#COPY simple_publisher.py /root/ros2_ws/src/py_pub/py_pub
#COPY setup.cfg /root/ros2_ws/src/py_pub/
#COPY setup.py /root/ros2_ws/src/py_pub/
#COPY package.xml /root/ros2_ws/src/py_pub/

WORKDIR /root/ros2_ws

RUN rosdep init \
    && rosdep update

RUN rosdep install -i --from-path src --rosdistro foxy -y \
    && colcon build --packages-select py_pub

RUN mkdir /logs

CMD . /opt/ros/foxy/setup.sh && . install/setup.sh && ros2 run py_pub talker
