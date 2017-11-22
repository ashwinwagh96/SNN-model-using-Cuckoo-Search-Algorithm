% Program that optimize a spiking neuron model for pattern classification
% using Cuckoo Search Algorithm and Levy Flight Model
clear all;clc;


%%
%Boundaries of search space
Lb=0;
Ub=100;

%CS algorithm and Levy Flight parameters
iter = 1000;    % maximum number of iterations (generations)
Nests = 40;     % number of nest
lambda = 1.5;   % power law index
pa=0.25;        % Discovery rate of alien eggs/solutions
%pa = 0.15;
alpha = 1;
Tolerance = 1E-12;
 
% Loading data
load ('iris1.mat');   % Contains DataTrain, DataTest,features and classes
% Number of parameters of the objective function 
dim=features-1;      

% Training the spiking neuron using CS
[x,iter] = cuckoo_search('fitness',Tolerance,dim,Lb,Ub,Nests,DataTrain1,Classes,iter,lambda,alpha,pa);

%Computing the performance of the methodology
[crTR, spikesTR,classesTR] = feval('fitness2',x,1,DataTrain1,Classes);  
[crTE, spikesTE, classesTE] = feval('fitness2',x,1,DataTest1,Classes);
fprintf(1,'\nPercentage of recognition using training set: %f\n',100*crTR);
fprintf(1,'Percentage of recognition using testing set: %f\n',100*crTE);


        
