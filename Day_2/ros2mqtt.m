classdef ros2mqtt
    properties
        mqttClient
        mqttTopic;
        ros2Node
        ros2Pub
        rosTopic
    end

    methods
        function obj = ros2mqtt(rosTopic,mqttTopic)
            obj.mqttClient = mqttclient('tcp://broker.hivemq.com')
            obj.mqttTopic = mqttTopic;
            %obj.ros2Node = ros2node('ros2mqttNode');
            obj.ros2Pub = ros2subscriber(rosTopic, "geometry_msgs/Twist", @obj.rosMsgHandler);
            obj.rosTopic = rosTopic;
            obj.ros2Pub.LatestMessage.Linear
        end

        function rosMsgHandler(obj, rosmsg)
            
            write(obj.mqttClient, obj.mqttTopic, rosmsg.Linear)
        end
    end
end