% BROWSE TO processed_data dir created by processData.m
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];
for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    T = readtable(string(source_dir)+"/Action_" + gesture + ".csv");
    A = table2array(T);
    number_of_instances = height(T)/17;
    max_indices = zeros(number_of_instances,17);
    for instance_index = 1:number_of_instances             
            [p,q] = max(table2array(T(17*(instance_index-1)+1:17*instance_index,:)),[],2);
            max_indices(instance_index,:) = transpose(q);
    end
    max_indices_mean = mean(max_indices);
    bar(max_indices_mean);
    title(gesture);
    saveas(gcf,char(gesture + "_mi.png"))
end
