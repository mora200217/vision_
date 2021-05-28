
import os 

comm = "rostopic pub /my_gen3/joint_states sensor_msgs/JointState -- 'header: \nseq: 3802\n stamp: {secs: 0, nsecs: 0} \n frame_id: '' \nname: [gripper_finger1_joint, joint_1, joint_2, joint_3, joint_4, joint_5, joint_6, joint_7] \nposition: [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.14, 3.14]\nvelocity: [0.042563280105806706, 13.302033037172235, 0.5681920659929547, -24.94585050093948, -1.8305631265548623, 16.65703707971395, 2.504079640625841, -4.997805421957194]\neffort: [-0.16881502074212526, 39.0, -4.731635450516691, -39.0, -39.0, 9.0, 1.3005317207778808, -1.2342079975622866]'"
os.system(comm)