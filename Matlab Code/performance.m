% Function that compute the clasification performance
% Arguments:
%            Classes   : Number of classes
%            samplesTR : Number of patterns
%            spikesTR  : firing rate generated with each pattern
%            rate      : average firing rate
% Return values:
%            crTR     : classification performance
%            classesTR: The class to which each pattern was classified

function [crTR, classesTR]=performance(Classes,samplesTR,spikesTR,rate)

    countTR=0;
    classesTR=cell(1,Classes);

    for j=1:Classes
        [ns c]=size(spikesTR{j});
        crTR=zeros(ns,1);
        for k=1:ns
            [m, crTR(k)]=min(abs(rate-spikesTR{j}(k)));
        end
        classesTR{j}=crTR;
        crTR=find(crTR==j);

        [crTR c]=size(crTR);
        countTR=countTR+crTR;
    end

    crTR=countTR/samplesTR;
end
