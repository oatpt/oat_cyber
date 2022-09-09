function kmitlmove(robotCell,Start,Finish,step)
ik = inverseKinematics('RigidBodyTree', robotCell.Robot);
weights = ones(1, robotCell.NumJoints-1);
for i = 1:step
    init_pose = robotCell.CurrentJointConfig;
    new_task_states = trvec2tform([Start(1)+i*((Finish(1)-Start(1))/step), Start(2)+i*((Finish(2)-Start(2))/step), Start(3)+i*((Finish(3)-Start(3))/step)])*axang2tform([0 1 0 pi]);
    [joint_sols, sols_info] = ik(robotCell.RobotEndEffector, new_task_states, weights, init_pose);
    robotCell.moveJoints(joint_sols);
end

end