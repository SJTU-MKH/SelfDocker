FROM osrf/ros:noetic-desktop-full

ENV DEBIAN_FRONTEND=noninteractive
ENV ROS_VERSION_NAME=noetic

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

RUN apt install -y wget git unzip cmake libeigen3-dev

RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777

RUN mkdir -p ~/Documents/AirSim
COPY settings.json ~/Documents/AirSim/settings.json
RUN apt-get install -y libarmadillo-dev
RUN apt-get install -y ros-${ROS_VERSION_NAME}-octomap*
RUN apt-get install -y ros-${ROS_VERSION_NAME}-tf2-sensor-msgs ros-${ROS_VERSION_NAME}-tf2-geometry-msgs ros-${ROS_VERSION_NAME}-mavros*
RUN apt-get install -y gcc-8 g++-8

RUN mkdir -p ~/catkin_ws/src && cd ~/catkin_ws/src && git clone https://github.com/ZJU-FAST-Lab/Fast-Racing

RUN /bin/bash -c 'source /opt/ros/${ROS_VERSION_NAME}/setup.bash; cd ~/catkin_ws; catkin_make -DCMAKE_C_COMPILER=gcc-8 -DCMAKE_CXX_COMPILER=g++-8 '

RUN apt install -y zsh autojump  \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf ~/.zshrc
COPY .zshrc /root/.zshrc
RUN chsh -s /usr/bin/zsh

CMD ["zsh"]

ENTRYPOINT ["./ros_entrypoint.sh"]