load('iris.mat')

Total = [DataTrain;DataTest];
Total = Total(randperm(size(Total,1)),:);
Total1 = zeros(size(Total));

%for i = 2:size(Total1,2)           % Normalization
%Total1(:,i) = mat2gray(Total(:,i));
%end
%Total1(:,1) = Total(:,1)

 DataTest1 = Total(1:30,:);
 DataTrain1 = Total(31:150,:);
 features = 5;
 Classes = 3;
 save('iris1.mat','DataTest','DataTrain','features','Classes');