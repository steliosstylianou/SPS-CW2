for i = 1:10
    pic = fftv2(['S',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(i,1) = ftriangle(modpic);
    trainfeat(i,2) = frectangle(modpic);
    
    pic = fftv2(['T',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(10+i,1) = ftriangle(modpic);
    trainfeat(10+i,2) = frectangle(modpic);

    
    pic = fftv2(['V',num2str(i),'.GIF']);
    modpic = log(pic) + 1;
    trainfeat(20+i,1) = ftriangle(modpic);
    trainfeat(20+i,2) = frectangle(modpic);  

end

trainfeat = log(log(trainfeat));

for i=1:5
    pic = fftv2(['S',num2str(10+i),'.gif']);
    modpic = log(pic) + 1;
    testfeat(i,1) = ftriangle(modpic);
    testfeat(i,2) = frectangle(modpic);
    
    pic = fftv2(['T',num2str(10+i),'.gif']);
    modpic = log(pic) + 1;
    testfeat(5+i,1) = ftriangle(modpic);
    testfeat(5+i,2) = frectangle(modpic);

    pic = fftv2(['V',num2str(10+i),'.gif']);
    modpic = log(pic) + 1;
    testfeat(10+i,1) = ftriangle(modpic);
    testfeat(10+i,2) = frectangle(modpic);    
end
    
testfeat = log(log(testfeat));


pic = fftv2('A1.GIF');
modpic = log(pic) + 1;
addfeat(1,1) = ftriangle(modpic);
addfeat(1,2) = frectangle(modpic);

pic = fftv2('B1.GIF');
modpic = log(pic) + 1;
addfeat(2,1) = ftriangle(modpic);
addfeat(2,2) = frectangle(modpic);
