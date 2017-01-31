%Tzilivakis Dimitris, 28/1/2017
%Logic Programming Project - A Text Adventure Game
%Developed on swi prolog using the online code editor and compiler on http://swish.swi-prolog.org/

% actions at car
state(car,[action('open_car_door', gas_station, 
                  'you opened the door of your car door, and walked out. "GOD! this thirst! 
                   i need a drink something.",you grumple.'),
          action('leave_gas_station', road ,
                 'You sit on the driver`s chair,
                  and open the radio, listening to a random music program, nothing seems to be wrong. 
                  Suddenly the music stops. You hear a lot of noise coming through the speaker. and a mysterious voice says:
                  "C-C-CODE IS MALFUNCTIONING, THE BUG BUG B-B-B-BUG IS C-C-COMING". You are terrified, 
                  and you immediately turn the car`s engine on, leaving this place once and for all. ...To be continue...')
          ]).

% actions at gas station.
state(gas_station,[
               action('open_gas_station_door',gas_station_store,
                      'You opened the door and you enter the gas station, in front of you there is the gas station store.
                       Sprakling cool soda is sold, and there is a newspaper stand. There is one problem though, nobody is there,
                       "What happened" you wonder, there were also no traffic on the road, as you drived there. strange'),
               action('open_car_door',car,'You have returned to your car.')]).

%actions at gas station store.
state(gas_station_store, [
                      action('open_gas_station_door',gas_station,
                             'You feel something is not right there, so you immediately 
                              storm out of the gas_station_store.'),
                      action('take_soda',gas_station_store,
                             '"THAT THIRST! OH MY GOD SODA!", you shout, you immediately take a soda and drink it,
                              glu,glu,glu. "This is how a man should live" '),
                      action('take_newspaper',gas_station_store,
                           'You take and check the newspaper.there is some text in it ,but something is completely off, 
                            You notice there are gaps in the flow of text in the articles. Some people names are missing,
                            its like someone wrote an article about someone else and forgot his name. There were also blank
                            pages like there was something supposed to be written on but never published.
                            "what the hell is going on" you wonder, its like i woke up in a computer program, and there is a huge
                            bug, causing everything to glitch')
                         ]).

%to go to gas_station you will start from car.
stateInit(gas_station, car).

%the predicates will fail when you reach the road.
stateEnd(road).

%show all actions of a list with action predicates. write a number for each action based on position
showActions([action(A,B,_)|T],Counter):-
    write('Type '),write(Counter),write(' to '),write(A),write(' | New Location : '),write(B),nl,
    C is Counter+1,
    showActions(T,C).

goto(Place):-
    stateInit(Place,Through),
    next(Through).

%read action input and go to the next state. This will be done recurisely until stateEnd succeed.
next(Place):- 
    \+stateEnd(Place),
    write('you are at: '),write(Place),nl,
    state(Place,Actions),
    write('================ ACTIONS ==================='),nl,
    write('available actions: '),nl,
    \+showActions(Actions,1),read(UserAction),
    nth1(UserAction,Actions,action(_,NextThrough,Message)),
    write('================== STORY ===================='),nl,
    write(Message),nl,
    next(NextThrough).
    

 
	

