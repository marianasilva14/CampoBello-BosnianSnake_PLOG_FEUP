getChar(Input) :- get_char(_Input),
                  get_char(Input).


getCode(Input) :- get_code(_TempInput),
                  get_code(TempInput),
                  Input is TempInput - 48.

:-dynamic player/1.
:-dynamic mode_game/1.

mode_game(1).
player(playerX).

set_player(Player):-
  nonvar(Player),
  retract(player(_)),
  asserta(player(Player)).

set_mode_game(Newmode):-
  nonvar(Newmode),
  integer(Newmode),
  retract(mode_game(_)),
  asserta(mode_game(Newmode)).
