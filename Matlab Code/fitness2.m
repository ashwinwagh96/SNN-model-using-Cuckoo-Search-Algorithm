% Function that classified pattern in terms of the firing rate
% Arguments:
%            Weights: Populations of solutions
%            Nests  : Number of solution
%            Data   : Patterns to be classified
%            Classes: Number of classes
%
% Return values:
%                Apts     : fitness value of each solution
%                spikes   : firing rate generated with each pattern
%                classesTR: the class to which each pattern was classified

function [fit_array,spikes,classesTR]=fitness2(Weights,Nests,Data,Classes)
%Computing number of patterns to be classified and number of features of
%each pattern
    [samples, ~]=size(Data);

    T=1000; %Simulation time for the spiking neuron

    %matrix that allocate all the fitness value of each solution
    fit_array=zeros(1,Nests);

    %Computing firing rates
    ncl=zeros(1,Classes);
    for i=1:Classes
        n=find(Data(:,1)==i);
        [ncl(i), ~]=size(n);
    end
    spikes=cell(1,Classes);
    for i=1:Classes
        spikes{i}=zeros(ncl(i),1);
    end

    for ind=1:Nests
        inx=ones(1,Classes);
        for i=1:samples
             spikes{Data(i,1)}(inx(Data(i,1)))= izhikevich(Weights(ind,:),T,Data(i,2:end));
             inx(Data(i,1))=inx(Data(i,1))+1;
        end

        for i=1:Classes
            me(i)=mean(spikes{i});
        end

    end
        %compute classification performance
        [crTR, classesTR]=performance(Classes,samples,spikes,me);
        fit1=crTR;
        %fit1 = crTR;
        fit_array(ind)=fit1;
end
