function [Training,Test]=Make_Dataset(DataSetLocation,UnLabeledPercent)
    Data_Set=dlmread(DataSetLocation);
    if UnLabeledPercent>50 
        UnLabeledPercent=50;
    elseif UnLabeledPercent<5
        UnLabeledPercent=5;
    end
    Indices=crossvalind('Kfold',size(Data_Set,1),UnLabeledPercent);
    test=(Indices==1); train=~test;
    Training=Data_Set(train,1:end);  Test=Data_Set(test,1:end);
%     dlmwrite('DataSets/Created/Training_Set.dat',Training);
%     dlmwrite('DataSets/Created/Test_Set.dat',Test);
 
