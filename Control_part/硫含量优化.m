 x_initial =x(:,2:3)';%��ʼ�׶�
inputs=[x_initial;pinputs(:,1)];%��ʼ����pinputsΪ���ƹ躬��ʱ��¼�µĽ����������Ũ�ȡ���ú����������
prid_out=zeros(1,100);%�����������ڴ�
prid_out(1,1:2)=x_initial;%ѡȡ�������Ũ����Ϊ��ʼ��Ũ�ȣ��Ա�Ԥ����һʱ�̵���Ũ��
prid_out(1,3)=ApplyGMDH(gmdh,inputs);
for i=2:10%����Ũ�Ƚ���ʮ��Ԥ��
    inputs=[prid_out(1,i:i+1)';pinputs(:,i)];
    prid_out(1,i+2)=ApplyGMDH(gmdh,inputs);
end