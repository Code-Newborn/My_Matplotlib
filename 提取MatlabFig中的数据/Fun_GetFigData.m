function [XYZdata, Str] = Fun_GetFigData(hf, filename)
% XYZdata = Fun_GetFigData( hf ) ��ȡfigureͼ��
% Str��ͷ�ַ���
% hf  Figureͼ�ξ�� �� Figure�ļ������������չ��.fig��
% XYZdata ��������
% filename ����Ϊxls�ļ������ƣ������������0ʱ������xls�ļ�
%                              ���������ֵʱ�������xls�ļ����ļ�����figure�ļ�����ͬ
%                              ����filenameʱ����������ַ��������xls�ļ�
%                              ע��filename������չ��.xls
% Str Ϊ��XYZdataһһ��Ӧ���ַ���cell���飬����˵��ÿ�����ݵı�ͷ���ڱ���Ϊxls�ļ�ʱ����Ϊ��ͷ
% �ļ����ù��������������
% open Test_Fun_GetFigData
% By ZFS@wust 20200912
% ��ȡ����Matlab/Simulinkԭ�����Ϻͳ������ע΢�Ź��ںţ�Matlab Fans

%%

% �������filename���ж�
if nargin == 1
    filename = 0;
elseif ischar(hf) % �������hfΪ�ļ���ʱ
    filename = [hf(1:end-3), 'xls'];
elseif isnumeric(filename)
    if filename ~= 0
        filename = 'ͼ������.xls';
    end
end

if ischar(hf) % �ж�����hf�Ƿ�Ϊ�ļ���
    hf = open(hf);
end

% ��ȡ����
ha = findall(gcf, 'Type', 'axes'); % ��ȡ������
for ii = 1:length(ha(:)) % ������ѭ��
    hl = get(ha(ii), 'Children');
    for jj = 1:length(hl) % ����ѭ��
        hla = hl(jj);
        x = get(hla, 'XData');
        y = get(hla, 'YData');
        z = get(hla, 'ZData');
        if jj == 1
            if isempty(z) % Z ����Ϊ��ʱ
                XYZdata{ii} = [x(:), y(:)];
                Str{ii} = ['X1'; 'Y1'];
            else % Z ���겻Ϊ��ʱ
                XYZdata{ii} = [x(:), y(:), z(:)];
                Str{ii} = ['X1'; 'Y1'; 'Z1'];
            end
        else
            if isempty(z) % Z ����Ϊ��ʱ
                if isequal(XYZdata{ii}(:, 1), x(:))
                    XYZdata{ii} = [XYZdata{ii}, y(:)];
                    Str{ii} = [Str{ii}; ['Y', num2str(jj)]];
                else
                    try XYZdata{ii} = [XYZdata{ii}, x(:), y(:)];
                        Str{ii} = [Str{ii}; ['X', num2str(jj)]; ['Y', num2str(jj)]];
                    catch
                        warning('һ���������ж����������ݵ�ά����ͬ��ÿ���������ɵ�������һ������')
                        [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename);
                        return
                    end
                end
            else % Z ���겻Ϊ��ʱ
                if isequal(XYZdata{ii}(:, 1), x(:))
                    XYZdata{ii} = [XYZdata{ii}, y(:), z(:)];
                    Str{ii} = [Str{ii}; ['Y', num2str(jj)]; ['Z', num2str(jj)]];
                else
                    try XYZdata{ii} = [XYZdata{ii}, x(:), y(:), z(:)];
                        Str{ii} = [Str{ii}; ['X', num2str(jj)]; ['Y', num2str(jj)]; ['Z', num2str(jj)]];
                    catch
                        warning('һ���������ж����������ݵ�ά����ͬ��ÿ���������ɵ�������һ������')
                        [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename);
                        return
                    end
                end
            end
        end
    end
end

% ��������
if length(XYZdata) == 1 % ֻ��һ��������ʱ
    XYZdata = cell2mat(XYZdata);
end

[m, ~] = size(XYZdata);
if m == 1 % XYZdataΪ������ʱ
    XYZdata = XYZdata(:); % ת��Ϊ������
    Str = Str(:); % ת��Ϊ������
end

% �洢Ϊxls�ļ�
if filename ~= 0
    Fun_SaveXLS(XYZdata, filename, Str);
end

end


function [XYZdata, Str] = Fun_GetFigData_Cell(hf, filename)
% ÿ�������ᱣ���cell�����������ÿ�����߱����cell���������
% XYZdata��������Ϊcell��ά��Ϊ �������������������е������������

% ��ȡ����
ha = findall(gcf, 'Type', 'axes'); % ��ȡ������
for ii = 1:length(ha(:)) % ������ѭ��
    hl = get(ha(ii), 'Children');
    for jj = 1:length(hl) % ����ѭ��
        hla = hl(jj);
        x = get(hla, 'XData');
        y = get(hla, 'YData');
        z = get(hla, 'ZData');
        if isempty(z) % Z ����Ϊ��ʱ
            XYZdata{ii, jj} = [x(:), y(:)];
            Str{ii, jj} = [['X', num2str(jj)]; ['Y', num2str(jj)]];
        else % Z ���겻Ϊ��ʱ
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
% ����ȡ�����ݱ���Ϊxls�����ļ���ÿһ��Ԫ�ر���Ϊһ��Sheet
% StrΪ��ͷ

if iscell(XYZdata)
    [m, n] = size(XYZdata);
    for ii = 1:m
        for jj = 1:n
            if n == 1
                sheet = ['������', num2str(ii)];
            else
                sheet = ['������', num2str(ii), ' ����', num2str(jj)];
            end
            warning off
            str = Str{ii, jj};
            for kk = 1:length(Str{ii, jj})
                xlswrite(filename, {str(kk, :)}, sheet, [char('A' +kk-1), '1']); % д���ַ�������Ԫ��ʱ����ʹ��cell�ַ��������ʽ
            end
            if ~isempty(XYZdata{ii, jj}) % ���ݲ�Ϊ��ʱ
                xlswrite(filename, XYZdata{ii, jj}, sheet, 'A2');
            end
            warning on
        end
    end
else
    sheet = '������1';
    warning off
    for kk = 1:length(Str{1})
        str = Str{1};
        xlswrite(filename, {str(kk, :)}, sheet, [char('A' +kk-1), '1']);
    end
    xlswrite(filename, XYZdata, sheet, 'A2');
    warning on
end

end
