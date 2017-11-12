getChar(Input) :- get_char(_Input),
                  get_char(Input).


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
level(level1).

set_player(Player):-
  nonvar(Player),
  retract(player(_)),
  asserta(player(Player)).

set_mode_game(Newmode):-
  nonvar(Newmode),
  integer(Newmode),
  retract(mode_game(_)),
  asserta(mode_game(Newmode)).

set_user_is(NewPlayer):-
  nonvar(NewPlayer),
  retract(user_is(_)),
  asserta(user_is(NewPlayer)).

duplicate(_Old,_New):-fail.
duplicate(_Old,_Old).

set_level(Level):-
    nonvar(Level),
    integer(Level),
    retract(level(_)),
    asserta(level(Level)).
