function [S,Training,TrainLables,Unlabled,Unlables,Test,TestLables]=S3VM(DatasetLocation,TestRatio,UnlabledRatio)
[Training,TrainLables,Unlabled,Unlables,Test,TestLables]=Make_Dataset(DatasetLocation,TestRatio,UnlabledRatio);
%% Preprocessing of Dataset
% Class Label Modification
    S=[];      
    S.SVMStruct=svmtrain(Training,TrainLables,'autoscale','true','kernel_function','rbf','method','QP');
    S.Group = svmclassify(S.SVMStruct,Test);
    S.UGroup = svmclassify(S.SVMStruct,Unlabled);
    corrects=0; ucorrects=0;
    for i=1:size(Test,1)
        if(S.Group(i)==TestLables(i))
            corrects=corrects+1;
        end
        if(S.UGroup(i)==Unlables(i))
            ucorrects=ucorrects+1;
        end
    end
    S.Accuracy=(corrects)/size(Test,1);
    S.UAccuracy=(ucorrects * 10)/size(Unlabled,1);
