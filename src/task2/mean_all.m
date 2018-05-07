% BROWSE TO processed_data dir created by processData.m
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];
feature_indices = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17];
for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    T = readtable(string(source_dir)+"/Action_" + gesture + ".csv");
    A = table2array(T);
    number_of_instances = height(T)/17;
    acc_gesture_instances = zeros(number_of_instances,17);
    for instance_index = 1:number_of_instances             
        instance_acc_mean = mean(table2array(T(feature_indices + 17*(instance_index-1),:)),2);
        acc_gesture_instances(instance_index,:) = transpose(instance_acc_mean);
    end
    acc_mean = mean(acc_gesture_instances);
    bar(acc_mean);
    xlabel('Sensor types (1 to 17)');
    ylabel('Mean');
    title(gesture);
    saveas(gcf,char(gesture + "_acc.png"))
end
