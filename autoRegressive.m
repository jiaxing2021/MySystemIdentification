

clear
close all
clc

%% load data
load AR_data.mat

figure("Name","y")
plot(y)

%% linear polinomial model
Phi = [];
Y = [];
for i = 2:length(y)-1
    Phi = [Phi; -y(i), -y(i-1), 1];
    Y = [Y; y(i+1)];
end

theta = Phi\Y;

y_hat = Phi * theta;

%% plot

figure("Name","Y & Y_hat")
hold on
plot(y)
plot(y_hat)



