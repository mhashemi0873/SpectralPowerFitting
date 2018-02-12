% Particle Swarm Optimization (PSO) by Eberhart et al. (1, 2).
% PSO is an optimization method that does not use the
% gradient of the problem. This is a basic 'global-best' variant.
% Literature references:
% (1) J. Kennedy and R. Eberhart. Particle swarm optimization.
%     In Proceedings of IEEE International Conference on Neural
%     Networks, volume IV, pages 1942-1948, Perth, Australia, 1995
% (2) Y. Shi and R.C. Eberhart. A modified particle swarm optimizer.
%     In Proceedings of the IEEE International Conference on
%     Evolutionary Computation, pages 69-73, Anchorage, AK, USA, 1998.

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

function [BestX, FitnessValues,evaluations,  Trace_Gbest,Trace_TP,CR] = PSO_CR(objective_function, lowerBound,upperBound, problem__parameters, behavioral_parameters, R)

    % problem parameters:
    n=problem__parameters(1);                   % dimension of the swarm   
    maxEvaluations=problem__parameters(2);      % maximum number of iterations
    acceptableFitness=problem__parameters(3);   %acceptable fitness
    
    % Behavioural parameters of PSO:
    s = behavioral_parameters(1);       % Swarm-size
    phiP = behavioral_parameters(3);    % Particle's best weight.
    phiG = behavioral_parameters(4);    % Swarm's best weight.
  
    maxw = 0.9-eps;   % Maximum inertia weight value
    minw = 0.4+ eps;  % Minimum inertia weight value
   
    weveryit = floor(0.75*maxEvaluations);   % Inertia decreasing step
    inertdec = (maxw-minw)/weveryit;         % Inertia weight decrement
    w = maxw;                                % initial inertia weight
    
    % Initialize the velocity boundaries:
    lowerVelocity = -0.5*(upperBound-lowerBound);
    upperVelocity =  0.5*(upperBound-lowerBound);

    % Initialize swarm:
     x = zeros(s,n);  %position particles
     v = zeros(s,n);  %velocity particles

    for i=1:s
        x(i,:) = rand(1,n).*(upperBound-lowerBound) + lowerBound;
        v(i,:) = rand(1,n).*(upperVelocity-lowerBound) + lowerVelocity;        
    end
    
   
    p = x;    % Best-known positions
    
    FitnessValues=zeros(1,maxEvaluations-1);     %fitness value of bestX at each iteration
    
    Trace_TP1=zeros(s,maxEvaluations-1);
    Trace_TP2=zeros(s,maxEvaluations-1);
    Trace_TP3=zeros(s,maxEvaluations-1);
    
    Trace_Gbest1=zeros(1,maxEvaluations-1);
    Trace_Gbest2=zeros(1,maxEvaluations-1);
    Trace_Gbest3=zeros(1,maxEvaluations-1);
    
    CR=zeros(s*maxEvaluations,n);

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
    j=1;
    while (evaluations < maxEvaluations) && (bestFitness > acceptableFitness)

        for i=1:s
            
        % Pick random weights.
        rP = rand(1, 1);
        rG = rand(1, 1);

        % Update the value of the inertia weight w
        if (evaluations<=weveryit)
        w = maxw - (evaluations-1)*inertdec;   
        end        
        
      Omega = max(minw,(minw-maxw)/maxEvaluations*(evaluations-1) + maxw); %inertia weight
        
        % Update velocity for i'th particle:
        v(i,:) =Omega * v(i,:) + ...
                phiP  *rP *  (p(i,:) - x(i,:)) + ...
                phiG  *rG *  (p(bestIndex,:) - x(i,:));

        % Bound velocity:
        v(i,:) = bound(v(i,:), lowerVelocity, upperVelocity);

        % Update position for i'th particle:
        x(i,:) = x(i,:) + v(i,:);

        % Bound position to search-space:
        x(i,:) = bound(x(i,:), lowerBound, upperBound);

        % save positions:
        Trace_TP1(i,evaluations)=x(i,1);
        Trace_TP2(i,evaluations)=x(i,2);
        Trace_TP3(i,evaluations)=x(i,3);  
        
        Trace_TP={Trace_TP1,Trace_TP2,Trace_TP3};
         
        % Compute fitness function:
        newFitness = feval(objective_function, x(i,:));
        
             
        % Compute Confidence regions:
        if newFitness < R   
          CR(j,:)=x(i,:);   
        j=j+1;
        end

        % Update best-known positions:
        if newFitness < fitness(i)
            % Update particle's best-known fitness:
            fitness(i) = newFitness;

            % Update particle's best-known position:
            p(i,:) = x(i,:);
        end
            % Update swarm's best-known position:
            if newFitness < bestFitness
                bestIndex = i;                
                bestFitness = newFitness;
            end
                                 
        end
        
        FitnessValues(evaluations) = bestFitness;

        % save global best positions:
        
        Trace_Gbest1(evaluations)=p(bestIndex,1);
        Trace_Gbest2(evaluations)=p(bestIndex,2);
        Trace_Gbest3(evaluations)=p(bestIndex,3);
        
        Trace_Gbest={Trace_Gbest1,Trace_Gbest2,Trace_Gbest3};
        
        % Increment counter:
        evaluations = evaluations + 1;
        

    end
    % Return best found solution, fitness already set:
    BestX = p(bestIndex,:);
end

% ------------------------------------------------------
