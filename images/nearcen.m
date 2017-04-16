function label = nearcen(point,s,t,v,siz)
for i=1:siz
distS =  pdist2(s,point(i,:));
distT =  pdist2(t,point(i,:))
distV =  pdist2(v,point(i,:));
mindist = min([distS, distT, distV]);

if (mindist == distS) 
    label(i,1) = 1;
elseif (mindist == distT)
    label(i,1) = 2;
elseif (mindist == distV)
    label(i,1) = 3;
end
end
end
