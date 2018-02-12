% Differential Evolution (DE) by Storner and Price (1).
% DE is an optimization method that does not use the
% gradient of the problem. This is the DE/rand/1/bin variant.
% Literature references:
% (1) R. Storn and K. Price. Differential evolution - a simple
%     and efficient heuristic for global optimization over
%     continuous spaces. Journal of Global Optimization,
%     11:341-359, 1997.

% ------------------------------------------------------
% Part of the code is aken from:
% SwarmOps on the internet: http://www.Hvass-Labs.org/
% ------------------------------------------------------


% Input:
%     objective_function: @(param) SSE(function(param,Xdata),Ydata).
%     LowerBound: Lower Bound of parameters as a vector.
%     UpperBound: Upper Bound of parameters as a vector.
%     problem__parameters: a vector comprises  dimension of the swarm ,
%     maximum number of iterations and acceptable value of fitness;  
%     behavioral_parameters; behavioural parameters for PSO, a vector
%     comprises Swarm-size, Inertia weight, Particle's best weight and   
%     Swarm's best weight.
                 
% Output:
%     BestX; best found position in the search-space.
%     FitnessValues; fitness value of bestX at each iteration.


function [BestX, FitnessValues] = DE(objective_function, LowerBound,UpperBound, problem__parameters, behavioral_parameters)

    
    n=problem__parameters(1);  
    maxEvaluations=problem__parameters(2);
    acceptableFitness=problem__parameters(3);

    % Behavioural parameters for this optimizer.
    s= behavioral_parameters(1);     % Population size
    cr = behavioral_parameters(2);   % Crossover probability.
    f = behavioral_parameters(3);    % Differential weight.


     % Initialize swarm:
     x = zeros(s,n);  %position particles

    for i=1:s
        x(i,:) = rand(1,n).*(UpperBound-LowerBound) + LowerBound;
    end
    
    FitnessValues=zeros(1,maxEvaluations-1);     %fitness value of bestX at each iteration

    % Compute fitness of initial particle positions:
    fitness = zeros(1, s); 
    
    for i=1:s
        fitness(i) = feval(objective_function, x(i,:));
    end

    % Determine fitness and index of best particle:
    [bestFitness, bestIndex] = min(fitness);

    % Perform optimization iterations until acceptable fitness
    % is achieved or the maximum number of fitness evaluations
    % has been performed: 
    
    evaluations = 1; % Fitness evaluations above count as iterations.
    
    while (evaluations < maxEvaluations) && (bestFitness > acceptableFitness)

         for i=1:s
        % Pick random and distinct agents from population:
        indices = randperm(s);
        i = indices(1);        % Agent to update.
        a = indices(2);        % Other agent a.
        b = indices(3);        % Other agent b.
        c = indices(4);        % Other agent c.

        % Pick random index:
        R = ceil(n * rand(1,1));

        % Copy old agent as a basis for the new agent:
        y = x(i,:);

        % Compute new agent using DE formula:
        for j=1:n
            if (j==R) || (rand(1,1) < cr)
                y(j) = x(i,j) + f * (x(b,j) - x(c,j));
            end
        end

        % Bound position to search-space:
        y = bound(y, LowerBound, UpperBound);

        % Compute fitness function:
        newFitness = feval(objective_function, y);

        % Update best-known positions:
        if newFitness < fitness(i)
            % Update particle's best-known fitness:
            fitness(i) = newFitness;

            % Update particle's best-known position:
             x(i,:) = y;

        end
            % Update swarm's best-known position:
            if newFitness < bestFitness
                bestIndex = i;                
                bestFitness = newFitness;
            end
            
                
                
         end
        
                FitnessValues(evaluations) = bestFitness;

        
        % Increment counter:
        evaluations = evaluations + 1;
   


    end
    % Return best found solution, fitness already set.
    BestX = x(bestIndex,:);
end

% -------------------------------------------------------------
