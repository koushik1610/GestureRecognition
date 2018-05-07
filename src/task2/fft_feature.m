% BROWSE TO processed_data dir created by processData.m
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];
feature_indices = [4,5,6,7,8,9,10,11];
for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    T = readtable(string(source_dir)+"/Action_" + gesture + ".csv");
    A = table2array(T);
    number_of_instances = height(T)/17;
    fft_max_mag_indices = zeros(number_of_instances,65);
    for instance_index = 1:number_of_instances             
        instance_fft = abs(fft(sum(table2array(T(feature_indices + 17*(instance_index-1),:))),128))/1000;
        fft_max_mag_indices(instance_index,:) = instance_fft(1:65);
    end
    fft_max_mag_indices_mean = mean(fft_max_mag_indices);
    bar(fft_max_mag_indices_mean);
    xlabel('Frequency');
    ylabel('Amplitude');
    ylim([0 1])
    title(gesture);
    saveas(gcf,char(gesture + "_fft.png"))
end
