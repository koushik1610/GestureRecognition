source_dir = uigetdir([]);
gestures = ["ABOUT","AND","CAN","COP","GOOUT","DEAF","DECIDE","FATHER","FIND","HEARING"];

for g_index = 1:length(gestures)
    gesture = gestures(g_index);
    d = dir([source_dir, char('/shuffle_'+ string(gesture) +'*.csv')]);
    n = length(d);
    for c = 1:n
        fileName = getfield(d(c),'name');
        pathName = getfield(d(c),'folder');
        %FOR WINDOWS:
        %PathName = char(PathName+"\");
        %[data, headers] = xlsread([PathName, FileName], 1);
        
        %For Mac Use This
        fileformac = fullfile(pathName,fileName);
        data = csvread(fileformac);
        [rows,cols] = size(data);
        
        %Getting Class Labels
        yClassLabel=data(:,cols);
        
        %Set the random number seed to make the rsults repeatable in this
        %script
        rng('default');
        %Predictor Matrix
        xData=double(data(:,1:end-1));
        
        %Split training Data into 60% Training and 40% Test
        cv=cvpartition(length(data),'holdout',0.40);
        xtrain = xData(cv.training,:);
        ytrain = yClassLabel(cv.training,1);
        xtest = xData(cv.test,:);
        ytest = yClassLabel(cv.test,1);
        
        %Setting max iterations
        opts = statset('MaxIter',1000);
        
        %Train the classifier
        svmModel = fitcsvm(xtrain,ytrain,'Standardize',true,'KernelFunction','RBF','KernelScale','auto');
      
        % CVSVMModel = crossval(SVMModel);
        % classLoss = kfoldLoss(CVSVMModel);
        
        %Generation Predictions based on Trained SVMModel
        yPredict = predict(svmModel, xtest);
        confusionMatrix = confusionmat(ytest,yPredict);
        trueNegative=confusionMatrix(1,1);
        falsePositive=confusionMatrix(1,2);
        falseNegative=confusionMatrix(2,1);
        truePositive=confusionMatrix(2,2);
        
        total=trueNegative+truePositive+falseNegative+falsePositive;
        accuracy=(truePositive+trueNegative)/total;
        precision=truePositive/(falsePositive+truePositive);
        recall=truePositive/(truePositive+falseNegative);
        f1Score=2*(precision*recall)/(precision+recall);
        
        fprintf('\nFor Gesture : %s \n',gesture);
        fprintf('\nThe Accuracy is : %d \n', accuracy*100.0);
        fprintf('The Precision is : %d \n', precision*100.0);
        fprintf('The Recall is : %d \n', recall*100.0);
        fprintf('The f1Score is : %d \n', f1Score*100.0);
    end
end