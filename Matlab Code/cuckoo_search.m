function [best_soln,iter,new_fitness,weights] = cuckoo_search(fitness_eval,Tolerance,dim,lb,ub,Nests,Data,Classes,Itermax,lambda,alpha,pa)

    weights = lb + (ub - lb).*rand(Nests,dim); 
    %error = zeros(1,Itermax);
    
    % Fitness function of all the nests
    for i=1:Nests
        fitness1(i) = feval(fitness_eval,weights(i,:),1,Data,Classes);
    end

    cuckoo = lb+(ub-lb).*rand(1,dim);   % Cuckoo initialized
    minfit = 0;
    iter = 0;
    
    while (iter < Itermax) && (minfit == 0)  
        iter = iter +1;
        cuckoo = cuckoo + alpha.*levy(1,dim,lambda); % Levy flight
        %fprintf(1,'\nCuckoo Weights: %f\n',cuckoo(1,:));
        cuckoo_fitness = feval(fitness_eval,cuckoo,1,Data,Classes);
        %fprintf(1,'\nCuckoo Fitness: %f\n',cuckoo_fitness);
        j = randi([1 Nests]);                        % Selecting random nest
        
        if cuckoo_fitness > fitness1(j)
           weights(j,:) = cuckoo;
           fitness1(j) = cuckoo_fitness;
        end

        % Arranging in descending order
        temp = [(fitness1)' weights];
        temp_sort = sortrows(temp,1);
        temp_sort = flip(temp_sort);
        
        new_fitness = (temp_sort(:,1))';
        new_weights = temp_sort(:,2:end);
        
        % Removing worst nests and building new ones
        remove = int16(pa*Nests);
        weights = new_weights(1:(Nests-double(remove)),:);
        join_weights = lb+(ub-lb).*rand(remove,dim);
        weights = [weights;join_weights];       % updated weights
        
        if new_fitness(1) > Tolerance
            minfit = 1;
        end

        for i=1:Nests
            fitness1(i) = feval(fitness_eval,weights(i,:),1,Data,Classes);
        end
        
        %error(1,iter) = 1-fitness1(1);
        %fprintf(1,'\nMaximum fitness: %f\n',fitness1(1));
        %disp(iter);
        
        cuckoo = weights(1,:);
    end 
    best_soln = weights(1,:);
    
end