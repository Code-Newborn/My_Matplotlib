%% Fun_GetFigData����

%% 
open('��������.fig')
ha = get(gcf,'Children');  % ��ȡ��ǰ��ͼ�ε��Ӷ���Axes���������
hl = get(gca,'Children');   % ��ȡ��������Ӷ���Line����
xdata = get(hl,'XData');
ydata = get(hl,'YData');

%%  Eg 1 �������ᵥ���߶�άͼ������ XYZdata = [Xdata  Ydata] :
t = linspace(0,10,500);
y = sin(t);
hf = figure;
plot(t,y)
XYZdata = Fun_GetFigData( hf );

%%  Eg 2 ��������˫���ߣ���������ͬʱ������ XYZdata = [Xdata  Ydata1   Ydata2] :
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plot(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 3 ��������˫���ߣ�������ά����ͬ������ֵ��ͬʱ������ XYZdata = [Xdata1  Ydata1  Xdata2 Ydata2] :
t1 = linspace(0,10,500);
y1 = sin(t1);
t2 = linspace(-10,0,500);
y2 = cos(t2);
hf = figure;
plot(t1,y1,t2,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 4 ��������˫���ߣ�������ά����ͬ����ֵ��ͬʱ������ XYZdata{ii,jj} = [������ii������jj������] :
%                                                     �����ʽ����������ߵĸ�ʽ��Ϣ�ַ���Str                                   
t1 = linspace(0,10,500);
y1 = sin(t1);
t2 = linspace(-10,0,200);
y2 = cos(t2);
hf = figure;
plot(t1,y1,t2,y2)
XYZdata = Fun_GetFigData( hf );


%% Eg 5 ˫������˫����  XYZdata{1} = ������1
%%                    XYZdata{2} = ������2  ����
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
subplot(211)
plot(t,y1)
subplot(212)
plot(t,y1,t,y1+y2)
XYZdata = Fun_GetFigData( hf );

%% Eg 6 ��������˫���� : XYZdata{1} = ������1
%%                     XYZdata{2} = ������2  ����
%%                     XYZdata{3} = ������3  ����
%%                     XYZdata{4} = ������4  ����
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

%% Eg 7 ˫�������� :    XYZdata{1} = ������1
%%                     XYZdata{2} = ������2  ����
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plotyy(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf );

%%  Eg 8 �������ᵥ������άͼ������ XYZdata = [Xdata  Ydata  Zdata] :
t = linspace(0,10,500);
y = sin(t);
z = cos(t);
hf = figure;
plot3(t,y,z)
XYZdata = Fun_GetFigData( hf );

%%  Eg 9 ������������ͼ������ XYZdata = [Xdata  Ydata  Zdata] :
[X,Y] = meshgrid(1:0.5:10,1:20);
Z = sin(X) + cos(Y);
hf = figure;
surf(X,Y,Z);
XYZdata = Fun_GetFigData( hf );

%% Eg 10  �� figure���ݱ���Ϊxls����
[X,Y] = meshgrid(1:0.5:10,1:20);
Z = sin(X) + cos(Y);
hf = figure;
surf(X,Y,Z);
XYZdata = Fun_GetFigData( hf );  % ����ΪĬ������ ͼ������.xls

%% Eg 11 ˫�������� :  �� figure���ݱ���Ϊxls����
t = linspace(0,10,500);
y1 = sin(t);
y2 = cos(t);
hf = figure;
plotyy(t,y1,t,y2)
XYZdata = Fun_GetFigData( hf,'˫����������' ); % ָ���ļ���

%% Eg 12 ��ȡ.fig�ļ����ݣ�������Ϊxls�ļ�
x = linspace(-2*pi,2*pi);
y = linspace(0,4*pi);
[X,Y] = meshgrid(x,y);
Z = sin(X)+cos(Y);
figure
contour(X,Y,Z);
saveas(gcf,'�ȸ���ͼ');   % ���浱ǰfigureΪ'�ȸ���ͼ.fig'
XYZdata = Fun_GetFigData( '�ȸ���ͼ.fig',1 );

%%  Eg 13 ˫����������ߣ�������ά����ͬ����ֵ��ͬʱ������ XYZdata{ii,jj} = [������ii������jj������] :
%                                                     �����ʽ����������ߵĸ�ʽ��Ϣ�ַ���Str                                   
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
