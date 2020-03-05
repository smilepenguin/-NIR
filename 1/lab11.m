clear all
clc
n=100; % ���������� ���������
p=6; % ��� �������
NumberSlots = 5*10^4; % ���������� ������
Q = zeros(1, NumberSlots);% ����� ��������� � ����� �� ������ ��������
%lam = 0.001:0.01:0.99; % ����������� �������� ��������� ����� ���������
lam=0.001:0.001:0.015;
T = zeros(1,length(lam));% ������� ����� ��������� � �����
Kolliz = zeros(1,length(lam)); % 2 part
for i = 1:length(lam)
    Q = zeros(1, NumberSlots);
    Koll = 0;
    Tell = 0;
    SlotFlow = randsrc(1, n, [1, 0; lam(i), 1-lam(i)]);% ��� ���������� � ����� ����� 
    if sum(SlotFlow) > 1 % ���������� ����������� � ������ �����
        Koll = Koll +1; %������������� ��������
    end;
    if sum(SlotFlow) == 1
        Tell = Tell +1; % ��������� ���������� ��� ������
    end;
    InterFlow = randsrc(1, NumberSlots, [1, 0; lam(i), 1-lam(i)]); %������������� ��������� �������� 
    Q(1)=InterFlow(1); % ����� ��������� � �����
    for slot=2:NumberSlots
         Q(slot) = Q(slot - 1)+ InterFlow(slot);
        if mod(slot, n) == p
            Q(slot)= Q(slot) -(Q(slot - 1) >0);
        end
        
        SlotFlow = randsrc(1, n, [1, 0; lam(i), 1-lam(i)]);
         if sum(SlotFlow) > 1 
            Koll = Koll +1;
        end;
         if sum(SlotFlow) == 1
            Tell = Tell +1;
        end;
    end
    T(i) = n*sum(Q)/NumberSlots; 
    Kolliz(i)= Koll/(Tell + Koll);
end
figure(1);
plot(lam, T,'b');
legend({'������������� n=100'});
grid on
%axis([0,0.015,0,20000])
xlabel('����������� ��������');
ylabel('������� ����� ��������� � �����');

figure(2);
plot(lam, Kolliz,'b');
legend({'������������� n=100'});
grid on
xlabel('����������� ��������');
ylabel('����������� ��������');