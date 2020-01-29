
pic = zeros(2,10);

for c = 1:50
    
    pic(1,c) = c;
    pic(2,c) = equildist(c,1050,46);
   
end

plot(pic(1,:),pic(2,:),'bo');