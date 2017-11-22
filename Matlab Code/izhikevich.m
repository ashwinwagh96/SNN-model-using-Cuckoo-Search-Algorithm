%% This function returns the total number of spikes fired by an Izhikevich
% neuron in the specified simulation time T for pattern Input and weights S 

function [spikes]=izhikevich(Weights,Time,Features)
    % parameters used for RS neuron
    C=100; vr=-60; vt=-40; k=0.7; 
    a=0.03; b=-2; c=-50; d=100; 
    vpeak=35; % spike cutoff
    %T=1000; 
    tau=1; % time span and step (ms)
    n=round(Time/tau); % number of simulation steps
    v=vr*ones(1,n); u=0*v; % initial values
    spikes=0;
    gamma = 100;
    %gamma = 200;
    %theta = 100;
    I = gamma*sum(Features.*Weights);
    % forward Euler method
    for i=1:n-1 
        v(i+1)=v(i)+tau*(k*(v(i)-vr)*(v(i)-vt)-u(i)+I)/C;
        u(i+1)=u(i)+tau*a*(b*(v(i)-vr)-u(i));
        if v(i+1)>=vpeak        % spike firing
            v(i)=vpeak; 
            v(i+1)=c;           % membrane voltage reset
            u(i+1)=u(i+1)+d;    % recovery variable update
            spikes=spikes+1;
        end
    end
end