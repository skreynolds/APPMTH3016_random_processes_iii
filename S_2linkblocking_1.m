clear; clc;
clf;
%% Initialisation step
% Random point generation
n = 1400000;
% Offered load
a = [5;7];
% Number of random circuits to initialise
circuits = 100;

%% First constraint
% generate cloud of sample points for 
C1 = floor(rand(1,n)*circuits);
% preallocate memory to blockL1
blockL1 = zeros(1,n);
% calculate allowable blocking probabilities link AB
for i = 1:n
    blockL1(i) = erlangb(C1,a(1));
end
% create index of results that satisfy the first constraint that the
% blocking probability on link 1 (AB) is less than 1%
index1 = find(blockL1 <= 0.01);
C1 = C1(index1);

%% Second constraint, given first constraint
% generate cloud of sample points for use on link 2 (BC) 
C2 = floor(rand(1,length(C1))*circuits);
% combine C1 and C2 to pass to the network_block function
C = [C1;C2];
% calculate blocking probabilities for route AC for circuit cloud
B = network_block(C,a);
% add C values together to search minimal value
combineC = sum(C,1);

% create index of results that satisfy the constraint
index = find(B >= 0.99);
% tabulate results of [C1 C2 (C1+C2) B]
resTab = [C(:,index)' combineC(index)' B(index)'];
% find the min value of (C1+C2) - put index in I
[Y I] = min(resTab(:,3));

% display the results
disp(1-resTab(I,4));
disp(resTab(I,1:2));

plot(resTab(:,3),1-resTab(:,4),'xb');
hold on;
plot(resTab(I,3),1-resTab(I,4),'or');
xlabel('C1 + C2');
ylabel('Blocking Probability');