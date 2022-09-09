classdef mqtt2ros
    properties
        mqttClient
        mqttTopic
        ros2Node
        ros2Pub
        rosTopic
    end

    methods
        function obj = mqtt2ros()
%             obj.ros2Node = ros2node('mqtt2rosNode');
%             obj.ros2Pub = ros2publisher(obj.ros2Node, rosTopic, "geometry_msgs/Twist");
%             obj.rosTopic = rosTopic;
            obj.mqttTopic = "topgun/team1/geo";
            obj.mqttClient = mqttclient("tcp://154.215.14.239",Port=1883,Username="KMITL-01",ClientID="KMITL01",Password="KMITL-01")
            %subscribe(obj.mqttClient, obj.mqttTopic, 'Callback', @(topic,msg) obj.mqttMsgHandler(topic,msg))            
            subscribe(obj.mqttClient, "topgun/team1/geo", 'Callback', @(topic,msg) obj.mqttMsgHandler(topic,msg))            
        
        end

        function mqttMsgHandler(obj, topic, msg)
            text = jsondecode(msg);
            disp(text);
            %disp(text.X);
            %disp("z = ",text.Z);
%             if strcmp(topic, obj.mqttTopic)
%                 rosmsg = ros2message(obj.ros2Pub);
%                 text = jsondecode(msg);
%                 rosmsg.linear.x = text.dX;
%                 rosmsg.linear.y = text.dY;
%                 rosmsg.linear.z = text.dZ;
%                 send(obj.ros2Pub, rosmsg);
%                 disp(rosmsg);
%             else
%                 disp(topic)
%                 disp('Wrong ROS topic')
%             end
        end
    end
end