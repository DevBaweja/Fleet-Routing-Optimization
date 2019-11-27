function [f,intcon,A,b,Aeq,Beq] = lpp()
%% Basic Variables

% Number of Aircraft (in this case ie 2)
% Number of Airports (in this case ie 3)

% Seats in Aircraft 1
s1 = 250;
% Seats in Aircraft 2
s2 = 100;
% Availability of both aircraft (per day in hours)
h = 20;

%% Creating Constraints / Subjective Function

% Xijk = Number of kth aircraft running from airport i to j
% Fij = Total Number of aircraft running from airport i to j
% Aij = Aji = Distance in hours flight time from airport i to j
% Sk = Seat available in aircraft k
 

% Seats Demand
% Sum (Xijk)(Sk) >= (Seat Demand from airport i to j in kth aircraft)
seatDemand = [1350 850 1700 1100 950 1000];

% Flight Frequency
% (Fij)
% Sum (Xijk) >= (Flight Frequency from airport i to j)
flightFrequency = [7 6 10 11 8 7];

% Time Taken
% (Aij)
timeTaken = [2.25 2.25 5.25 5.25 6 6];

% Aircraft Availability
% Sum (Xijk)(h) >= (Aij)(Fij)(Availability of aircraft)
aircraftAvailability = flightFrequency.*timeTaken;

b = -[seatDemand aircraftAvailability flightFrequency];

% Seats Demand
A1 = [ 
s1 s2 0 0 0 0 0 0 0 0 0 0;
0 0 s1 s2 0 0 0 0 0 0 0 0;
0 0 0 0 s1 s2 0 0 0 0 0 0;
0 0 0 0 0 0 s1 s2 0 0 0 0;
0 0 0 0 0 0 0 0 s1 s2 0 0;
0 0 0 0 0 0 0 0 0 0 s1 s2;
];

% Flight Frequency
A2 = [
h h 0 0 0 0 0 0 0 0 0 0;
0 0 h h 0 0 0 0 0 0 0 0;
0 0 0 0 h h 0 0 0 0 0 0;
0 0 0 0 0 0 h h 0 0 0 0;
0 0 0 0 0 0 0 0 h h 0 0;
0 0 0 0 0 0 0 0 0 0 h h;
];

% Aircraft Availability
A3 = [
1 1 0 0 0 0 0 0 0 0 0 0;
0 0 1 1 0 0 0 0 0 0 0 0;
0 0 0 0 1 1 0 0 0 0 0 0;
0 0 0 0 0 0 1 1 0 0 0 0;
0 0 0 0 0 0 0 0 1 1 0 0;
0 0 0 0 0 0 0 0 0 0 1 1
];

A = -[A1;A2;A3];

%% Equality Constraint
% Since we have equality constraint
% For Scheduling
Aeq = [
    1  0  -1  0  1  0  -1  0  0  0  0  0;
    -1  0  1  0  0  0  0  0  1  0  -1  0;
    0  0  0  0  -1  0  1  0  -1  0  1  0;
    0  1  0  -1  0  1  0  -1  0  0  0  0;
    0  -1  0  1  0  0  0  0  0  1  0  -1;
    0  0  0  0  0  -1  0  1  0  -1  0  1;
];
Beq = zeros(1,6);

%% Creating Objective Function

% Ck = Operating cost of kth aircraft per flight hour
% Cost Required
% Sum (Xijk)(Ck)(Aij)
cost = [5300 2845 5300 2845 5300 2845 5300 2845 5300 2845 5300 2845];
timeTaken = [2.25 2.25 2.25 2.25 5.25 5.25 5.25 5.25 6 6 6 6];
f = cost.*timeTaken;

% Integer Constraint  
intcon = 1:12;

