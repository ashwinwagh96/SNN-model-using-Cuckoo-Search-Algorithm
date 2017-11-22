function [best_soln,iter] = cuckoo_search(fitness_eval,Tolerance,dim,lb,ub,Nests,Data,Classes,Itermax,lambda,alpha,pa)

    weights = lb + (ub - lb).*rand(Nests,dim); %40x4
    % Fitness function of all the nests
    fitness = feval(fitness_eval,weights,Nests,Data,Classes);
    
    cuckoo = lb+(ub-lb).*rand(1,dim);   % Cuckoo initialized
    minfit = 0;
    iter = 0;
    %alpha = 1; 
    while (iter < Itermax) && (minfit == 0)  
        iter = iter +1;
        cuckoo = cuckoo + alpha.*levy(1,dim,lambda); % Levy flight
        cuckoo_fitness = feval(fitness_eval,cuckoo,1,Data,Classes);
        j = randi([1 Nests]);   % Selecting random nest
        
        if cuckoo_fitness > fitness(j)
           weights(j,:) = cuckoo;
           fitness(j) = cuckoo_fitness;
        end
        
        % Arranging in descending order
        new_fitness = sort(fitness,'descend');
        new_weights = zeros(size(weights));
        
        for k = 1:size(new_fitness,2)
            index = find(fitness(:) == new_fitness(k));
            if size(index) > 1
                for i=1:size(index)
                    new_weights(k+i-1,:)= weights(index(i,1),:);
                end
                k = k+size(index);
            else
                new_weights(k,:) = weights(index(1),:);
            end
        end
        
        % Removing worst nests and building new ones
        remove = int16(pa*Nests);
        weights = new_weights(1:(Nests-double(remove)),:);
        join_weights = lb+(ub-lb).*rand(remove,dim);
        weights = [weights;join_weights];
        
        fitness = feval(fitness_eval,weights,Nests,Data,Classes);
        if fitness(1,1) < Tolerance
            minfit = 1;
        end
    end 
    best_soln = weights(1,:);
end