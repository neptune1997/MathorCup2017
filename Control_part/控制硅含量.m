x_initial =x(:,1:3)';%初始化第一次预测的输入数据
y_initial =y(:,2);
z_initial =z(:,4);
inputs=[x_initial;y_initial;z_initial];%整合初始输入数据成为一个时间点
control_out=zeros(1,900);%控制输出结果
control_out(1,1:3)=x_initial';%记录初始阶段的三个值
Sistandard=mean(Targets);%设置标准值
pmpath=(max(x)-min(x))/5
flpath=(max(y)-min(y))/5%设置步长
pinputs=[control_out(1,3);y_initial;z_initial];%从第三时刻的值开始
for i=4:900
    flag=0;
    control_out(1,i)=ApplyGMDH(gmdh,inputs);%应用已经建立好的GMDH模型进行预测
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%判断当前值以及预测值的情况并更改输入数据实现对硅含量的控制%%
    if control_out(1,i-1) > Sistandard && control_out(1,i) > Sistandard
        y_inputs=inputs(4,1)+2*pmpath;
        z_inputs=inputs(5,1)+2*flpath;
    elseif control_out(1,i) > Sistandard && control_out(1,i-1) < Sistandard
        y_inputs=inputs(4,1)+pmpath/3;
        z_inputs=inputs(5,1)+flpath/3;
    end
    if control_out(1,i) < Sistandard && control_out(1,i-1) < Sistandard
        y_inputs=inputs(4,1)-pmpath*2;
        z_inputs=inputs(5,1)-flpath*2;
    elseif control_out(1,i) < Sistandard && control_out(1,i-1) > Sistandard
        y_inputs=inputs(4,1)-pmpath/3;
        z_inputs=inputs(5,1)-flpath/3;
    end
    %根据情况调整下一时刻的喷煤量和风量的输入
    x_inputs=control_out(1,i-2:i)';
    inputs=[x_inputs;y_inputs;z_inputs]
    pinputs(:,i-2)=[control_out(1,i-1);y_inputs;z_inputs]%记录下响应的结果,一便硫浓度的预测
end