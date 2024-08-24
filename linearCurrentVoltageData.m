

% current voltage data generater

clear
close all
clc
rng("default")

%%

R = 5;
i = linspace(1,10,20);

v = R * i;randn;
n = randn(1,20);
v = v + n;

figure("Name","current-voltage")
scatter(v,i)

data = [v',i'];
save("linearCurrentVoltageData.mat", "data")