:- use_module(library(clpfd)).
:- use_module(library(lists)).
%Predicate that does an if than else
if_then_else(If, Then,_):- If,!, Then.
if_then_else(_, _, Else):- Else.

matrixToListOfLists(Board,List) :-
append(Board,List).

getPosition(Dim,Row,Col,Position) :-
Position is (Row-1)*Dim+Col.

checkConectivity(_,_,0).

checkConectivity(Board,Dim,Position) :-
matrixToListOfLists(Board,List),
valuePosition(Position,List,Dim,ReturnPosition),
write(ReturnPosition),nl,nl,
checkConectivity(Board,Dim,ReturnPosition).


%First left position
valuePosition(Position,List,Size,R):-
Position==1,
PositionRight is Position+1,
PositionDown is Position+Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionDown,List,ElementDown),
Element=1,
((ElementRight#=1) #\/ (ElementDown#=1)),
if_then_else(ElementRight==1,R is PositionRight,R is PositionDown).


%First right position
valuePosition(Position,List,Size,R):-
Position==Size,
PositionLeft is Position-1,
PositionDown is Position+Size,
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
((ElementLeft#=1 #<=> B #/\ (B#=0  #/\ ElementLeft#=1)) #\/ (ElementDown#=1 #<=>B #/\ (B#=0  #/\ ElementDown#=1))),
if_then_else(ElementLeft==1,R is PositionLeft,R is PositionDown).


%Last second position
valuePosition(Position,List,Size,ReturnPosition):-
Dim is Size*Size,
Position==Dim,
nth1(Position,List,Element),
Element=1,
ReturnPosition=0.

%Last first position
valuePosition(Position,List,Size,R):-
Dim is Size*Size,
Value is Dim-Size,
Position==Value,
PositionRight is Position+1,
PositionUp is Position-Size,
nth1(PositionRight,List,ElementRight),
nth1(PositionUp,List,ElementUp),
((ElementRight#\=0  #/\ ElementRight#=1) #\/ (ElementUp#\=0 #/\ ElementUp#=1)),
if_then_else(ElementRight==1,R is PositionRight,R is PositionUp).

%Left extreme
valuePosition(Position,List,Size,R):-
Position\=1,
Dim is Size*Size,
Value is Dim-Size,
Position \= Value,
PositionMod is Position mod Size,
PositionMod==1,
PositionRight is Position+1,
PositionDown is Position+Size,
PositionUp is Position-Size,
nth1(PositionRight,List,ElementRight),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
write('ElementUp'+ElementUp),nl,
write('Position'+Position),nl,
trace,
((ElementUp == 1,
(ElementDown #=1  #\/ ElementRight#=1));
(ElementDown == 1,
(ElementUp #=1  #\/ ElementRight#=1));
(ElementRight==1,
(ElementDown #=1  #\/ ElementUp#=1))),
write('AQUIIII'),
if_then_else(ElementRight==1,R is PositionRight,if_then_else(ElementDown==1,R is PositionDown,R is PositionUp)),
write('R'+R),nl.

%Right extreme
valuePosition(Position,List,Size,R):-
Position\=Size,
Dim is Size*Size,
Position \= Dim,
PositionMod is Position mod Size,
PositionMod==0,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionUp is Position-Size,
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
(ElementUp == 1,
(ElementDown #=1  #\/ ElementLeft#=1));
(ElementDown == 1,
(ElementUp #=1  #\/ ElementLeft#=1));
(ElementLeft==1,
(ElementDown #=1  #\/ ElementUp#=1)),
if_then_else(ElementLeft==1,R is PositionLeft,if_then_else(ElementDown==1,R is PositionDown,R is PositionUp)).


%Central positions
valuePosition(Position,List,Size,R):-
Position>Size,
Dim is Size*Size,
Value is Dim-Size,
Position<Value,
PositionMod is Position mod Size,
PositionMod\=0,
PositionMod\=1,
PositionRight is Position+1,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionUp is Position-Size,
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
(ElementUp == 1,
(ElementDown #=1  #\/ ElementRight#=1 #\/ ElementLeft#=1));
(ElementDown == 1,
(ElementUp #=1  #\/ ElementRight#=1 #\/ ElementLeft#=1));
(ElementRight==1,
(ElementDown #=1  #\/ ElementUp#=1 #\/ ElementLeft#=1));
(ElementLeft==1,
(ElementDown #=1  #\/ ElementUp#=1 #\/ ElementRight#=1)),
if_then_else(ElementUp==1,R is PositionUp,if_then_else(ElementDown==1,R is PositionDown,
  if_then_else(ElementLeft==1,R is PositionLeft,R is PositionRight))).

%Up extreme
valuePosition(Position,List,Size,R):-
Position<Size,
Position\=Size,
Position\=1,
PositionRight is Position+1,
PositionLeft is Position-1,
PositionDown is Position+Size,
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
(ElementRight==1,
(ElementDown #=1 #\/ ElementLeft#=1));
(ElementLeft==1,
(ElementDown #=1 #\/ ElementRight#=1));
(ElementDown==1,
(ElementRight #=1 #\/ ElementLeft#=1)),
if_then_else(ElementRight==1,R is PositionRight,if_then_else(ElementDown==1,R is PositionDown,R is PositionLeft)).


%Down extreme
valuePosition(Position,List,Size,R):-
Dim is Size*Size,
Value is Dim-Size,
Position>Size,
Position>Value,
Position<Dim,
PositionRight is Position+1,
PositionLeft is Position-1,
PositionUp is Position-Size,
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionUp,List,ElementUp),
(ElementRight==1,
(ElementUp #=1 #\/ ElementLeft#=1));
(ElementLeft==1,
(ElementUp #=1 #\/ ElementRight#=1));
(ElementUp==1,
(ElementRight #=1 #\/ ElementLeft#=1)),
if_then_else(ElementRight==1,R is PositionRight,if_then_else(ElementLeft==1,R is PositionLeft,PositionUp)).
