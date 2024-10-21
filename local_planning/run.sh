roscore &
ROSCORE_PID=$!
sleep 1
# rviz -d ../autonomous_exploration_development_environment/src/vehicle_simulator/rviz/vehicle_simulator.rviz
# RVIZ_PID=$!

echo "************"
docker run \
-it \
--gpus all \
-e DISPLAY=$DISPLAY \
-v /tmp/.X11-unix:/tmp/.X11-unix:rw \
lp:v4 \
/bin/bash -c \
"cd /catkin_ws/; \
    source /opt/ros/melodic/setup.bash \
    source /catkin_ws/devel/setup.bash; \
    export ROS_MASTER_URI=http://MSP:11311 \
    roslaunch vehicle_simulator system_garage.launch"

source /catkin_ws/devel/setup.bash &&  roslaunch vehicle_simulator system_garage.launch
wait $ROSCORE_PID
wait $RVIZ_PID

if [[ $? -gt 128 ]]
then
    kill $ROSCORE_PID
    kill $RVIZ_PID
fi