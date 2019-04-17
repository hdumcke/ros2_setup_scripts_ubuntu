#!/usr/bin/env bash
set -eu

# REF: https://index.ros.org/doc/ros2/Installation/Linux-Install-Debians/

CHOOSE_ROS_DISTRO=crystal # or bouncy or ardent
INSTALL_PACKAGE=desktop # or ros-base

sudo apt update
sudo apt install -y curl gnupg2 lsb-release
curl http://repo.ros2.org/repos.key | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64,arm64] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/ros2-latest.list'
sudo apt update
sudo apt install -y ros-$CHOOSE_ROS_DISTRO-$INSTALL_PACKAGE
if [ "$(lsb_release -cs)" = "bionic" ]; then
	sudo apt install -y python3-argcomplete
elif [ "$(lsb_release -cs)" = "xenial" ]; then
	sudo apt install -y python3-pip
	sudo pip3 install argcomplete
fi
sudo apt install -y python3-colcon-common-extensions
grep -F "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" ~/.bashrc ||
echo "source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash" >> ~/.bashrc

set +u

source /opt/ros/$CHOOSE_ROS_DISTRO/setup.bash

echo "success installing ROS2 $CHOOSE_ROS_DISTRO"
