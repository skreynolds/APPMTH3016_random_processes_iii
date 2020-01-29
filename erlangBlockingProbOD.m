% Random Process Assignment

% Shane Reynolds 02/10/2012
% Script calculates probabilities for Origin-Destination pairs for multiple
% server values (that is monotonically increasing numbers of servers)

% Preallocate memory to matrix where the results will be stored
resTable = zeros(2,100);

% Set the plot interation for the subplot tiling
plotIteration = 1;
% The Erlang matrix which delivers offered loads
erlangMat = [0 500 4 80 145 900 650 15 1050; ...
                0 0 7 250 160 750 450 80 1250; ...
                    0 0 0 2 24 18 8 5 90; ...
                        0 0 0 0 50 180 65 25 450; ...
                            0 0 0 0 0 330 280 45 450; ...
                                0 0 0 0 0 0 1250 40 2550; ...
                                    0 0 0 0 0 0 0 8 1025; ...
                                        0 0 0 0 0 0 0 0 110; ...
                                            0 0 0 0 0 0 0 0 0];

% Get dimensions of offer load matrix to pass into iteration
[n m] = size(erlangMat);

% String vector which will be used to plot all the figures in the analysis
names = {'Adel' 'Bris' 'BrokenH' 'Cairns' 'Canb' 'Melb' 'Perth' ...
            'PortMac' 'Syd'};

% The call time duration approx 3 min per call -> 20 calls per hour
callperhour = 20;

% Loop through all elements of the Erlang matrix and produce plots for
% the probability that all servers are busy
for i = 1:n
    for j = 1:m
        if ~erlangMat(i,j) == 0
            
            % Iterate through the number of servers and calculate the
            % blocking probability
            for c = 1:100
    
                resTable(1,c) = c;
                resTable(2,c) = equildist(c,erlangMat(i,j),callperhour);
   
            end
            
            subplot(6,6,plotIteration)
            plot(resTable(1,:),resTable(2,:),'b');
            plotTitle = strcat(names(i),' - ',names(j));
            title(plotTitle);
            xlabel('C');
            ylabel('BP');
            plotIteration = plotIteration + 1;
            
        end
    end
end