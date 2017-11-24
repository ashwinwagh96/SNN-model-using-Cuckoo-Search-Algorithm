% Program that optimize a spiking neuron model for pattern classification
% using Cuckoo Search Algorithm and Levy Flight Model
clear all;clc;

%%
%Boundaries of search space
Lb=-20;
Ub= 20;

%CS algorithm and Levy Flight parameters
iter = 100;      % maximum number of iterations (generations)
Nests = 40;     % number of nest
lambda = 1.5;   % power law index
pa=0.25;        % Discovery rate of alien eggs/solutions
alpha = 1;      % Step Length        
Tolerance = 0.90;   % Minimum Fitness 
 
% Loading data
load ('iris1.mat');   % Contains DataTrain, DataTest,features and classes
% Number of parameters of the objective function 
dim=features-1;      

% Training the spiking neuron using CS
[x,iter,fitness_array,weights] = cuckoo_search('fitness',Tolerance,dim,Lb,Ub,Nests,DataTrain,Classes,iter,lambda,alpha,pa);

%Computing the performance of the methodology
[crTR, spikesTR, classesTR] = feval('fitness',x,1,DataTrain,Classes);
[crTE, spikesTE, classesTE] = feval('fitness',x,1,DataTest,Classes);
fprintf(1,'\nPercentage of recognition using training set: %f\n',100*crTR);
fprintf(1,'Percentage of recognition using testing set: %f\n',100*crTE);
        
