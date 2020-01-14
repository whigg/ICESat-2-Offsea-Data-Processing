function [select_id] = planB(data_other,segment,start_id, end_id)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
addpath('../code')
id = start_id:end_id;
select_id = zeros(1,length(id));
for i = id
    if i-5<=0
        st = 1; en = 11;
    elseif i+5>end_id
        st = end_id-10; en = end_id;
    else
        st = i-5;en = i+5;
    end
    [his_seg,h_limit]= build_his2(data_other,segment.segment_start_time(st),segment.segment_end_time(en) ,0.1,1);
    [limit] = find_boundary(his_seg,h_limit);
    if ~isnan(limit)
        id_temp = [];
        for i = 1:size(limit,1)
            flag = (data_other.delta_time>=segment.segment_start_time(i))&(data_other.delta_time<=segment.segment_end_time(i))...
                (data_other.height>=limit(i,1))&(data_other.height<=limit(i,2));
            tt = data_other.id(flag);
            id_temp = [id_temp ;  tt];
        end
        select_id(1:length(id_temp),i) = id_temp;
    end
    
end
select_id = select_id(:);
select_id(select_id==0) = [];
end
