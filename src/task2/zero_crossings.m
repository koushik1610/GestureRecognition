% BROWSE TO processed_data dir created by processData.m
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];
sensor_indices = [1,2,3,12,13,14];

for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    T = readtable(string(source_dir)+"/Action_" + gesture + ".csv");
    A = table2array(T);
    number_of_instances = height(T)/17;
    crossing_counts = zeros(number_of_instances,6);
    for instance_index = 1:number_of_instances
        for sensor_type = 1:6
            row_index = (instance_index-1)*17 + sensor_indices(sensor_type);
            crossing_counts(instance_index,sensor_type) = length(zerocross(table2array(T(row_index,:))));
        end
    end
    mean_crossings = mean(crossing_counts);
    bar(categorical({'ax','ay','az','gx','gy','gz'}),mean_crossings);
    ylabel('Number of zero crossings')
    title(gesture)
    saveas(gcf,char(gesture + "_zc.png"))
end


function z=zerocross(v)
  z=find(diff(v>0)~=0)+1;
end
