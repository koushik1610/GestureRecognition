% BROWSE TO processed_data dir created by processData.m
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];

for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    T = readtable(string(source_dir)+"/Action_" + gesture + ".csv");
    A = table2array(T);
    number_of_instances = height(T)/17;
    variance_instances = zeros(number_of_instances,17);
    for instance_index = 1:number_of_instances             
            variance_instances(instance_index,:) = transpose(std(table2array(T(17*(instance_index-1)+1:17*instance_index,:)),0,2));          
    end
    variance_instances_mean = mean(variance_instances);
    bar(variance_instances_mean);
    xlabel('Data streams 1 to 17')
    ylabel('Standard deviation')
    title(gesture);
    saveas(gcf,char(gesture + "_var.png"))
end
