x_initial =x(:,1:3)';%��ʼ����һ��Ԥ�����������
y_initial =y(:,2);
z_initial =z(:,4);
inputs=[x_initial;y_initial;z_initial];%���ϳ�ʼ�������ݳ�Ϊһ��ʱ���
control_out=zeros(1,900);%����������
control_out(1,1:3)=x_initial';%��¼��ʼ�׶ε�����ֵ
Sistandard=mean(Targets);%���ñ�׼ֵ
pmpath=(max(x)-min(x))/5
flpath=(max(y)-min(y))/5%���ò���
pinputs=[control_out(1,3);y_initial;z_initial];%�ӵ���ʱ�̵�ֵ��ʼ
for i=4:900
    flag=0;
    control_out(1,i)=ApplyGMDH(gmdh,inputs);%Ӧ���Ѿ������õ�GMDHģ�ͽ���Ԥ��
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%�жϵ�ǰֵ�Լ�Ԥ��ֵ�������������������ʵ�ֶԹ躬���Ŀ���%%
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
    %�������������һʱ�̵���ú���ͷ���������
    x_inputs=control_out(1,i-2:i)';
    inputs=[x_inputs;y_inputs;z_inputs]
    pinputs(:,i-2)=[control_out(1,i-1);y_inputs;z_inputs]%��¼����Ӧ�Ľ��,һ����Ũ�ȵ�Ԥ��
end