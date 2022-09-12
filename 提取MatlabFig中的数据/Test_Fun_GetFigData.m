%% Fun_GetFigData例子

%% 
open('正弦曲线.fig')
ha = get(gcf,'Children');  % 获取当前的图形的子对象：Axes坐标轴对象
hl = get(gca,'Children');   % 获取坐标轴的子对象：Line对象
xdata = get(hl,'XData');
ydata = get(hl,'YData');

%%  Eg 1 单坐标轴单曲线二维图，返回 XYZdata = [Xdata  Ydata] :
t = linspace(0,10,500);
y = sin(t);
hf = figure;
plot(t,y)
XYZdata = Fun_GetFigData( hf );

%%  Eg 2 单坐标轴双曲线，横坐标相同时，返回 XYZdata = [Xdata  Ydata1   Ydata2] :
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plot(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 3 单坐标轴双曲线，横坐标维数相同，但数值不同时，返回 XYZdata = [Xdata1  Ydata1  Xdata2 Ydata2] :
t1 = linspace(0,10,500);
y1 = sin(t1);
t2 = linspace(-10,0,500);
y2 = cos(t2);
hf = figure;
plot(t1,y1,t2,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 4 单坐标轴双曲线，横坐标维数不同且数值不同时，返回 XYZdata{ii,jj} = [坐标轴ii、曲线jj的数据] :
%                                                     输出格式坐标轴和曲线的格式信息字符串Str                                   
t1 = linspace(0,10,500);
y1 = sin(t1);
t2 = linspace(-10,0,200);
y2 = cos(t2);
hf = figure;
plot(t1,y1,t2,y2)
XYZdata = Fun_GetFigData( hf );


%% Eg 5 双坐标轴双曲线  XYZdata{1} = 坐标轴1
%%                    XYZdata{2} = 坐标轴2  ……
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
subplot(211)
plot(t,y1)
subplot(212)
plot(t,y1,t,y1+y2)
XYZdata = Fun_GetFigData( hf );

%% Eg 6 四坐标轴双曲线 : XYZdata{1} = 坐标轴1
%%                     XYZdata{2} = 坐标轴2  ……
%%                     XYZdata{3} = 坐标轴3  ……
%%                     XYZdata{4} = 坐标轴4  ……
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
y3 = tan(t);
y4 = cot(t);
hf = figure;
subplot(221)
plot(t,y1)
subplot(222)
plot(t,y2)
subplot(223)
plot(t,y3)
subplot(224)
plot(t,y4)
XYZdata = Fun_GetFigData( hf );

%% Eg 7 双纵坐标轴 :    XYZdata{1} = 坐标轴1
%%                     XYZdata{2} = 坐标轴2  ……
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plotyy(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 8 单坐标轴单曲线三维图，返回 XYZdata = [Xdata  Ydata  Zdata] :
t = linspace(0,10,500);
y = sin(t);
z = cos(t);
hf = figure;
plot3(t,y,z)
XYZdata = Fun_GetFigData( hf );

%%  Eg 9 单坐标轴曲面图，返回 XYZdata = [Xdata  Ydata  Zdata] :
[X,Y] = meshgrid(1:0.5:10,1:20);
Z = sin(X) + cos(Y);
hf = figure;
surf(X,Y,Z);
XYZdata = Fun_GetFigData( hf );

%% Eg 10  将 figure数据保存为xls数据
[X,Y] = meshgrid(1:0.5:10,1:20);
Z = sin(X) + cos(Y);
hf = figure;
surf(X,Y,Z);
XYZdata = Fun_GetFigData( hf );  % 保存为默认名字 图形数据.xls

%% Eg 11 双纵坐标轴 :  将 figure数据保存为xls数据
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plotyy(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf,'双坐标轴数据' ); % 指定文件名

%% Eg 12 读取.fig文件数据，并保存为xls文件
x = linspace(-2*pi,2*pi);
y = linspace(0,4*pi);
[X,Y] = meshgrid(x,y);
Z = sin(X)+cos(Y);
figure
contour(X,Y,Z);
saveas(gcf,'等高线图');   % 保存当前figure为'等高线图.fig'
XYZdata = Fun_GetFigData( '等高线图.fig',1 );

%%  Eg 13 双坐标轴多曲线，横坐标维数不同且数值不同时，返回 XYZdata{ii,jj} = [坐标轴ii、曲线jj的数据] :
%                                                     输出格式坐标轴和曲线的格式信息字符串Str                                   
t1 = linspace(0,10,500);
y1 = sin(t1);
t2 = linspace(-10,0,200);
y2 = cos(t2);
hf = figure;
subplot(211)
plot(t1,y1,t2,y2)
subplot(212)
plot(t1,10*y1)
XYZdata = Fun_GetFigData( hf,1 );
