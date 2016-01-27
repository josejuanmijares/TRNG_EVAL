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
plt[:tick_params](axis="both",which="major",labelsize=10)

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
plt[:tick_params](axis="both",which="major",labelsize=10)
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
plt[:tick_params](axis="both",which="major",labelsize=10)

## real histogram

plt[:subplot](234);
plt[:hist](y,32, facecolor="black", weights = ones(length(y))./length(y))
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{random} \\/\ \\mathrm{numbers}  (x_{i})  \$"* "\n" *"\$ (d) \$");
plt[:ylabel]("\$ \\mathrm{Probability} \\/\ (P\\left( x_{i} \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=10)


## ideal autocorrelation

plt[:subplot](232);

plt[:plot](ax,ay,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),7));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{lags}  (n)\$" * "\n" *"\$ (b) \$");
plt[:ylabel]("\$ \\mathrm{Autocorrelation} \\/\ (R_{xx}\\left( n \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=10)


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
plt[:tick_params](axis="both",which="major",labelsize=10)

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
plt[:tick_params](axis="both",which="major",labelsize=10)
 
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
plt[:tick_params](axis="both",which="major",labelsize=10)

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


ymean_p = mean(data_p,2)[:,1];
ymean_c = mean(data_c,2)[:,1];
ymean_x = mean(data_x,2)[:,1];

yup_p = maximum(data_p,2)[:,1];
yup_c = maximum(data_c,2)[:,1];
yup_x = maximum(data_x,2)[:,1]

ydown_p = minimum(data_p,2)[:,1];
ydown_c = minimum(data_c,2)[:,1];
ydown_x = minimum(data_x,2)[:,1]


x=[1:length(yup_p);];

plt[:figure](3)

plt[:plot](x, ymean_p,"-k",label="parent")
plt[:fill_between](x, yup_p, ydown_p,color="black", alpha=0.1)

plt[:plot](x, ymean_c,"-r",label="child")
plt[:fill_between](x, yup_c,ydown_c,color="red", alpha=0.1)

plt[:plot](x, ymean_x,"-b",label="visitor")
plt[:fill_between](x, yup_c,ydown_c,color="blue", alpha=0.1)


plt[:ylim](minimum(ymean_p,1) - 0.5*(maximum(ymean_p,1) - minimum(ymean_p,1) ) ,maximum(ymean_p,1) + 0.5*(maximum(ymean_p,1) - minimum(ymean_p,1) )   )
plt[:xlim](1,length(yup_p));
plt[:xscale]("log")
plt[:grid](b=true,which="both")

plt[:xlabel]("\$ \\mathrm{generations}  (g)\$" * "\n");
plt[:ylabel]("\$ \\mathrm{Fitness function} \\/\ (f \\left( g \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=10)
plt[:legend](loc="best")
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)


plt[:tight_layout]()


#######################################################################################

data2 = readcsv("p4_2.csv");
data3 = readcsv("p4_3.csv");
data4 = readcsv("p4_4.csv");
data5 = readcsv("p4_5.csv");

data_Allp = [data2[:,1]'; data3[:,1]'; data4[:,1]'; data5[:,1]';]';
data_Allc = [data2[:,2:33]'; data3[:,2:33]'; data4[:,2:33]'; data5[:,2:33]']';
data_Allx = [data2[:,34]'; data3[:,34]'; data4[:,34]'; data5[:,34]']';

data_p = data5[:,1]
data_c = data5[:,2:33]
data_x = data5[:,34]

ymean_p = mean(data_p,2)[:,1];
ymean_c = mean(data_c,2)[:,1];
ymean_x = mean(data_x,2)[:,1];

yup_p = maximum(data_p,2)[:,1];
yup_c = maximum(data_c,2)[:,1];
yup_x = maximum(data_x,2)[:,1]

ydown_p = minimum(data_p,2)[:,1];
ydown_c = minimum(data_c,2)[:,1];
ydown_x = minimum(data_x,2)[:,1]


x=[1:length(yup_p);];

plt[:figure](4)
plt[:plot](x, ymean_p,"-k",label="parent")
plt[:fill_between](x, yup_p, ydown_p,color="black", alpha=0.1)

plt[:plot](x, ymean_c,"-r",label="child")
plt[:fill_between](x, yup_c,ydown_c,color="red", alpha=0.1)

plt[:plot](x, ymean_x,"-b",label="visitor")
plt[:fill_between](x, yup_c,ydown_c,color="blue", alpha=0.1)


plt[:ylim](minimum(data_p,1) - 0.75*(maximum(data_p,1) - minimum(data_p,1) ) ,maximum(data_p,1) + 0.75*(maximum(data_p,1) - minimum(data_p,1) )   )
plt[:xlim](1,length(yup_p));
plt[:xscale]("log")
plt[:grid](b=true,which="both")

plt[:xlabel]("\$ \\mathrm{generations}  (g)\$" * "\n");
plt[:ylabel]("\$ \\mathrm{Fitness function} \\/\ (f \\left( g \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=10)
plt[:legend](loc="best")
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()

ymean_p = mean(data_Allp,2)[:,1];
ymean_c = mean(data_Allc,2)[:,1];
ymean_x = mean(data_Allx,2)[:,1];

yup_p = maximum(data_Allp,2)[:,1];
yup_c = maximum(data_Allc,2)[:,1];
yup_x = maximum(data_Allx,2)[:,1]

ydown_p = minimum(data_Allp,2)[:,1];
ydown_c = minimum(data_Allc,2)[:,1];
ydown_x = minimum(data_Allx,2)[:,1]


plt[:figure](5)
plt[:plot](x, ymean_p,"-k",label="parent")
plt[:fill_between](x, yup_p, ydown_p,color="black", alpha=0.1)

plt[:plot](x, ymean_c,"-r",label="child")
plt[:fill_between](x, yup_c,ydown_c,color="red", alpha=0.1)

plt[:plot](x, ymean_x,"-b",label="visitor")
plt[:fill_between](x, yup_c,ydown_c,color="blue", alpha=0.1)


plt[:ylim](minimum(ymean_p,1) - 0.75*(maximum(ymean_p,1) - minimum(ymean_p,1) ) ,maximum(ymean_p,1) + 0.75*(maximum(ymean_p,1) - minimum(ymean_p,1) )   )
plt[:xlim](1,length(yup_p));
plt[:xscale]("log")
plt[:grid](b=true,which="both")

plt[:xlabel]("\$ \\mathrm{generations}  (g)\$" * "\n");
plt[:ylabel]("\$ \\mathrm{Fitness function} \\/\ (f \\left( g \\right) )\$");
plt[:tick_params](axis="both",which="major",labelsize=10)
plt[:legend](loc="best")
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()

