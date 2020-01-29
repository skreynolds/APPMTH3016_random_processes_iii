clf;
% Random point generation
n = 700000;
% Offered load
a = [5;2];

% generate cloud of sample points for 
C = floor(rand(2,n)*100);
% calculate blocking probabilities for point cloud
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
disp(resTab(I,4));
disp(resTab(I,1:2));

plot(resTab(:,3),1-resTab(:,4),'xb');
hold on;
plot(resTab(I,3),1-resTab(I,4),'or');
xlabel('C1 + C2');
ylabel('Blocking Probability');