FROM markhui/ros:foxy-go2

RUN apt install -y zsh autojump  \
    && git clone https://github.com/ohmyzsh/ohmyzsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc \
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    && rm -rf ~/.zshrc
COPY .zshrc /root/.zshrc
RUN chsh -s /usr/bin/zsh

ENTRYPOINT ["./ros_entrypoint.sh"]