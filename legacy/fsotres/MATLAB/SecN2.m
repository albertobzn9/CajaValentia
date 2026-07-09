function [a]=SecN2(TV,N)
%creador de secuencias aleatorias de tamaño TV y que 
%no se repitan mas de N del mismo lado
a=rand(TV,1);
a=a>0.5;
i=0;
while(i<TV-N)
  i=i+1;
    iIG=find(a(i:i+N,1)==a(i,1));
    if(size(iIG,1)==(N+1))
        a(i+N,1)=not(a(i,1));
        i=i+N-1;
        if(i>=TV-N)
            break
        end
    end  
end  



    
    
    