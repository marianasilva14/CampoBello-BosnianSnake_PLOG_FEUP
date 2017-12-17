:- use_module(library(clpfd)).
:- use_module(library(lists)).

%Predicate that does an if than else
matrixToListOfLists(Board,List) :-
  append(Board,List).

getPosition(Dim,Row,Col,Position) :-
  Position is (Row-1)*Dim+Col.
%
% checkConectivity(_,_,0).
%
% checkConectivity(Board,Dim,Position) :-
% matrixToListOfLists(Board,List),
% valuePosition(Position,List,Dim,ReturnPosition),
% write(ReturnPosition),nl,nl,
% checkConectivity(Board,Dim,ReturnPosition).
%
% %First left position
% valuePosition(Position,List,Size,R):-
% Position==1,
% PositionRight is Position+1,
% PositionDown is Position+Size,
% nth1(Position,List,Element),
% nth1(PositionRight,List,ElementRight),
% nth1(PositionDown,List,ElementDown),
% write('PositionRight'+PositionRight),
% Element=1,
% ((ElementRight#=1 #/\ R#=PositionRight) #\/ (ElementDown#=1 #/\ R#=PositionDown)),
% write('SAI'),nl,nl,
% write('R'+R).
%
%
% %First right position
% valuePosition(Position,List,Size,R):-
% Position==Size,
% PositionLeft is Position-1,
% PositionLeft2 is Position-2,
% PositionDown is Position+Size,
% PositionDown2 is Position+Size+Size,
% nth1(PositionLeft2,List,ElementLeft2),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionDown2,List,ElementDown2),
% ((ElementLeft #= 1 #<=> B #/\ (B#=1  #/\ ElementLeft#=0)) #\/ (ElementDown #= 1 #<=> B #/\ (B#=1 #/\ ElementDown#=0))),
% ((ElementLeft2 #= 0 #<=> B #/\ (B#=1  #/\ ElementLeft#=1)) #\/ (ElementDown2 #= 0 #<=> B #/\ (B#=1  #/\ ElementDown#=1))),
% if_then_else(ElementLeft==1,R is PositionLeft,R is PositionDown).
%
%
% %Last second position
% valuePosition(Position,List,Size,ReturnPosition):-
% Dim is Size*Size,
% Position==Dim,
% nth1(Position,List,Element),
% Element=1,
% ReturnPosition=0.
%
% %Last first position
% valuePosition(Position,List,Size,R):-
% Dim is Size*Size,
% Value is Dim-Size,
% Position==Value,
% PositionRight is Position+1,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionUp,List,ElementUp),
% ((ElementRight#\=0  #/\ ElementRight#=1) #\/ (ElementUp#\=0 #/\ ElementUp#=1)),
% if_then_else(ElementRight==1,R is PositionRight,R is PositionUp).
%
% %Left extreme
% valuePosition(Position,List,Size,R):-
% Position\=1,
% Dim is Size*Size,
% Value is Dim-Size,
% Position \= Value,
% PositionMod is Position mod Size,
% PositionMod==1,
% PositionRight is Position+1,
% PositionRight2 is Position+2,
% PositionDown is Position+Size,
% PositionDown2 is Position+Size+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionRight2,List,ElementRight2),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionDown2,List,ElementDown2),
% nth1(PositionUp,List,ElementUp),
% PositionUp \=1,
% write('Position'+Position),nl,
% nth1(PositionUp2,List,ElementUp2),
% ((ElementUp2 #\=1 #/\ ElementUp #\=1) #/\
% (ElementUp #= 1, R #= PositionUp)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight#\=1) #/\
% (ElementRight #=1, R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1, R #= PositionDown)).
%
% %Left extreme
% valuePosition(Position,List,Size,R):-
% Position\=1,
% Dim is Size*Size,
% Value is Dim-Size,
% Position \= Value,
% PositionMod is Position mod Size,
% PositionMod==1,
% PositionRight is Position+1,
% PositionRight2 is Position+2,
% PositionDown is Position+Size,
% PositionDown2 is Position+Size+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionRight2,List,ElementRight2),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp ==1,
% Sub is Value-Size,
% Sub \=Position,
% nth1(PositionDown2,List,ElementDown2),
% write('Position'+Position),nl,
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight#\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Left extreme
% valuePosition(Position,List,Size,R):-
% Position\=1,
% Dim is Size*Size,
% Value is Dim-Size,
% Position \= Value,
% PositionMod is Position mod Size,
% PositionMod==1,
% PositionRight is Position+1,
% PositionRight2 is Position+2,
% PositionDown is Position+Size,
% PositionDown2 is Position+Size+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionRight2,List,ElementRight2),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% Sub is Value-Size,
% Sub ==Position,
% nth1(PositionDown2,List,ElementDown2),
% write('Position'+Position),nl,
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight#\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% (ElementDown #\=1 #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Left extreme
% valuePosition(Position,List,Size,R):-
% Position\=1,
% Dim is Size*Size,
% Value is Dim-Size,
% Position \= Value,
% PositionMod is Position mod Size,
% PositionMod==1,
% PositionRight is Position+1,
% PositionRight2 is Position+2,
% PositionDown is Position+Size,
% PositionDown2 is Position+Size+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionRight2,List,ElementRight2),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionDown2,List,ElementDown2),
% nth1(PositionUp,List,ElementUp),
% PositionUp ==1,
% write('Position'+Position),nl,
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight#\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Right extreme
% valuePosition(Position,List,Size,R):-
% Position\=Size,
% Dim is Size*Size,
% Position \= Dim,
% PositionMod is Position mod Size,
% PositionMod==0,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp == Size,
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1  #/\ ElementLeft#\=1) #/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Right extreme
% valuePosition(Position,List,Size,R):-
% Position\=Size,
% Dim is Size*Size,
% Position \= Dim,
% PositionMod is Position mod Size,
% PositionMod==0,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp \= Size,
% PositionUp2 is PositionUp-Size,
% ((ElementUp2 #\=1 #/\ ElementUp #\=1)#/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1  #/\ ElementLeft#\=1) #/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
%
% %Central positions nao pode andar para cima, nem para a esquerda mas pode para baixo e para a direita
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp <Size,
% Value2 is Value-Size,
% Value2 < Value2,
% Mod is PositionLeft mod Size,
% Mod ==1,
% Mod2 is PositionRight mod Size,
% Mod2 \=0,
% PositionDown2 is PositionDown+Size,
% nth1(PositionDown2,List,ElementDown2),
% PositionRight2 is PositionRight+1,
% nth1(PositionRight2,List,ElementRight2),
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% (ElementLeft #\=1 #/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions pode andar para cima e para baixo e para a direita, nao pode para a esquerda
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp  > Size,
% Value2 is Value-Size,
% Position< Value2,
% Mod2 is PositionRight mod Size,
% Mod2 \=0,
% Mod is PositionLeft mod Size,
% Mod ==1,
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% PositionRight2 is PositionRight+1,
% nth1(PositionRight2,List,ElementRight2),
% PositionDown2 is PositionDown-Size,
% nth1(PositionDown2,List,ElementDown2),
% ((ElementUp #\=1  #/\ ElementUp2#\=1)#/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% (ElementLeft #\=1 #/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions pode andar para cima e para a direita e  nao para baixo e para a esquerda
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp  > Size,
% Value2 is Value-Size,
% Position >= Value2,
% Mod is PositionLeft mod Size,
% Mod ==1,
% Mod2 is PositionRight mod Size,
% Mod2 \=0,
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% PositionRight2 is PositionRight-Size,
% nth1(PositionRight2,List,ElementRight2),
% ((ElementUp #\=1  #/\ ElementUp2#\=1)#/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% (ElementLeft #\=1 #/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% (ElementDown #\=1 #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions nao pode andar para cima mas pode andar para a esquerda,direita e para baixo
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp <Size,
% Value2 is Value-Size,
% Position < Value2,
% PositionRight2 is PositionRight-1,
% Mod is PositionLeft mod Size,
% Mod \=1,
% Mod2 is PositionRight mod Size,
% Mod2 \=0,
% nth1(PositionRight2,List,ElementRight2),
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionDown2 is PositionDown+Size,
% nth1(PositionDown2,List,ElementDown2),
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1 #/\ElementLeft #\=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions nao pode andar para cima e para a direita mas pode andar para a esquerda e para baixo
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp <Size,
% Value2 is Value-Size,
% Position <Value,
% Mod is PositionLeft mod Size,
% Mod \=1,
% Mod2 is PositionRight mod Size,
% Mod2 ==0,
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionDown2 is PositionDown+Size,
% nth1(PositionDown2,List,ElementDown2),
% (ElementUp #\=1 #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1 #/\ElementLeft #\=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% (ElementRight #\=1 #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions pode andar para cima,para baixo,direita e esquerda
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp >Size,
% Value2 is Value-Size,
% Position < Value,
% Mod is PositionRight mod Size,
% Mod \=0,
% Mod2 is PositionLeft mod Size,
% Mod2 \=1,
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionDown2 is PositionDown+Size,
% nth1(PositionDown2,List,ElementDown2),
% PositionRight2 is PositionRight+1,
% nth1(PositionRight2,List,ElementRight2),
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% ((ElementUp #\=1 #/\ElementUp2 #\=1) #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1 #/\ElementLeft #\=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions pode andar para cima,baixo,esquerda e nao para a direita
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp <Size,
% Value2 is Value-Size,
% Position < Value2,
% Mod is PositionLeft mod Size,
% Mod \=1,
% Mod2 is PositionRight mod Size,
% Mod2 ==0,
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionDown2 is PositionDown+Size,
% nth1(PositionDown2,List,ElementDown2),
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% ((ElementUp #\=1 #/\ ElementUp2#\=1)  #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft #\=1  #/\ ElementLeft2#\=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% (ElementRight #\=1 #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% ((ElementDown2 #\=1  #/\ ElementDown #\=1) #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Central positions pode andar para cima,esquerda, nao pode para a direita nem para baixo
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp  > Size,
% Value2 is Value-Size,
% Position >= Value2,
% Mod is PositionLeft mod Size,
% Mod \=1,
% Mod2 is PositionRight mod Size,
% Mod2 ==0,
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% ((ElementUp #\=1 #/\ ElementUp2 #\=1)#/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft #\=1 #/\ ElementLeft2 \=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% (ElementRight #\=1 #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% (ElementDown #\=1 #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
%
%
% %Central positions nao pode andar para baixo mas pode andar para a direita,esquerda e cima
% valuePosition(Position,List,Size,R):-
% Position>Size,
% Dim is Size*Size,
% Value is Dim-Size,
% Position<Value,
% PositionMod is Position mod Size,
% PositionMod\=0,
% PositionMod\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% nth1(PositionUp,List,ElementUp),
% PositionUp >Size,
% Value2 is Value-Size,
% Position >= Value2,
% Mod is PositionRight mod Size,
% Mod \=0,
% Mod2 is PositionLeft mod Size,
% Mod2 \=1,
% PositionLeft2 is PositionLeft-1,
% nth1(PositionLeft2,List,ElementLeft2),
% PositionUp2 is PositionUp-Size,
% nth1(PositionUp2,List,ElementUp2),
% PositionRight2 is PositionRight+1,
% nth1(PositionRight2,List,ElementRight2),
% ((ElementUp #\=1  #/\ ElementUp2 #\=1) #/\
% (ElementUp #= 1 #/\ R #= PositionUp)) #\/
% ((ElementLeft2 #\=1 #/\ElementLeft #\=1)#/\
% (ElementLeft #=1 #/\ R #= PositionLeft)) #\/
% ((ElementRight2 #\=1  #/\ ElementRight #\=1) #/\
% (ElementRight #=1 #/\ R #= PositionRight)) #\/
% (ElementDown #\=1 #/\
% (ElementDown #=1 #/\ R #= PositionDown)).
%
% %Up extreme
% valuePosition(Position,List,Size,R):-
% Position<Size,
% Position\=Size,
% Position\=1,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionDown is Position+Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionDown,List,ElementDown),
% (ElementRight==1,
% (ElementDown #=1 #\/ ElementLeft#=1));
% (ElementLeft==1,
% (ElementDown #=1 #\/ ElementRight#=1));
% (ElementDown==1,
% (ElementRight #=1 #\/ ElementLeft#=1)),
% if_then_else(ElementRight==1,R is PositionRight,if_then_else(ElementDown==1,R is PositionDown,R is PositionLeft)).
%
%
% %Down extreme
% valuePosition(Position,List,Size,R):-
% Dim is Size*Size,
% Value is Dim-Size,
% Position>Size,
% Position>Value,
% Position<Dim,
% PositionRight is Position+1,
% PositionLeft is Position-1,
% PositionUp is Position-Size,
% nth1(PositionRight,List,ElementRight),
% nth1(PositionLeft,List,ElementLeft),
% nth1(PositionUp,List,ElementUp),
% (ElementRight==1,
% (ElementUp #=1 #\/ ElementLeft#=1));
% (ElementLeft==1,
% (ElementUp #=1 #\/ ElementRight#=1));
% (ElementUp==1,
% (ElementRight #=1 #\/ ElementLeft#=1)),
% if_then_else(ElementRight==1,R is PositionRight,if_then_else(ElementLeft==1,R is PositionLeft,PositionUp)).
