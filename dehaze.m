clear;
clc;

%constants
lambda_1 = 0.02;
lambda_2 = 0.002;
lambda_3 = 0.04;

% Input image
I = imread('examples/sam_4.bmp');
I = imresize( I, 0.2);
% Display input image
figure
imagesc(I)

% haar wavelet transform (1 level)
[I_c, H_c, V_c, D_c]=haart2(I, 1);

% extract image shape 
[m, n, c] = size(I_c);

% % Normalize 
mm = max(max(max(I_c)));
I_c = I_c./mm;

% Display low subband (compressed)
figure
imagesc(I_c)    

% Airlight calculation
wsz = 15; % window size
a_c = Airlight(I, wsz);

%Boradcast A_c to fit the dimensions 
Ac1 =  a_c(1) + zeros( m, n, 1);
Ac2 =  a_c(2) + zeros( m, n, 1);
Ac3 =  a_c(3) + zeros( m, n, 1);
A_c = cat(3,Ac1,Ac2,Ac3);


%create Yc
Y_c = I_c - A_c;


cvx_begin
    variables t(m, n) Q_c(m, n, c)
    
    %construct the objective function 
    obj_func = 0;
    for i = 1:c
        obj_func = obj_func + norm(Y_c(:,:,i) - Q_c(:,:,i) + a_c(i)*t);
    end
    obj_func = obj_func + lambda_1* norm(t, 2);
    obj_func = obj_func + lambda_2* norm(t,'fro');
    for i = 1:c
        obj_func = obj_func + norm(Q_c(:,:,1) ,2);
    end           
    
    %minimize objective function 
    minimize (obj_func)

    %constraints 
    subject to 
        0 < t <= 1
        0 <= Q_c
        
cvx_end