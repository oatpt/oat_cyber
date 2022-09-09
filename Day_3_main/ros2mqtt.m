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
            obj.mqttClient = mqttclient('tcp://broker.hivemq.com');
            obj.mqttTopic = mqttTopic;
            obj.ros2Node = ros2node('ros2mqttNode');
            obj.ros2Pub = ros2subscriber(obj.ros2Node, rosTopic, "geometry_msgs/Twist", @obj.rosMsgHandler);
            obj.rosTopic = rosTopic;
        end

        function rosMsgHandler(obj, rosmsg)
            x = rosmsg.linear.x;
            y = rosmsg.linear.y;
            z = rosmsg.linear.z;
            text = strcat('{"X": ',num2str(x),',"Y": ',num2str(y),',"Z": ',num2str(z),'}')
            write(obj.mqttClient, obj.mqttTopic, text)
        end
    end
end