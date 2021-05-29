clc, clear, close all
%% Connect to ROS Network
%ros_ip = fileread("ROS_ip.txt");
rosshutdown;

rosinit("192.168.0.11",11311);
%% Load robot model
load('exampleHelperKINOVAGen3GripperROSGazebo.mat');
%% Initialize 
RoboCupManipulation_setInitialConfig;
physicsClient = rossvcclient('gazebo/unpause_physics');
call(physicsClient,'Timeout',3);
%% Configure ROS subscriber 
joint_state_sub = rossubscriber('/my_gen3/joint_states');
ros_action = '/my_gen3/gen3_joint_trajectory_controller/follow_joint_trajectory';
[trajAct,trajGoalMsg] = rosactionclient(ros_action);

rgbImgSub = rossubscriber('/camera/color/image_raw');     % camera sensor
rgbDptSub = rossubscriber('/camera/depth/image_raw');     % depth sensor

%% Define position bottle
run trajectory.m
clear data_log
data_log.translation=[];
data_log.orientation=[];
data_log.bin=[];
data_log.img=[];
data_log.depth=[];

base_pos=[-0.13, -0.1, 0.6];
offset=[0,0,0.025];
N=size(v_translation,1);
%N=3;
for k=1:N
  disp("Step "+k+" of "+N)
  pause(3)
  translation = v_translation(k,:)-base_pos+offset; 
  orientation=v_orientation(k,:);
  bin=v_bin(k);
  drop_item(translation,orientation,bin,robot);
end