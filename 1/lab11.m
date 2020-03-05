clear all
clc
n=100; % количество абонентов
p=6; % наш абонент
NumberSlots = 5*10^4; % количество слотов
Q = zeros(1, NumberSlots);% число сообщений в слоте от одного абонента
%lam = 0.001:0.01:0.99; % веро€тность отправки сообщени€ одним абонентом
lam=0.001:0.001:0.015;
T = zeros(1,length(lam));% среднее число сообщений в слоте
Kolliz = zeros(1,length(lam)); % 2 part
for i = 1:length(lam)
    Q = zeros(1, NumberSlots);
    Koll = 0;
    Tell = 0;
    SlotFlow = randsrc(1, n, [1, 0; lam(i), 1-lam(i)]);% ¬се генерируют в одном слоте 
    if sum(SlotFlow) > 1 % количество отправивших в первом слоте
        Koll = Koll +1; %возникновение коллизии
    end;
    if sum(SlotFlow) == 1
        Tell = Tell +1; % сообщение отправлено без ошибок
    end;
    InterFlow = randsrc(1, NumberSlots, [1, 0; lam(i), 1-lam(i)]); %распределение случайной величины 
    Q(1)=InterFlow(1); % число сообщений в слоте
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
legend({'ћоделирование n=100'});
grid on
%axis([0,0.015,0,20000])
xlabel('¬еро€тность отправки');
ylabel('—реднее число сообщений в слоте');

figure(2);
plot(lam, Kolliz,'b');
legend({'ћоделирование n=100'});
grid on
xlabel('¬еро€тность отправки');
ylabel('¬еро€тность коллизии');