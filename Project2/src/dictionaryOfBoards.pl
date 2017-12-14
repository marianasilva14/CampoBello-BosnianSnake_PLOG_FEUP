getSymbol(empty, ' ').
getSymbol(head, 'H').
getSymbol(tail, 'T').

board([[head,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,empty],
[empty,empty,empty,empty,empty,tail]]).

printFinalBoard([L|Ls]):-
    nl,
    printLetters,nl,
    printBoard([L|Ls],0),
    printLine.

printLetters:-
  write('     A     B     C     D     E     F    ').

printSpaces:-
  write('   |    |     |     |     |     |     |').

printBoard([],_).
printBoard([L|Ls],Y) :-
  printLine,nl,
  printSpaces,nl,
  Y1 is Y+1,
  printFinalRow(L,Y1),nl,
  printSpaces,nl,
  printBoard(Ls,Y1).

printFinalRow([X|Xs],Y):-
  write(Y),
  write('  |'), printRow([X|Xs]).

printRow([X|Xs]):-
  getSymbol(X,Piece),
  write(' '), write(Piece),write('  | '),
  printRow(Xs).
printRow([]).

printLine:-
  write('   ------------------------------------').
