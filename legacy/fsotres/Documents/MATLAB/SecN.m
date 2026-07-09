function [a,VC]=SecN(N)
clc
TV=50;
a=rand(TV,1);
a=a>0.5
VC=[];
for i=1:TV-N
    i
    i+1
    i+N
    iIG=find(a(i+1:i+N-1,1)==a(i,1))
    if(size(iIG,1)==(N-1))
        VC=[VC;i];
    end    
end  

VC
    
    
    