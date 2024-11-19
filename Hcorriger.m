function Hnew=Hcorriger(h,n,m)
H1 =h(1,1);
H2 =h(1,2);
H3 =h(2,1);
H4 =h(2,2);

Hnew = [H1/n , H2/m; H3/n , H4/m;];

end


