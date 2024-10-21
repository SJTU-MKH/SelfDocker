FROM markhui/cudagl:11.4.1-runtime-ubuntu20.04-noetic

RUN cp /etc/apt/sources.list /etc/apt/sources.list.ori && \
    sed -i s@/archive.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list && \
    sed -i s@/security.ubuntu.com/@/mirrors.ustc.edu.cn/@g /etc/apt/sources.list &&\
    apt update

## Dependencies
RUN apt install -y git unzip cmake libusb-dev python3-tk

RUN git config --global http.proxy http://127.0.0.1:15777 && git config --global https.proxy http://127.0.0.1:15777
RUN mkdir -p /catkin_ws/dep/src /catkin_ws/iplanner/src
    
RUN apt install -y python3-pip && \
    pip3 install torch==1.12.1+cu113 torchvision==0.13.1+cu113 torchaudio==0.12.1 --extra-index-url https://download.pytorch.org/whl/cu113

RUN cd /catkin_ws/dep/src && \ 
    git clone https://github.com/HongbiaoZ/autonomous_exploration_development_environment.git -b noetic-rgbd-camera && \
    cd autonomous_exploration_development_environment && \
    cd /catkin_ws/iplanner/src && \
    git clone https://github.com/leggedrobotics/iPlanner.git &&\
    git clone https://github.com/MichaelFYang/iplanner_path_follow.git && \
    git clone https://github.com/MichaelFYang/waypoint_rviz_plugin.git && \
    git clone https://github.com/ros-drivers/joystick_drivers.git

COPY autonomous_exploration_environments.zip /catkin_ws/dep/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh 
RUN cd /catkin_ws/dep/src/autonomous_exploration_development_environment/src/vehicle_simulator/mesh && unzip *.zip && rm -rf *.zip

RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash; cd /catkin_ws/dep/; catkin_make'

RUN apt install -y libbluetooth-dev libspnav-dev libcwiid-dev
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash; cd /catkin_ws/iplanner; catkin build -DPYTHON_EXECUTABLE=$(which python3)'

RUN apt install -y zsh autojump  \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf ~/.zshrc
COPY .zshrc /root/.zshrc
RUN chsh -s /usr/bin/zsh

CMD ["zsh"]
COPY ros_entrypoint.sh /
RUN chmod +x ros_entrypoint.sh
ENTRYPOINT ["./ros_entrypoint.sh"]