clear;close
syms f;
string_length = 1;  %total length

n  = 4; % how many pieces of string?


w = zeros(n,1); % width vector
w(:) =  string_length./n;


mu = rand(n,1); %initilize density mu

T =1 ; %tension
  
num_of_f = 3;  % how many partials do you want?
fwant = zeros(num_of_f,1);
fwant = [1, 1.5,2.5]
%fwant = [1,2,3.03143,4]';
%fwant = [1,2,3.03143,4, 4.92458, 6.06287]';  % type input here, 0 indicate do not constrain that mode. e.g [100,0,330] indicate first partial=100, third partial = 330, second partial doesn't matter



initialize =  true;

%initialize T so that first partial be the same magnitude of the first desired frequncy.
while initialize 
    k  = 2 *pi * f *sqrt(mu /T);
    zzy = getFreq(k,w);% return (pi_12)
    %get root of Omega;
    tmpf = new_getRoot(zzy,0, 2* fwant(num_of_f) );
    tmpf1 = tmpf(1)
  
    
    
    if tmpf(1) > 10* fwant(1) 
        T = T /10;
    elseif tmpf(1) < 0.1 * fwant(1)
        T = T *10;
    else
        initialize = false;
    end
    
    
end

T


index = find(fwant~= 0);
dif = zeros( length(index), 1);




done  =false;
 
numofLoop = 0;

 while( ~done)  
    numofLoop = numofLoop + 1;
    k = 2 *pi * f *sqrt(mu/T);

    zzy = getFreq(k,w);
    tmpf = new_getRoot(zzy,0,2*fwant(num_of_f))';
    %tmpf is the solution set of Omega, only pick up those modes we want to
    %confine
    tmpf(index)
    
    

    
   k  = zeros(length(index), n);
   for i = 1: length(index)
       k(i,:) = 2* pi*tmpf(index(i)) *sqrt(mu/T); %vector k11 k12  k13, each loop's k corresponding to a same frequncy
   end
   
 

    E = zeros(length(index), n);
    H = zeros(length(index), n);
    %getE returns n*1;
    for i = 1:length(index)
        E(i,:) = getE (k(i,:) , w)'; %transpose
    end
    
    for i = 1:length(index)
        H(i,:) = getAnotherE (k(i,:) , w)'* tmpf(index(i)); %transpose
    end        
    
   % E1 = getE (k1, w);
   % E2 = getE (k2,w);
   if numofLoop < 50
        stepSize =  0.2;
   elseif numofLoop < 200
        stepSize = 0.15;
   else
       stepSize = 20/numofLoop;
   end
   stepSize = 0.003;
   mu = proj(mu - stepSize * E'  * (tmpf(index) - fwant));
     norm(E)
%     g_w = H'  * (tmpf(index) - fwant) ;
%     [a,b] =  min(g_w);
%     g_w_fw = zeros(n,1);
%     g_w_fw(b) = 1;
%     
%     
%    w = w + stepSize * (g_w_fw - w);
  
done  = norm ( fwant(index) - tmpf(index)) < 1e-3  || norm(E) < 1e-3

  end 


