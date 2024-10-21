FROM markhui/ros:foxy-noetic-go2-amd-base

RUN apt update && apt install  ros-noetic-jsk-recognition -y

ENTRYPOINT ["./ros_entrypoint.sh"]
