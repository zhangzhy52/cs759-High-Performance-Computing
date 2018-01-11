clear;close
syms f;
string_length = 1;  %total length

n  = 5; % how many pieces of string?


w = zeros(n,1); % width vector
%w(:) =  string_length./n;
twomu = rand(2,1);
%twomu = [0.0301;0.0391];
w = rand(n,1);
%w = [0.7885,0.6394,0.3691,0.1791,0.7907]';
mu = zeros(n,1);

for i =1:n
        if mod(i,2)==1
            mu(i) = twomu(1);
        else
            mu(i) = twomu(2);
        end
end

%mu = [0.3344;0.7939;0.4380;0.3282;0.9160];
%w =  [0.117;0.1335;0.1697;0.2253;0.0746];

T =1 ; %tension
  
num_of_f = 6;  % how many partials do you want?
fwant = zeros(num_of_f,1);
fwant = [1,2,3.03143,4, 4.92458, 6.06287]';  % type input here, 0 indicate do not constrain that mode. e.g [100,0,330] indicate first partial=100, third partial = 330, second partial doesn't matter
%fwant = [1,2.2]';


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




done  = false;
 
numofLoop = 0;
prevdMu = 0;
 while( ~done)  
     
    for i =1:n
        if mod(i,2)==1
            mu(i) = twomu(1);
        else
            mu(i) = twomu(2);
        end
    end
    
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
   
 

    gw = zeros(length(index), n);
    gmu = zeros(length(index), n);
    gtwoMu = zeros(length(index),2);
    %getE returns n*1;
    for i = 1:length(index)
        [gmu(i,:), gOmega] = fmuOmegaVector(k(i,:),w,mu,T);
        gmu(i,:) = gmu(i,:)./ gOmega;
        gtwoMu(i,1) = sum(gmu(i,1:2:n));
        gtwoMu(i,2) = sum(gmu(i,2:2:n));
        gw(i,:) = fwVector(k(i,:),w)./gOmega;
    end

%    if numofLoop < 50
%         stepSize =  0.2;
%    elseif numofLoop < 200
%         stepSize = 0.15;
%    else
%        stepSize = 20/numofLoop;
%    end
%   stepSize1 = 0.003 ;
 %  stepSize2 = 0.0002;
 
 %stepSize1 = 0.0000105;
 stepSize1 = 0.00005;
 stepSize2 = 0.009;
 gamma = 0.2;

 currentdMu  =   stepSize1 *  gtwoMu' * (tmpf(index) - fwant) + gamma *  prevdMu;
 twomu = proj( twomu + currentdMu );
 prevdMu = currentdMu;
   
   %twomu = proj(twomu + stepSize1 *  gtwoMu' * (tmpf(index) - fwant)) ;
  % w = proj(w + stepSize2 * gw' * (tmpf(index) - fwant));
 
   %  norm(E)
%    g_w = H'  * (tmpf(index) - fwant) ;

  
  diff = norm ( fwant(index) - tmpf(index))
done  =  diff< 1e-4  

  end 


