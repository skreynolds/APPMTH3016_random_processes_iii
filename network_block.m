function B = network_block(C,a)
% Arguments C is a col vector with C1 elements in row 1 and C2 elements in
% row two. a is also a col vector of the same row dimension as C providing
% lambda/mu for each link on the network.
    
    n = size(C,2); 
    B = zeros(1,n);
    
    
    for i = 1:n
        % Calculates the blocking on link one
        B1 = erlangb(C(1,i),a(1,1));
        % Calculates the blocking on the route AC with thinned traffic
        % due to blocking on link 1
        B(i) = (1 - erlangb(C(1,i), a(1,1))) ...
                    * (1 - erlangb(C(2,i), ((1 - B1)*a(2,1))));
    end
    
end