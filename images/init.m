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

for i=1:10
    pic = fftv2(['S',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(i,1) = ftriangle(modpic);
    testfeat(i,2) = frectangle(modpic);
    
    pic = fftv2(['T',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(10+i,1) = ftriangle(modpic);
    testfeat(10+i,2) = frectangle(modpic);

    pic = fftv2(['V',num2str(10+i),'.GIF']);
    modpic = log(pic) + 1;
    testfeat(20+i,1) = ftriangle(modpic);
    testfeat(20+i,2) = frectangle(modpic);    
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

addfeat = log(log(addfeat));

hold on;
scatter(testfeat(1:6,1),testfeat(1:6,2), 'r');
scatter(testfeat(11:15,1),testfeat(11:15,2),'g');
scatter(testfeat(21:25,1),testfeat(21:25,2),'b');

scatter(trainfeat(1:10,1),trainfeat(1:10,2),'r','*');
scatter(trainfeat(11:20,1),trainfeat(11:20,2),'g','*');
scatter(trainfeat(21:30,1),trainfeat(21:30,2),'b','*');


scatter(addfeat(1,1),addfeat(1,2),20,'c','*');
scatter(addfeat(2,1),addfeat(2,2),20,'c');

