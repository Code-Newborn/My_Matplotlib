import numpy as np
import matplotlib.pyplot as plt
import pandas as pd


df_sheet_index = pd.read_excel('轮廓数据1.xls', sheet_name='坐标轴1')
X_df = df_sheet_index['X1']
Y_df = df_sheet_index['Z1']

x = np.array(X_df)
y = np.array(Y_df)

fig, ax = plt.subplots()

# 绘制多边形图
plt.fill(x, y, c='#00C9A7')

# 绘制散点图 s设置点的大小 c设置点的颜色 alpha设置点的透明度
plt.scatter(x, y, s=1, c='#E81022', alpha=0.1)
plt.show()
