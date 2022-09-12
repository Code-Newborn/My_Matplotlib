function [XYZdata, Str] = Fun_GetFigData(hf, filename)
% XYZdata = Fun_GetFigData( hf ) 获取figure图的
% Str表头字符串
% hf  Figure图形句柄 或 Figure文件名（必须带扩展名.fig）
% XYZdata 坐标数组
% filename 保存为xls文件的名称，不输入或输入0时不保存xls文件
%                              输入非零数值时，保存成xls文件，文件名与figure文件名相同
%                              输入filename时按照输入的字符串保存成xls文件
%                              注意filename不带扩展名.xls
% Str 为与XYZdata一一对应的字符串cell数组，用于说明每列数据的表头，在保存为xls文件时保存为表头
% 文件调用规则，请打开下面例子
% open Test_Fun_GetFigData
% By ZFS@wust 20200912
% 获取更多Matlab/Simulink原创资料和程序，清关注微信公众号：Matlab Fans

%%

% 输入参数filename的判断
if nargin == 1
    filename = 0;
elseif ischar(hf) % 当输入的hf为文件名时
    filename = [hf(1:end-3), 'xls'];
elseif isnumeric(filename)
    if filename ~= 0
        filename = '图形数据.xls';
    end
end

if ischar(hf) % 判断输入hf是否为文件名
    hf = open(hf);
end

% 读取数据
ha = findall(gcf, 'Type', 'axes'); % 获取坐标轴
for ii = 1:length(ha(:)) % 坐标轴循环
    hl = get(ha(ii), 'Children');
    for jj = 1:length(hl) % 曲线循环
        hla = hl(jj);
        x = get(hla, 'XData');
        y = get(hla, 'YData');
        z = get(hla, 'ZData');
        if jj == 1
            if isempty(z) % Z 坐标为空时
                XYZdata{ii} = [x(:), y(:)];
                Str{ii} = ['X1'; 'Y1'];
            else % Z 坐标不为空时
                XYZdata{ii} = [x(:), y(:), z(:)];
                Str{ii} = ['X1'; 'Y1'; 'Z1'];
            end
        else
            if isempty(z) % Z 坐标为空时
                if isequal(XYZdata{ii}(:, 1), x(:))
                    XYZdata{ii} = [XYZdata{ii}, y(:)];
                    Str{ii} = [Str{ii}; ['Y', num2str(jj)]];
                else
                    try XYZdata{ii} = [XYZdata{ii}, x(:), y(:)];
                        Str{ii} = [Str{ii}; ['X', num2str(jj)]; ['Y', num2str(jj)]];
                    catch
                        warning('一个坐标轴中多条曲线数据点维数不同，每条曲线生成单独生成一组数据')
                        [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename);
                        return
                    end
                end
            else % Z 坐标不为空时
                if isequal(XYZdata{ii}(:, 1), x(:))
                    XYZdata{ii} = [XYZdata{ii}, y(:), z(:)];
                    Str{ii} = [Str{ii}; ['Y', num2str(jj)]; ['Z', num2str(jj)]];
                else
                    try XYZdata{ii} = [XYZdata{ii}, x(:), y(:), z(:)];
                        Str{ii} = [Str{ii}; ['X', num2str(jj)]; ['Y', num2str(jj)]; ['Z', num2str(jj)]];
                    catch
                        warning('一个坐标轴中多条曲线数据点维数不同，每条曲线生成单独生成一组数据')
                        [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename);
                        return
                    end
                end
            end
        end
    end
end

% 数据整理
if length(XYZdata) == 1 % 只有一个坐标轴时
    XYZdata = cell2mat(XYZdata);
end

[m, ~] = size(XYZdata);
if m == 1 % XYZdata为行向量时
    XYZdata = XYZdata(:); % 转换为列向量
    Str = Str(:); % 转换为列向量
end

% 存储为xls文件
if filename ~= 0
    Fun_SaveXLS(XYZdata, filename, Str);
end

end


function [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename)
% 每个坐标轴保存成cell数组的行数，每条曲线保存成cell数组的列数
% XYZdata数据类型为cell，维度为 坐标轴数量×坐标轴中的最大曲线数量

% 读取数据
ha = findall(gcf, 'Type', 'axes'); % 获取坐标轴
for ii = 1:length(ha(:)) % 坐标轴循环
    hl = get(ha(ii), 'Children');
    for jj = 1:length(hl) % 曲线循环
        hla = hl(jj);
        x = get(hla, 'XData');
        y = get(hla, 'YData');
        z = get(hla, 'ZData');
        if isempty(z) % Z 坐标为空时
            XYZdata{ii, jj} = [x(:), y(:)];
            Str{ii, jj} = [['X', num2str(jj)]; ['Y', num2str(jj)]];
        else % Z 坐标不为空时
            XYZdata{ii, jj} = [x(:), y(:), z(:)];
            Str{ii, jj} = [['X', num2str(jj)]; ['Y', num2str(jj)]; ['Z', num2str(jj)]];
        end
    end
end

if filename ~= 0
    Fun_SaveXLS(XYZdata, filename, Str);
end

end

function Fun_SaveXLS(XYZdata, filename, Str)
% 将读取的数据保存为xls数据文件，每一个元素保存为一个Sheet
% Str为表头

if iscell(XYZdata)
    [m, n] = size(XYZdata);
    for ii = 1:m
        for jj = 1:n
            if n == 1
                sheet = ['坐标轴', num2str(ii)];
            else
                sheet = ['坐标轴', num2str(ii), ' 曲线', num2str(jj)];
            end
            warning off
            str = Str{ii, jj};
            for kk = 1:length(Str{ii, jj})
                xlswrite(filename, {str(kk, :)}, sheet, [char('A' +kk-1), '1']); % 写入字符串到单元格时必须使用cell字符串数组格式
            end
            if ~isempty(XYZdata{ii, jj}) % 数据不为空时
                xlswrite(filename, XYZdata{ii, jj}, sheet, 'A2');
            end
            warning on
        end
    end
else
    sheet = '坐标轴1';
    warning off
    for kk = 1:length(Str{1})
        str = Str{1};
        xlswrite(filename, {str(kk, :)}, sheet, [char('A' +kk-1), '1']);
    end
    xlswrite(filename, XYZdata, sheet, 'A2');
    warning on
end

end
