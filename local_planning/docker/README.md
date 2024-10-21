# 局部路径规划docker镜像

## 镜像build
1. 根据菜鸟教程https://www.runoob.com/docker/docker-mirror-acceleration.html 对应的ubuntu版本安装docker与nvidia-docker
2. 将Dockerfile 放在单独文件夹下，打开终端，打开到Dockerfile所在文件夹路径下
3. 编译命令: `docker build -t lp:v1 .` 即可编译成功

## 镜像调用
1. 启动容器
```bash
docker run \
-it \
--gpus all \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
lp:v1 \
bash
```
2. 进入终端后，启动程序：`source /catkin_ws/devel/setup.bash &&  roslaunch vehicle_simulator system_garage.launch`
3. 然后会看到以下界面