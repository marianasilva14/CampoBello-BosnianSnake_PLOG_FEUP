%Predicate that read a char
getChar(Input) :- get_char(_Input),
                  get_char(Input).

%Predicate that read a number
getCode(Input) :- get_code(_TempInput),
                  get_code(TempInput),
                  Input is TempInput - 48.

:-dynamic player/1.
:-dynamic mode_game/1.
:-dynamic user_is/1.
:-dynamic level/1.

mode_game(1).
player(playerX).
user_is(player).
level(1).

%Predicate that sets the player
set_player(Player):-
  nonvar(Player),
  retract(player(_)),
  asserta(player(Player)).

%Predicate that sets the mode game
set_mode_game(Newmode):-
  nonvar(Newmode),
  integer(Newmode),
  retract(mode_game(_)),
  asserta(mode_game(Newmode)).

%Predicate that sets the user
set_user_is(NewPlayer):-
  nonvar(NewPlayer),
  retract(user_is(_)),
  asserta(user_is(NewPlayer)).

%Predicate that sets the level
set_level(Level):-
    nonvar(Level),
    integer(Level),
    retract(level(_)),
    asserta(level(Level)).

%Predicate that converts each letter into its respective number
    letterToNumber('A',1).
    letterToNumber('B',2).
    letterToNumber('C',3).
    letterToNumber('D',4).
    letterToNumber('E',5).
    letterToNumber('F',6).
    letterToNumber('G',7).
    letterToNumber('H',8).
    letterToNumber('I',9).

%Predicate that converts each number into its respective letter
    numberToLetter(1,'A').
    numberToLetter(2,'B').
    numberToLetter(3,'C').
    numberToLetter(4,'D').
    numberToLetter(5,'E').
    numberToLetter(6,'F').
    numberToLetter(7,'G').
    numberToLetter(8,'H').
    numberToLetter(9,'I').

%Predicate copying one board to another
duplicate(_Old,_New):-fail.
duplicate(_Old,_Old).
