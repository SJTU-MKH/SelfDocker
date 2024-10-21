FROM ros:humble
ENV ROS_DISTRO=humble

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y git cmake ros-${ROS_DISTRO}-rmw-cyclonedds-cpp ros-${ROS_DISTRO}-rosidl-generator-dds-idl

RUN cd ~ && git clone https://github.com/unitreerobotics/unitree_ros2

RUN cd ~/unitree_ros2/cyclonedds_ws/src && \
    git clone https://github.com/ros2/rmw_cyclonedds -b ${ROS_DISTRO} && \
    git clone https://github.com/eclipse-cyclonedds/cyclonedds -b releases/0.10.x

RUN /bin/bash -c "cd ~/unitree_ros2/cyclonedds_ws; colcon build --packages-select cyclonedds"

RUN /bin/bash -c "cd ~/unitree_ros2/cyclonedds_ws; source /opt/ros/${ROS_DISTRO}/setup.bash; colcon build"

RUN apt install -y zsh autojump  \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf ~/.zshrc
COPY .zshrc /root/.zshrc
RUN chsh -s /usr/bin/zsh

ENTRYPOINT ["./ros_entrypoint.sh"]