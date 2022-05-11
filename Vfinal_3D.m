clear; clc;

Vmesh(1,1:5) = [0, 0:0.05:0.15];
Vmesh(1:5,1) = [0, 0, 0.1e-3, 0.3e-3, 0.5e-3];

k=0;
%--Df+0Hf------------------------------------------------------------------
Vf_0 = 'model 0 (Df= 0, Hf= 0)'; k=k+1;
Vf_1 = 'model D1 (Df= 0.5e-1, Hf= 0)'; k=k+1;
Vf_2 = 'model D2 (Df= 0.10e+0, Hf= 0)'; k=k+1;
Vf_3 = 'model D3 (Df= 0.15e+0, Hf= 0)'; k=k+1;
%--Df+0.1Hf----------------------------------------------------------------
Vf_4 = 'model H1 (Df= 0, Hf= -0.1e-3)';  k=k+1;
Vf_5 = 'model DH1 [D1+H1] (Df= 0.5e-1, Hf= -0.1e-3)';  k=k+1; %
Vf_6 = 'model DH4 [D2+H1] (Df= 0.10e+0, Hf= -0.1e-3)';  k=k+1; %
Vf_7 = 'model DH7 [D3+H1] (Df= 0.15e+0, Hf= -0.1e-3)';  k=k+1; %
%--Df+0.3Hf----------------------------------------------------------------
Vf_8 = 'model H3 (Df= 0, Hf= -0.3e-3)';  k=k+1;
Vf_9 = 'model DH2 [D1+H3] (Df= 0.5e-1, Hf= -0.3e-3)';  k=k+1;
Vf_10 = 'model DH5 [D2+H3] (Df= 0.10e+0, Hf= -0.3e-3)';  k=k+1;
Vf_11 = 'model DH8 [D3+H3] (Df= 0.15e+0, Hf= -0.3e-3)';  k=k+1;
%--Df+0.5Hf----------------------------------------------------------------
Vf_12 = 'model H5 (Df= 0, Hf= -0.5e-3)';  k=k+1;
Vf_13 = 'model DH3 [D1+H5] (Df= 0.5e-1, Hf= -0.5e-3)';  k=k+1;
Vf_14 = 'model DH6 [D2+H5] (Df= 0.10e+0, Hf= -0.5e-3)';  k=k+1;
Vf_15 = 'model DH9 [D3+H5] (Df= 0.15e+0, Hf= -0.5e-3)';  k=k+1;

Vf = string(zeros(1,k));

for n=0:k-1
Vf(n+1) = eval('Vf_'+string(n));
end

V = zeros(1,k);

for i = 1:k
file_directory = fullfile( 'c:', 'Users', 'raffi', 'Desktop', ...
        'Paraview Patients', 'P01', Vf(i), 'Volume Data' , 'V_53.csv');

file_directory=string(file_directory);

Array = readmatrix(file_directory);

V(1,i) = Array(:, 5);

end

Vmesh(2:5,2) = V(1,1:4);
Vmesh(2:5,3) = V(1,5:8);
Vmesh(2:5,4) = V(1,9:12);
Vmesh(2:5,5) = V(1,13:16);

Vmesh=Vmesh(:,2:5);
Vmesh=Vmesh(2:5,:);

Y = [0:0.05:0.15];
X = [0, 0.1e-3, 0.3e-3, 0.5e-3];

surf(X, Y, Vmesh, 'EdgeColor', 'none')
grid on
ax = gca;
ax.GridAlpha = 0.75;
set(gca,'FontSize',30)
title('Final Volume of fibrosis for different Df and Hf values', 'FontSize',40)
ylab = ylabel('Diffusion coefficient [m2/d]', 'FontSize',30, 'fontweight','bold');
ylab.Position(1) = 0.00017;
ylab.Position(2) = 0.175;
xlab = xlabel('Haptotactic coefficient [m2/d]', 'FontSize',30, 'fontweight','bold');
xlab.Position(1) = 0.000351;
xlab.Position(2) = 0.015;
zlabel('Volume [mm3]', 'FontSize',30, 'fontweight','bold')
xlim([0 0.0005])
zlim([185000 215000])
pbaspect([2.3 2.5 1.5])

colormap turbo
a = colorbar;
a.Position = [.8 .13 0.015 .73];
shading interp

