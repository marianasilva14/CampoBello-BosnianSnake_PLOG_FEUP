:- use_module(library(clpfd)).
:- use_module(library(lists)).

matrixToListOfLists(Board,List) :-
append(Board,List).

getPosition(Dim,Row,Col,Position) :-
Position is (Row-1)*Dim+Col.

checkConectivity(_,Aux,_,_,Aux).

checkConectivity(Board,Row,Dim,Dim,Aux):-
  Row2 is Row+1,
  checkConectivity(Board,Row2,1,Dim,Aux).

checkConectivity(Board,Row,Col,Dim,Aux) :-
matrixToListOfLists(Board,List),
getPosition(Dim,Row,Col,Position),
valuePosition(Position,List,Dim),
write(Position),nl,nl,
Col2 is Col+1,
checkConectivity(Board,Row,Col2,Dim,Aux).


%First left position
valuePosition(Position,List,Size):-
Position==1,
PositionRight is Position+1,
PositionDown is Position+Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionDown,List,ElementDown),
Element#=1  #/\
((ElementRight#=1) #\/ (ElementDown#=1)).

%First right position
valuePosition(Position,List,Size):-
Position==Size,
PositionLeft is Position-1,
PositionDown is Position+Size,
nth1(Position,List,Element),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
Element#=1  #/\ ((ElementLeft#=1) #\/ (ElementDown#=1)).

%Last second position
valuePosition(Position,List,Size):-
Dim is Size*Size,
Position==Dim,
nth1(Position,List,Element),
Element#=1.

%Last first position
valuePosition(Position,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Position==Value,
PositionRight is Position+1,
PositionUp is Position-Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionUp,List,ElementUp),
Element#=1 #/\ ((ElementRight#=1) #\/ (ElementUp#=1)).

%Left extreme
valuePosition(Position,List,Size):-
Position\=1,
Dim is Size*Size,
Value is Dim-Size,
Position \= Value,
PositionMod is Position mod Size,
PositionMod==1,
PositionRight is Position+1,
PositionDown is Position+Size,
PositionUp is Position-Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
Element#=1  #/\((ElementRight#=1) #\/ (ElementDown#=1) #\/ (ElementUp#=1)).

%Right extreme
valuePosition(Position,List,Size):-
Position\=Size,
Dim is Size*Size,
Position \= Dim,
PositionMod is Position mod Size,
PositionMod==0,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionUp is Position-Size,
nth1(Position,List,Element),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
Element#=1  #/\ ((ElementLeft#=1) #\/ (ElementDown#=1) #\/ (ElementUp#=1)).

%Central positions
valuePosition(Position,List,Size):-
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
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
nth1(PositionUp,List,ElementUp),
Element#=1  #/\((ElementRight#=1) #\/ (ElementUp#=1) #\/ (ElementDown#=1) #\/ (ElementLeft#=1)).

%Up extreme
valuePosition(Position,List,Size):-
Position<Size,
Position\=Size,
Position\=1,
PositionRight is Position+1,
PositionLeft is Position-1,
PositionDown is Position+Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionDown,List,ElementDown),
Element#=1  #/\ ((ElementRight#=1) #\/ (ElementDown#=1) #\/ (ElementLeft#=1)).

%Down extreme
valuePosition(Position,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Position>Size,
Position>Value,
Position<Dim,
PositionRight is Position+1,
PositionLeft is Position-1,
PositionUp is Position-Size,
nth1(Position,List,Element),
nth1(PositionRight,List,ElementRight),
nth1(PositionLeft,List,ElementLeft),
nth1(PositionUp,List,ElementUp),
Element#=1 #/\ ((ElementRight#=1) #\/ (ElementUp#=1) #\/ (ElementLeft#=1)).
