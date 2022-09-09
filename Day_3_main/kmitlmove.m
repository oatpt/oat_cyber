% function kmitlmove(robotCell,Finish)
% ik = inverseKinematics('RigidBodyTree', robotCell.Robot);
% weights = ones(1, robotCell.NumJoints-1);
% for i = 1:10
%     init_pose = robotCell.CurrentJointConfig;
%     pose = robotCell.CurrentTaskConfig;
%     new_task_states = trvec2tform([pose(1,4)+i*((Finish(1))*0.001), pose(2,4)+i*((Finish(2))*0.001), pose(3,4)+i*((Finish(3))*0.001)])*axang2tform([0 1 0 pi]);
%     joint_sols = ik(robotCell.RobotEndEffector, new_task_states, weights, init_pose);
%     robotCell.moveJoints(joint_sols);
% end

% end
function kmitlmove(robotCell,Finish)
ik = inverseKinematics('RigidBodyTree', robotCell.Robot);
weights = ones(1, robotCell.NumJoints-1);
init_pose = robotCell.CurrentJointConfig;
pose = robotCell.CurrentTaskConfig;
new_task_states = trvec2tform([Finish(1)+pose(1,4) Finish(2)+pose(2,4) Finish(3)+pose(3,4)])*axang2tform([0 1 0 pi]);
joint_sols = ik(robotCell.RobotEndEffector, new_task_states, weights, init_pose);
robotCell.moveJoints(joint_sols);
end