

% Sample Mean estimate
% Least Squares estimate
% Gauss-Markov estimate
% Bayesian estimate

clear
close all
clc
rng("default")

%% load data
% load Resistor_data_1.mat
load Resistor_data_2.mat

% figure("Name","voltage-current")
% scatter(I, V)
% xlabel("current")
% ylabel("voltage")

%% Sample mean estimate

R = V./I;
R_SM = mean(R);
V_SM = R_SM * I;

%% Linear Squares estimate

R_LS = I\V;
V_LS = R_LS * I;

%% Gauss-Markov estimate
% considering the variance of noise
% It is the weighted least squares estimate with the weight matrix is
% variance of noise

sigma_e = 5; 
Sigma_e2 = sigma_e^2 * eye(length(I));

R_GM = inv(I'*inv(Sigma_e2)*I)* I'*inv(Sigma_e2)*V;
V_GM = R_GM * I;

%% Bayesian estimate
% theta_hat = theta_bar + Sigma_thetad*inv(Sigma_dd)*(d-d_bar)

R_bar = R_SM;
V_bar = R_bar*I;

% the variance of R (the estimated parameters)
Sigma_R2 = [10, 1, 0.1, 0.01];

for i = 1:length(Sigma_R2)
    Sigma_V2 = Sigma_R2(i) * I * I' + Sigma_e2;
    Sigma_Re = Sigma_R2(i) * I';
    R_B(i) = R_bar + Sigma_Re * inv(Sigma_V2) * (V-V_bar);
    V_B(:,i) = R_B(i) * I;
end


%% plot
figure("Name","voltage-current_SM")
hold on
scatter(I, V)
plot(I, V_SM,"LineWidth",1.6)
plot(I, V_LS,"LineWidth",1.6)
plot(I, V_GM,'--', "LineWidth",1.6)
plot(I, V_B(:,1),'*', "LineWidth",1.6)
plot(I, V_B(:,2),'*', "LineWidth",1.6)
plot(I, V_B(:,3),'*', "LineWidth",1.6)
plot(I, V_B(:,4),'*', "LineWidth",1.6)
xlabel("current")
ylabel("voltage")
legend("data","SM","LS","GM","B1","B2","B3","B4")

%% evaluating

close all

% Sample mean estimation
SMerror = mean(sqrt((V_SM-V)'*(V_SM-V)));
% linear squares estimation
LSerror = mean(sqrt((V_LS-V)'*(V_LS-V)));
% Gauss-Markov estimation
GMerror = mean(sqrt((V_GM-V)'*(V_GM-V)));
% Bayesian estimation
B1error = mean(sqrt((V_B(:,1)-V)'*(V_B(:,1)-V)));
B2error = mean(sqrt((V_B(:,2)-V)'*(V_B(:,2)-V)));
B3error = mean(sqrt((V_B(:,3)-V)'*(V_B(:,3)-V)));
B4error = mean(sqrt((V_B(:,4)-V)'*(V_B(:,4)-V)));

figure(), 
hold on, grid on
plot(1,SMerror,"*")
plot(2,LSerror,"*")
plot(3,GMerror,"*")
plot(4,B1error,"*")
plot(5,B2error,"*")
plot(6,B3error,"*")
plot(7,B4error,"*")
legend("SMerror","LSerror","GMerror","B1error","B2error","B3error","B4error")






