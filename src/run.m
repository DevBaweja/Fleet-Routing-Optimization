% Getting Objective Function,Subjective Funtion / Constraint

[f,intcon,A,b,Aeq,Beq] = lpp();
% Creating Option
options = optimoptions(@intlinprog,'display','off');

lb = [];
ub = [];


[x,fval,exitflag,output] = intlinprog(f,intcon,A,b,Aeq,Beq,lb,ub,options);

x = int8(x);
Aircraft = ['Aircraft-1';'Aircraft-2'];
a1 = x(1:2:end)';
a2 = x(2:2:end)';

Route__1_2 = [a1(1),a2(1)]';
Route__2_1 = [a1(2),a2(2)]';
Route__1_3 = [a1(3),a2(3)]';
Route__3_1 = [a1(4),a2(4)]';
Route__2_3 = [a1(5),a2(5)]';
Route__3_2 = [a1(6),a2(6)]';
TotalFlight = [sum(a1);sum(a2)];

% Time per route
timeperRoute = [2.25 2.25 5.25 5.25 6 6];
% Cost per hour
costperHour = [5300,2845];
totalc1 = sum(double(a1).*timeperRoute)*costperHour(1);
totalc2 = sum(double(a2).*timeperRoute)*costperHour(2);
format long 
TotalCost = [totalc1;totalc2];

T = table(Aircraft,Route__1_2,Route__2_1,Route__1_3,Route__3_1,Route__2_3,Route__3_2,TotalFlight,TotalCost);
disp(T);
fprintf("Optimal Cost is: $%f \n",fval);

plot(a1,'b-o');
hold on;
plot(a2,'g-*');

xlabel('Route_{(i to j airport)}','FontSize',12,'Color', 'g');
ylabel('Frequency_{(in numbers)}','FontSize',12,'Color', 'g');
legend('Aircraft-1', 'Aircraft-2');
title('Frequency Vs Routes','FontSize',14,'FontWeight','bold','Color', 'b');
axis([1 10 0 10]); 
