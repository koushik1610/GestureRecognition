% BROWSE to directory containing data files. This can be anyone of the
% directory from DM1 to DM37. The program creates processed_data directory
% which is used in all other scripts
source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","DEAF","DECIDE","FATHER","FIND","GOOUT","HEARING"];
% We only need 17 columns. Sensors worn on right hand
columns_required = [4,5,6,15,16,17,18,19,20,21,22,26,27,28,32,33,34];
for g_index = 1:length(gestures)
    concatGesture = [];
    gesture = gestures(g_index);
    d = dir([source_dir, char('/'+ string(gesture) +'*.csv')]);
    n = length(d);
    for c = 1:n
        disp(d(c))
        name = getfield(d(c),'name');
        path = getfield(d(c),'folder');
        T = readtable(string(path)+"/" +string(name));
        A = table2array(T(1:35,columns_required));
        A = transpose(A);
        concatGesture= vertcat(concatGesture,A);
    end
    mkdir('processed_data');
    csvwrite('processed_data/Action_'+gesture+'.csv',concatGesture);
end