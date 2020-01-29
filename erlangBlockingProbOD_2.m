% Random Process Assignment

% Shane Reynolds 02/10/2012
% Script calculates probabilities for links for multiple
% server values (that is monotonically increasing numbers of servers)

% Load the A matrix which details the links used on each of the routes
A = load('A.csv');

% Set the max number of circuits to calc the Bprob for
numcircuits = 8000;

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
% Put the erlang matrix in the form which Eliyas had it in the
% spreadsheet
erlangMat = erlangMat';
erlangMat = erlangMat(:);
erlangMat = erlangMat(erlangMat ~= 0);

% String vector which will be used to plot all the figures in the analysis
names = {'Link 1' 'Link 2' 'Link 3' 'Link 4' 'Link 5' 'Link 6' 'Link 7' ...
            'Link 8' 'Link 9', 'Link 10'};

% Calculate the maximum offered load on each of the links
linkLoad = A' * erlangMat;
n = length(linkLoad);

% Preallocate memory to matrix where the results will be stored
resTable = zeros(n + 1, numcircuits);
resTable(1,:) = 1:numcircuits;
circuitsTable = zeros(n,2);

% Print heading for printout
fprintf(1, 'No. of Circuits\t Blocking Prob\n')

% Loop through each of the links and for the specified load on the link
% in link load calculate the probability that all servers are busy (the
% blocking probability for 1 to numcircuits (specified)
for i = 1:n            
    % Iterate through the number of servers and calculate the
    % blocking probability
    for c = 1:numcircuits                
        blocking_prob = erlangb(c,linkLoad(i));                               
        resTable(i+1,c) = blocking_prob;
    end
            
    % Calculate the number of circuits that optimally satisfy
    % the offered load on the link
    logical = resTable(i + 1,:) > 0.01;
    circuits = sum(logical,2) + 1;
    circuitsTable(i,1) = circuits;
    circuitsTable(i,2) = resTable(i + 1,circuits);
    
    % Print results
    fprintf(1, '%8.2d\t%16.5f\n', circuits, resTable(i + 1,circuits));
            
end
    
% Printing for Link 6 (Broken Hill - Sydney)
figure
circ6 = circuitsTable(6);
hold on
plot(resTable(1,circ6-10:circ6), ...
        resTable(7,circ6-10:circ6),'ob');
plot(resTable(1,circ6), ...
        resTable(7,circ6),'xr');
plotTitle = names{6};
title(plotTitle);
xlabel('Number of Circuits');
ylabel('Blocking Probability');

% Printing for Link 4 (Sydney - Melbourne)
figure
circ4 = circuitsTable(4);
hold on
plot(resTable(1,circ4-10:circ4), ...
        resTable(5,circ4-10:circ4),'ob');
plot(resTable(1,circ4), ...
        resTable(5,circ4),'xr');
plotTitle = names{4};
title(plotTitle);
xlabel('Number of Circuits');
ylabel('Blocking Probability');