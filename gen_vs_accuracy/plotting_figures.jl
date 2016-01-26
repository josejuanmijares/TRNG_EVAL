### figures for journal
using PyPlot

#######################################################################################
plt[:figure](1);

### random variable
N= 1024;
x = [0:N-1;];
y = rand(length(x));

plt[:subplot](211);
scatter(x,y,color="black",s = ones(length(x)));
plt[:xlim](0,N);
plt[:ylim](0,1);
plt[:xticks](linspace(0,N,5));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{samples}  (i)\$" * "\n" *"\$ (a) \$");
plt[:ylabel]("\$ \\mathrm{random} \\/\ \\mathrm{numbers}  (x_{i})  \$");
plt[:tick_params](axis="both",which="major",labelsize=8)

### random variable relation to future values
xi = y;
xii = [y[2:end]; rand()];
plt[:subplot](212);
scatter(xi,xii,color="black",s=ones(length(x)));
plt[:xlim](0,1);
plt[:ylim](0,1);
plt[:xticks](linspace(0,1,5));
plt[:grid]("on");
plt[:xlabel]("\$ x_{i} \$" * "\n" *"\$ (b) \$");
plt[:ylabel]("\$ x_{i+1} \$");
plt[:tick_params](axis="both",which="major",labelsize=8)
plt[:tight_layout]()


#######################################################################################
### properties of a random numbers
plt[:figure](2);

ax = [(-N+1):(N-1);];
ay = zeros(length(ax));
ay[N]=1;

## ideal histogram
plt[:subplot](231);
plt[:hist](linspace(0,1, length(y)),32, facecolor="black", weights = ones(length(y))./length(y))
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{random} \\/\ \\mathrm{numbers}  (x_{i})  \$"* "\n" *"\$ (a) \$");
plt[:ylabel]("\$ \\mathrm{Probability} \\/\ (P\\left( x_{i} \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)

## real histogram

plt[:subplot](234);
plt[:hist](y,32, facecolor="black", weights = ones(length(y))./length(y))
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{random} \\/\ \\mathrm{numbers}  (x_{i})  \$* "\n" *"\$ (d) \$"");
plt[:ylabel]("\$ \\mathrm{Probability} \\/\ (P\\left( x_{i} \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)


## ideal autocorrelation

plt[:subplot](232);

plt[:plot](ax,ay,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),7));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{lags}  (n)\$" * "\n" *"\$ (b) \$");
plt[:ylabel]("\$ \\mathrm{Autocorrelation} \\/\ (R_{xx}\\left( n \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)


## real autocorrelation
plt[:subplot](235);

ay1 = xcorr(y-mean(y),y-mean(y));
ay1 = ay1./ay1[N];

plt[:plot](ax,ay1,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),7));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{lags}  (n)\$" * "\n" *"\$ (e) \$");
plt[:ylabel]("\$ \\mathrm{Autocorrelation} \\/\ (R_{xx}\\left( n \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)

## ideal power spectral density
plt[:subplot](233);

Sxx = abs(fftshift(fft(ay)));
Sf = linspace(-0.5,0.5, length(Sxx));

plt[:plot](Sf,Sxx,"k.-");
plt[:xlim]((-0.5),(0.5));
plt[:ylim](-0.2,10);
plt[:xticks](linspace(-0.5,0.5,7));
plt[:grid]("on");

plt[:xlabel]("\$ \\mathrm{Normalized Freq.}  (f)\$" * "\n" *"\$ (c) \$");
plt[:ylabel]("\$ \\mathrm{Power} \\/\ \\mathrm{Spectral} \\/\ \\mathrm{Density} \\/\ (S_{xx}\\left( f \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)
 
## real power spectral density
plt[:subplot](236);

Sxx1 = abs(fftshift(fft(ay1)));
Sf = linspace(-0.5,0.5, length(Sxx));

plt[:plot](Sf,Sxx1,"k.-");
plt[:xlim]((-0.5),(0.5));
plt[:ylim](-0.2,10);
plt[:xticks](linspace(-0.5,0.5,7));
plt[:grid]("on");

plt[:xlabel]("\$ \\mathrm{Normalized Freq.}  (f)\$" * "\n" *"\$ (f) \$");
plt[:ylabel]("\$ \\mathrm{Power} \\/\ \\mathrm{Spectral} \\/\ \\mathrm{Density} \\/\ (S_{xx}\\left( f \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=8)

plt[:tight_layout]()

#######################################################################################

data2 = readcsv("2.csv");
data3 = readcsv("3.csv");
data4 = readcsv("4.csv");
data5 = readcsv("5.csv");
data6 = readcsv("6.csv");
data7 = readcsv("7.csv");
data8 = readcsv("8.csv");
data9 = readcsv("9.csv");

data_p = [data2[:,1]'; data3[:,1]'; data4[:,1]'; data5[:,1]'; data6[:,1]'; data7[:,1]'; data8[:,1]'; data9[:,1]']';

data_c = [data2[:,2]'; data3[:,2]'; data4[:,2]'; data5[:,2]'; data6[:,2]'; data7[:,2]'; data8[:,2]'; data9[:,2]']';

data_x = [data2[:,3]'; data3[:,3]'; data4[:,3]'; data5[:,3]'; data6[:,3]'; data7[:,3]'; data8[:,3]'; data9[:,3]']';

yerr_p = std(data_p,2)[:,1];
yerr_c = std(data_c,2)[:,1];
yerr_x = std(data_x,2)[:,1];

ymean_p = mean(data_p,2)[:,1];
ymean_c = mean(data_c,2)[:,1];
ymean_x = mean(data_x,2)[:,1];

plt[:errorbar]([1:100001;] ,ymean_p,yerr=yerr_p, errorevery=1000,color="black")
plt[:errorbar]([1:100001;] ,ymean_c,yerr=yerr_c, errorevery=1000,color="red")
plt[:errorbar]([1:100001;] ,ymean_x,yerr=yerr_x, errorevery=1000,color="blue")

plt[:ylim](45.95542,45.956)
plt[:xscale]("log")









