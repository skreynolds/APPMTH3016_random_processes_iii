function B = erlangb(N,a)
    
%     if N == 0
%         B = 1;        
%     else
%         B = (a * erlangb(N - 1, a)(1)) / (N + a * erlangb(N - 1, a)(1));
%     end
    
    B = 1;
    
    for i = 1:N
        B = (a * B) / ((i+1) + a * B);
    end
end