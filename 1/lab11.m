clear all
clc
n=50; % количество абонентов
p=6; % наш абонент
NumberSlots = 5*10^4; % количество слотов
Q = zeros(1, NumberSlots);% число сообщений в слоте от одного абонента
Q1 = zeros(1, NumberSlots);
lam = 0.05:0.01:1; % вероятность отправки сообщения одним абонентом
% lam=0.2;
T = zeros(1,length(lam));% среднее число сообщений в слоте
P = zeros(1,length(lam));% вероятность типа коллизии
for i = 1:length(lam)
    I = zeros(1, NumberSlots);
    Q = zeros(1, NumberSlots);
    Q1 = zeros(1, NumberSlots);
    InterFlow = randsrc(1, NumberSlots, [1, 0; lam(i)/n, 1-lam(i)/n]);%random('poiss', lam(i), [1, NumberSlots]); %распределение дискретной случайной величины
    InterFlow1 = random('poiss', lam(i), [1, NumberSlots]); 
    Q(1)=InterFlow(1);
    Q1(1)=InterFlow1(1);
    for slot=2:NumberSlots
         Q(slot) = Q(slot - 1)+ InterFlow(slot);
         Q1(slot) = Q1(slot - 1)+ InterFlow1(slot);
        if mod(slot, n) == p
            Q(slot)= Q(slot) -(Q(slot - 1) >0);
        end
        if InterFlow1 (slot)>1 
           P(i) = P(i) + 1;
        end
    end
    T(i) = n*sum(Q)/NumberSlots; 
    P(i) = P(i)/NumberSlots;
end
figure(1);
plot(lam, T,'y');
legend({'Моделирование n=8'});
grid on
%axis([0,1,0,20])
xlabel('lam');
ylabel('Q');
figure(2);
plot(lam, P,'y');