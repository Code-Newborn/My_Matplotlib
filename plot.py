from sklearn.gaussian_process import GaussianProcessRegressor
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

# FIXME 解决中文字体不显示的问题
from matplotlib.font_manager import FontManager
import subprocess
mpl_fonts = set(f.name for f in FontManager().ttflist)  # 查询当前系统所有字体
print('all font list get from matplotlib.font_manager:')
for f in sorted(mpl_fonts):
    print('\t' + f)

plt.rc("font", family='STSong', weight='bold')  # 设置字体

print(plt.style.available)  # 打印绘图样式列表
# plt.style.use('seaborn-whitegrid')

# ======================== 读取excel绘图 ========================
fig1 = plt.figure()  # 创建图形对象
ax1 = plt.axes()  # 创建维度变量
df_excel = pd.read_excel('contour.xlsx', sheet_name='坐标轴1')  # 读取excel中的数据
X_df = df_excel['X1']
Y_df = df_excel['Z1']

x1 = np.array(X_df)
y1 = np.array(Y_df)

plt.fill(x1, y1, c='#00C9A7')  # 多边形填充图
plt.scatter(x1, y1, s=1, c='#E81022', alpha=0.1)  # 绘制散点图 s设置点的大小 c设置点的颜色 alpha设置点的透明度

# plt.draw()  # 绘制但不保持显示
# plt.pause(2)  # 间隔的秒数：2s
# plt.close()

# ======================== 读取excel绘图 ========================
fig12 = plt.figure()  # 创建图形对象
ax12= plt.axes()  # 创建维度变量
df12_excel = pd.read_excel('data1.xlsx', sheet_name='Sheet1')  # 读取excel中的数据
X12_df = df12_excel.iloc[:,0]   # 读取第 1 列
Y12_df = df12_excel.iloc[:,1]   # 读取第 2 列
x12 = np.array(X12_df)
y12 = np.array(Y12_df)
plt.scatter(x12, y12, s=1, c='#E81022', alpha=1.0)  # 绘制散点图 s设置点的大小 c设置点的颜色 alpha设置点的透明度
plt.axis('equal') 

# TAG 折线图
# ======================== 图2 ========================
fig2 = plt.figure()  # 创建图形对象
ax2 = plt.axes()  # 创建维度变量
x2 = np.linspace(0, 10, 1000)   # 等间隔数据
# 如果没有指定颜色，Matplotlib 会在一组默认颜色值中循环使用来绘制每一条线条。
plt.plot(x2, np.sin(x2 - 0), color='blue', label='color=blue')        # 通过颜色名称指定
plt.plot(x2, np.sin(x2 - 1), color='g', label='color=g')           # 通过颜色简写名称指定(rgbcmyk)
plt.plot(x2, np.sin(x2 - 2), color='0.75', label='color=0.75')        # 介于0-1之间的灰阶值
plt.plot(x2, np.sin(x2 - 3), color='#FFDD44', label='color=#FFDD44')     # 16进制的RRGGBB值
plt.plot(x2, np.sin(x2 - 4), color=(1.0, 0.2, 0.3), label='color=(1.0, 0.2, 0.3)')  # RGB元组的颜色值，每个值介于0-1
plt.plot(x2, np.sin(x2 - 5), color='chartreuse', label='color=chartreuse')  # 能支持所有HTML颜色名称值

plt.plot(x2, x2 + 0, linestyle='solid', label='linestyle=solid')  # 通过linestyle关键字参数可以指定线条的风格
plt.plot(x2, x2 + 1, linestyle='dashed', label='linestyle=dashed')
plt.plot(x2, x2 + 2, linestyle='dashdot', label='linestyle=dashdot')
plt.plot(x2, x2 + 3, linestyle='dotted', label='linestyle=dotted')

# 调整坐标轴范围
plt.axis([-1, 11, -1.5, 1.5])  # 若希望将坐标轴反向，将参数顺序颠倒即可
# plt.axis('tight') # 将坐标轴压缩到刚好足够绘制折线图像的大小
# plt.axis('equal') # 设置x轴与y轴使用相同的长度

plt.title("折线图")  # 标题
plt.xlabel("x")  # 横轴标签
plt.ylabel("sin(x)")  # 纵轴标签
plt.legend()

# ======================== 图6 ========================
fig6 = plt.figure()  # 创建图形对象
ax6 = plt.axes()  # 创建维度变量
x6 = np.linspace(0, 10, 30)
y6 = np.sin(x6)
plt.plot(x6, y6, '-p',
         color='gray',
         markersize=15,
         linewidth=4,
         markerfacecolor='blue',
         markeredgecolor='gray',
         markeredgewidth=2)  # 指定线条和点的属性
plt.ylim(-1.2, 1.2)


# TAG 散点图
# ======================== 图3 ========================
fig3 = plt.figure()  # 创建图形对象
ax3 = plt.axes()  # 创建维度变量
x3 = np.linspace(0, 10, 30)
y3 = np.sin(x3)
plt.plot(x3, y3, 'o', color='black')  # 散点图

# ======================== 图4 ========================
fig4 = plt.figure()  # 创建图形对象
ax4 = plt.axes()  # 创建维度变量
rng = np.random.RandomState(0)
for marker in ['o', '.', ',', 'x', '+', 'v', '^', '<', '>', 's', 'd']:
    plt.plot(rng.rand(5), rng.rand(5), marker, label="marker='{0}'".format(marker))
plt.legend(numpoints=3)  # 图例中标记点显示的个数
plt.xlim(0, 1.8)

# ======================== 图7 ========================
fig7 = plt.figure()  # 创建图形对象
ax7 = plt.axes()  # 创建维度变量
rng = np.random.RandomState(0)
x7 = rng.randn(100)
y7 = rng.randn(100)
colors = rng.rand(100)
sizes = 1000 * rng.rand(100)
plt.scatter(x7, y7, c=colors, s=sizes, alpha=0.3, cmap='viridis')  # cmap颜色对比条，有多种样式，自行查找
plt.colorbar()  # 显示颜色对比条

# TAG 多图例显示
# ======================== 图5 ========================
fig5 = plt.figure()  # 创建图形对象
ax5 = plt.axes()  # 创建维度变量
x5 = np.random.uniform(-1, 1, 4)
y5 = np.random.uniform(-1, 1, 4)
p5_1, = plt.plot([1, 2, 3])
p5_2, = plt.plot([3, 2, 1])
l5_1 = plt.legend([p5_2, p5_1], ["line 2", "line 1"], loc='upper left')
p5_3 = plt.scatter(x5[0:2], y5[0:2], marker='D', color='r')
p5_4 = plt.scatter(x5[2:], y5[2:], marker='D', color='g')
l5_2 = plt.legend([p5_3, p5_4], ['label', 'label1'], loc='upper right', scatterpoints=1)
l5_3 = plt.legend([p5_3, p5_4], ['label', 'label1'], loc='lower right', scatterpoints=2)
ax5.add_artist(l5_1)  # 添加图例1
ax5.add_artist(l5_2)  # 添加图例2

# TAG 误差可视化
# ======================== 图8 ========================
fig8 = plt.figure()  # 创建图形对象
ax8 = plt.axes()  # 创建维度变量
x8 = np.linspace(0, 10, 50)
dy8 = 0.8
y8 = np.sin(x8) + dy8 * np.random.randn(50)
plt.errorbar(x8, y8, yerr=dy8, fmt='.k')

# ======================== 图9 ========================
# 定义模型和一些符合模型的点
fig9 = plt.figure()  # 创建图形对象
ax9 = plt.axes()  # 创建维度变量


def model(x): return x * np.sin(x)


x9 = np.array([1, 3, 5, 6, 8])
y9 = model(x9)
# 计算高斯过程回归，使其符合 fit 数据点
gp = GaussianProcessRegressor()  # 高斯回归器
gp.fit(x9[:, np.newaxis], y9)

x9_fit = np.linspace(0, 10, 1000)
y9_fit, std = gp.predict(x9_fit[:, np.newaxis], return_std=True)
dy9_fit = 2 * std  # 两倍sigma ~ 95% 确定区域
plt.plot(x9, y9, 'or')
plt.plot(x9_fit, y9_fit, '-', color='gray')

plt.fill_between(x9_fit, y9_fit - dy9_fit, y9_fit + dy9_fit, color='gray', alpha=0.2)
plt.xlim(0, 10)

# ======================== 图10 ========================
fig10 = plt.figure()  # 创建图形对象
ax10 = plt.axes()  # 创建维度变量
x10 = np.linspace(0, 10, 11)
y10 = [3.9, 4.4, 10.8, 10.3, 11.2, 13.1, 14.1,  9.9, 13.9, 15.1, 12.5]

# 拟合线性曲线，估计其y值及其误差
a10, b10 = np.polyfit(x10, y10, deg=1)
y10_est = a10 * x10 + b10
y10_err = x10.std() * np.sqrt(1/len(x10) + (x10 - x10.mean())**2 / np.sum((x10 - x10.mean())**2))

plt.plot(x10, y10_est, '-')
plt.fill_between(x10, y10_est - y10_err, y10_est + y10_err, alpha=0.2)
plt.plot(x10, y10, 'o', color='brown')


# TAG 密度和轮廓图
# ======================== 图11 ========================
fig11 = plt.figure()  # 创建图形对象
ax11 = plt.axes()  # 创建维度变量


def f(x11, y11):
    return np.sin(x11) ** 10 + np.cos(10 + y11 * x11) * np.cos(x11)


x11 = np.linspace(0, 5, 50)
y11 = np.linspace(0, 5, 40)

X11, Y11 = np.meshgrid(x11, y11)
Z11 = f(X11, Y11)
plt.contour(X11, Y11, Z11, colors='black')
plt.show()
