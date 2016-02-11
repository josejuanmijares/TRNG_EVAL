### figures for journal
using PyPlot

function EHEfast_0to1(xin,N)
	ind = sortperm(xin)
	ind2 = zeros(N)
	[ind2[ind[k]] = k for k=1:N]
	binsize = 2
	ratio = convert(Float64, binsize)/convert(Float64, N)
	offset = floor((ind2-1)/binsize)*ratio
	xin = mod(xin,ratio) + offset
	return xin
end

figure(10)
### random variable
N= 1024;
x = [0:N-1;];
y = rand(length(x));


plt[:subplot](231);
scatter(x,y,color="black",s = ones(length(x)));
plt[:xlim](0,N);
plt[:ylim](0,1);
plt[:xticks](linspace(0,N,3));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{Samples}  (i)\$" * "\n" *"\$ (a) \$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Random} \\/\ \\mathrm{numbers}  (x_{i})  \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

plt[:subplot](232);
plt[:hist](y,[0:Float64(1/32.0):1.0;], facecolor="black", weights = ones(length(y))./length(y));
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:xticks](linspace(0,1,3))
plt[:yticks](linspace(0,0.1,3))
plt[:grid]("on");
plt[:xlabel]("\$x\$"* "\n" *"\$ (b) \$",fontsize=14);
plt[:ylabel]("\$f_{x} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()



plt[:subplot](233);
bx = [(-N+1):(N-1);];
by = xcorr(y-mean(y),y-mean(y));
by1 = by./by[N];
plt[:plot](bx,by1,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),3));
plt[:yticks](linspace(-0.2,1.2,3))
plt[:grid]("on");
plt[:xlabel]("\$ k\$" * "\n" *"\$ (c) \$",fontsize=14);
plt[:ylabel]("\$ R_{xx}\\left[ k \\right] \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()


y0 =  EHEfast_0to1(y,N);

plt[:subplot](234);
scatter(x,y0,color="black",s = ones(length(x)));
plt[:xlim](0,N);
plt[:ylim](0,1);
plt[:xticks](linspace(0,N,3));
plt[:grid]("on");
plt[:xlabel]("\$ \\mathrm{Samples}  (i)\$" * "\n" *"\$ (d) \$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Random} \\/\ \\mathrm{numbers}  (x_{i})  \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

plt[:subplot](235);
plt[:hist](y0,[0:Float64(1/32.0):1.0;], facecolor="black", weights = ones(length(y))./length(y));
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:xticks](linspace(0,1,3))
plt[:yticks](linspace(0,0.1,3))
plt[:grid]("on");
plt[:xlabel]("\$x\$"* "\n" *"\$ (e) \$",fontsize=14);
plt[:ylabel]("\$f_{x} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

plt[:subplot](236);
bx = [(-N+1):(N-1);];
by0 = xcorr(y0-mean(y0),y0-mean(y0));
by2 = by0./by0[N];
plt[:plot](bx,by2,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),3));
plt[:yticks](linspace(-0.2,1.2,3))
plt[:grid]("on");
plt[:xlabel]("\$ k\$" * "\n" *"\$ (f) \$",fontsize=14);
plt[:ylabel]("\$ R_{xx}\\left[ k \\right] \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

(plt[:gcf]())[:set_size_inches](8,6)
#(plt[:get_current_fig_manager]())[:full_screen_toggle]()
savefig("fig6.pdf",dpi=300,format="PDF")


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
plt[:xlabel]("\$ \\mathrm{Samples}  (i)\$" * "\n" *"\$ (a) \$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Random} \\/\ \\mathrm{numbers}  (x_{i})  \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)

### random variable relation to future values
xi = y;
xii = [y[2:end]; rand()];
plt[:subplot](212);
scatter(xi,xii,color="black",s=ones(length(x)));
plt[:xlim](0,1);
plt[:ylim](0,1);
plt[:xticks](linspace(0,1,5));
plt[:grid]("on");
plt[:xlabel]("\$ x_{i} \$" * "\n" *"\$ (b) \$",fontsize=14);
plt[:ylabel]("\$ x_{i+1} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
#(plt[:get_current_fig_manager]())[:full_screen_toggle]()
savefig("fig1.pdf",dpi=300,format="PDF")

####################################################################################

n = convert(Array{Float64,1},[1:1:36;]);
x = 2.^n;
f1 = (4.*x.^2 .+x)./(4.*x.^2 .+ 9.*x .+4);
f2 = (12.*x.*log2(x).+9.*x.-2)./(10.*x.*log2(2.*x).+12.*x.-4);
f3 = (6.*x.*log2(x).+9.*x.-2)./(5.*x.*log2(2.*x).+12.*x.-4);

c1 = (4.*x.^2 .+x);
c2 = (12.*x.*log2(x).+9.*x.-2);
c3 = (6.*x.*log2(x).+.9*x.-2);

d1 = (4.*x.^2 .+ 9.*x .+4);
d2 = (10.*x.*log2(2.*x).+12.*x.-4);
d3 = (5.*x.*log2(2.*x).+12.*x.-4);

plt[:figure](3)
plt[:subplot](121);
plt[:semilogx](x,f1,"k.-",basex=2, label="\$R_{xx}\$");
plt[:semilogx](x,f2,"r.-",basex=2, label="FFT-"*"\$R_{xx}\$");
plt[:semilogx](x,f3,"b.-",basex=2, label="\$S_{xx}\$");
plt[:xlim](0,2^36);
plt[:ylim](0.4,1.2);
plt[:grid]("on");
#plt[:grid](b=true,which="both")
plt[:xticks](x[1:7:end])
plt[:yticks](linspace(0.4,1.2,5))
plt[:xlabel]("\$ \\mathrm{Data}\\/\ \\mathrm{size} (N)\$" * "\n"*"\$(a)\$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Computational}\\/\ \\mathrm{intensity} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best", fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()

plt[:subplot](222);
plt[:loglog](x,c1,"k.-",basex=2, label="\$R_{xx}\$");
plt[:loglog](x,c2,"r.-",basex=2, label="FFT-"*"\$R_{xx}\$");
plt[:loglog](x,c3,"b.-",basex=2, label="\$S_{xx}\$");
plt[:xlim](0,2^36);
plt[:ylim](1,10^24);
plt[:xticks](x[1:7:end])
plt[:yticks](10.^[0:4:24;])
plt[:grid]("on");
#plt[:grid](b=true,which="both")
#plt[:xticks](linspace(0,1,5));
#plt[:yticks](linspace(0,1,5));
plt[:xlabel]("\$ \\mathrm{Data}\\/\ \\mathrm{size} (N)\$" * "\n"*"\$(b)\$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Floating}\\/\ \\mathrm{point}\\/\ \\mathrm{operations} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best", fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()

plt[:subplot](224);
plt[:loglog](x,d1,"k.-",basex=2, label="\$R_{xx}\$");
plt[:loglog](x,d2,"r.-",basex=2, label="FFT-"*"\$R_{xx}\$");
plt[:loglog](x,d3,"b.-",basex=2, label="\$S_{xx}\$");
plt[:xlim](0,2^36);
plt[:ylim](1,10^24);
plt[:xticks](x[1:7:end])
plt[:yticks](10.^[0:4:24;])
plt[:grid]("on");
#plt[:grid](b=true,which="both")

plt[:xlabel]("\$ \\mathrm{Data}\\/\ \\mathrm{size} (N)\$" * "\n"*"\$(c)\$",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Memory}\\/\ \\mathrm{access}\\/\ \\mathrm{operations} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best",fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
#(plt[:get_current_fig_manager]())[:full_screen_toggle]()
savefig("fig3.pdf",dpi=300,format="PDF")


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
plt[:xticks](linspace(0,1,3))
plt[:yticks](linspace(0,0.1,3))
plt[:grid]("on");
plt[:xlabel]("\$x\$"* "\n" *"\$ (a) \$",fontsize=14);
plt[:ylabel]("\$ f_{x} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()
## real histogram

plt[:subplot](234);
plt[:hist](y,32, facecolor="black", weights = ones(length(y))./length(y))
plt[:xlim](0,1);
plt[:ylim](0,0.1);
plt[:xticks](linspace(0,1,3))
plt[:yticks](linspace(0,0.1,3))
plt[:grid]("on");
plt[:xlabel]("\$x\$"* "\n" *"\$ (d) \$",fontsize=14);
plt[:ylabel]("\$f_{x} \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

## ideal autocorrelation

plt[:subplot](232);

plt[:plot](ax,ay,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),3));
plt[:yticks](linspace(-0.2,1.2,3))
plt[:grid]("on");
plt[:xlabel]("\$k\$" * "\n" *"\$ (b) \$",fontsize=14);
plt[:ylabel]("\$R_{xx}\\left[ k \\right]\$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

## real autocorrelation
plt[:subplot](235);

ay1 = xcorr(y-mean(y),y-mean(y));
ay1 = ay1./ay1[N];

plt[:plot](ax,ay1,"k.-");
plt[:xlim]((-N+1),(N-1));
plt[:ylim](-0.2,1.2);
plt[:xticks](linspace((-N+1),(N-1),3));
plt[:yticks](linspace(-0.2,1.2,3))
plt[:grid]("on");
plt[:xlabel]("\$ k\$" * "\n" *"\$ (e) \$",fontsize=14);
plt[:ylabel]("\$ R_{xx}\\left[ k \\right] \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:tight_layout]()

## ideal power spectral density
plt[:subplot](233);

Sxx = abs(fftshift(fft(ay)));
Sf = linspace(-0.5,0.5, length(Sxx));

plt[:plot](Sf,Sxx,"k.-");
plt[:xlim]((-0.5),(0.5));
plt[:ylim](-0.2,10);
plt[:xticks](linspace(-0.5,0.5,3));
plt[:yticks](linspace(-0.2,10,3))
plt[:grid]("on");

plt[:xlabel]("\$f\$" * "\n" *"\$ (c) \$",fontsize=14);
plt[:ylabel]("\$ S_{xx}\\left[ f \\right]\$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
 
## real power spectral density
plt[:subplot](236);

Sxx1 = abs(fftshift(fft(ay1)));
Sf = linspace(-0.5,0.5, length(Sxx));

plt[:plot](Sf,Sxx1,"k.-");
plt[:xlim]((-0.5),(0.5));
plt[:ylim](-0.2,10);
plt[:xticks](linspace(-0.5,0.5,3));
plt[:yticks](linspace(-0.2,10,3))
plt[:grid]("on");

plt[:xlabel]("\$ f\$" * "\n" *"\$ (f) \$",fontsize=14);
plt[:ylabel]("\$ S_{xx}\\left[ f \\right] \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)

plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
savefig("fig2.pdf",dpi=300,format="PDF")

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

plt[:figure](4)

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

plt[:xlabel]("\$ \\mathrm{generations,}  g\$" * "\n",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Fitness} \\/\ \\mathrm{function} \\/\ f \\left( g \\right) \$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best", fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)


plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
savefig("fig4.pdf",dpi=300,format="PDF")


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

plt[:figure](5)
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

plt[:xlabel]("\$ \\mathrm{generations}  (g)\$" * "\n",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Fitness function} \\/\ (f \\left( g \\right) )\$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best",fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
savefig("fig5.pdf",dpi=300,format="PDF")


ymean_p = mean(data_Allp,2)[:,1];
ymean_c = mean(data_Allc,2)[:,1];
ymean_x = mean(data_Allx,2)[:,1];

yup_p = maximum(data_Allp,2)[:,1];
yup_c = maximum(data_Allc,2)[:,1];
yup_x = maximum(data_Allx,2)[:,1]

ydown_p = minimum(data_Allp,2)[:,1];
ydown_c = minimum(data_Allc,2)[:,1];
ydown_x = minimum(data_Allx,2)[:,1]


plt[:figure](6)
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

plt[:xlabel]("\$ \\mathrm{generations}  (g)\$" * "\n",fontsize=14);
plt[:ylabel]("\$ \\mathrm{Fitness function} \\/\ (f \\left( g \\right) )\$",fontsize=14);
plt[:tick_params](axis="both",which="major",labelsize=12)
plt[:legend](loc="best",fontsize=14)
plt[:setp](((plt[:gca]())[:get_legend]())[:get_texts](),fontsize=10)
plt[:tight_layout]()
(plt[:gcf]())[:set_size_inches](8,6)
savefig("fig6.pdf",dpi=300,format="PDF")


