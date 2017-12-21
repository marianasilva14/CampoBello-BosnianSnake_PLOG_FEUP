:- use_module(library(clpfd)).
:- use_module(library(lists)).

%Predicate that does an if than else
matrixToListOfLists(Board,List) :-
append(Board,List).

getPosition(Dim,Row,Col,Position) :-
Position is (Row-1)*Dim+Col.

imposeConectivity([],_,_,_).

imposeConectivity([_|Tail],List,Dim,Position) :-
getNeighbours(Position,Neighbours,List,Dim),
getAllNeighbours(Position,AllNeighbours,List,Dim),
imposePosition(Position,Neighbours,AllNeighbours,List,Dim),
NextPosition is Position+1,
imposeConectivity(Tail,List,Dim,NextPosition).

imposePosition(Position,Neighbours,AllNeighbours,List,Size):-
  Dim is Size*Size,
  Value is Dim-Size,
  Value2 is Dim-1,
  Value1 is Value +1,
  Position \=1,
  Position \=Size,
  Position \=Dim,
  Position\=Value1,
  sum(Neighbours,#=,Sum),
  sum(AllNeighbours,#=,Sum2),
  nth1(Position,List,Element),
  Element#=1 #=> ((Sum #=2) #/\ (Sum2 #=< 4)).

imposePosition(Position,Neighbours,AllNeighbours,List,Size):-
  Dim is Size*Size,
  Value is Dim-Size,
  Value1 is Value +1,
  (Position==Size;
  Position==Value1),
  sum(Neighbours,#=,Sum),
  sum(AllNeighbours,#=,Sum2),
  nth1(Position,List,Element),
  Element#=1 #=> ((Sum #=2) #/\ (Sum2 #= 2)).

imposePosition(Position,Neighbours,AllNeighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value +1,
(Position==1;
Position==Dim),
sum(Neighbours,#=,Sum),
sum(AllNeighbours,#=,Sum2),
nth1(Position,List,Element),
Element#=1 #=> ((Sum #=1) #/\ (Sum2 #= 1)).


getNeighbours(Position,Neighbours,List,Size):-
Position==1,
PositionRight is Position+1,
PositionDown is Position+Size,
setof(Element, (nth1(PositionRight,List,Element);
                nth1(PositionDown,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Position==Dim,
PositionLeft is Position-1,
PositionUp is Position-Size,
setof(Element, (nth1(PositionUp,List,Element);
                nth1(PositionLeft,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position==Value1,
PositionRight is Position+1,
PositionUp is Position-Size,
setof(Element, (nth1(PositionUp,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Position==Size,
PositionLeft is Position-1,
PositionDown is Position+Size,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionDown,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Mod is Position mod Size,
Mod ==1,
Position\=1,
Position\=Value1,
PositionRight is Position+1,
PositionDown is Position+Size,
PositionUp is Position-Size,
setof(Element, (nth1(PositionRight,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionUp,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Mod is Position mod Size,
Mod ==0,
Position\=Size,
Position\=Dim,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionUp is Position-Size,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionUp,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Position<Size,
Position\=1,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionRight is Position+1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position>Value1,
Position\=Dim,
PositionLeft is Position-1,
PositionUp is Position-Size,
PositionRight is Position+1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionUp,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getNeighbours(Position,Neighbours,List,Size):-
Position>Size,
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position<Value1,
Mod is Position mod Size,
Mod \=0,
Mod \=1,
PositionLeft is Position-1,
PositionUp is Position-Size,
PositionDown is Position+Size,
PositionRight is Position+1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionUp,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).


              %%%%%%%%

getAllNeighbours(Position,Neighbours,List,Size):-
Position==1,
PositionRight is Position+1,
PositionDown is Position+Size,
PositionDownRight is PositionRight+Size,
setof(Element, (nth1(PositionRight,List,Element);
                nth1(PositionDownRight,List,Element);
                nth1(PositionDown,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Position==Dim,
PositionLeft is Position-1,
PositionUp is Position-Size,
PositionUpLeft is PositionLeft-Size,
setof(Element, (nth1(PositionUp,List,Element);
                nth1(PositionUpLeft,List,Element);
                nth1(PositionLeft,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position==Value1,
PositionRight is Position+1,
PositionUp is Position-Size,
PositionUpRight is PositionRight-Size,
setof(Element, (nth1(PositionUp,List,Element);
                nth1(PositionUpRight,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Position==Size,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionDownLeft is PositionDown-1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionDownLeft,List,Element);
                nth1(PositionDown,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Mod is Position mod Size,
Mod ==1,
Position\=1,
Position\=Value1,
PositionRight is Position+1,
PositionDown is Position+Size,
PositionUp is Position-Size,
PositionRightUp is PositionUp+1,
PositionDownRight is PositionDown+1,
setof(Element, (nth1(PositionRight,List,Element);
                nth1(PositionRightUp,List,Element);
                nth1(PositionDownRight,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionUp,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Mod is Position mod Size,
Mod ==0,
Position\=Size,
Position\=Dim,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionUp is Position-Size,
PositionUpLeft is PositionUp-1,
PositionDownLeft is PositionDown-1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionUpLeft,List,Element);
                nth1(PositionDownLeft,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionUp,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Position<Size,
Position\=1,
PositionLeft is Position-1,
PositionDown is Position+Size,
PositionRight is Position+1,
PositionDownLeft is PositionDown-1,
PositionDownRight is PositionDown+1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionDownLeft,List,Element);
                nth1(PositionDownRight,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position>Value1,
Position\=Dim,
PositionLeft is Position-1,
PositionUp is Position-Size,
PositionRight is Position+1,
PositionUpRight is PositionUp+1,
PositionUpLeft is PositionUp-1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionUpLeft,List,Element);
                nth1(PositionUpRight,List,Element);
                nth1(PositionUp,List,Element);
                nth1(PositionRight,List,Element)),
                Neighbours).

getAllNeighbours(Position,Neighbours,List,Size):-
Position>Size,
Dim is Size*Size,
Value is Dim-Size,
Value1 is Value+1,
Position<Value1,
Mod is Position mod Size,
Mod \=0,
Mod \=1,
PositionLeft is Position-1,
PositionUp is Position-Size,
PositionDown is Position+Size,
PositionRight is Position+1,
PositionDownRight is PositionDown+1,
PositionDownLeft is PositionDown-1,
PositionUpRight is PositionUp+1,
PositionUpLeft is PositionUp-1,
setof(Element, (nth1(PositionLeft,List,Element);
                nth1(PositionUp,List,Element);
                nth1(PositionDown,List,Element);
                nth1(PositionRight,List,Element);
                nth1(PositionUpLeft,List,Element);
                nth1(PositionUpRight,List,Element);
                nth1(PositionDownLeft,List,Element);
                nth1(PositionDownRight,List,Element)),
                Neighbours).
