 x_initial =x(:,2:3)';%初始阶段
inputs=[x_initial;pinputs(:,1)];%初始输入pinputs为控制硅含量时记录下的结果（包含硅浓度、喷煤量、风量）
prid_out=zeros(1,100);%输出结果保存在此
prid_out(1,1:2)=x_initial;%选取硫的两个浓度作为初始硫浓度，以便预测下一时刻的硫浓度
prid_out(1,3)=ApplyGMDH(gmdh,inputs);
for i=2:10%对硫浓度进行十步预测
    inputs=[prid_out(1,i:i+1)';pinputs(:,i)];
    prid_out(1,i+2)=ApplyGMDH(gmdh,inputs);
end