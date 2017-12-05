printMainMenu:-
  nl,nl,nl,
  write('         ___________________________________________________________________________________________'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |  _____   ______   _    _   ______   ______     ______   ______   __       __      ______  |'),nl,
  write('        | |  ___| |  __  | | |  | | |  __  | |  __  |   |  __  | |  ____| |  |     |  |    |  __  | |'),nl,
  write('        | | |     | |__| | | /__/ | | |__| | | |  | |   | |__| | | |____  |  |     |  |    | |  | | |'),nl,
  write('        | | |     | |__| | | |  | | |  ____| | |  | |   |  __  | |  ____| |  |     |  |    | |  | | |'),nl,
  write('        | | |___  | |  | | | |  | | | |      | |__| |   | |__| | | |____  |  |___  |  |___ | |__| | |'),nl,
  write('        | |_____| |_|  |_| |_|  |_| |_|      |______|   |______| |______| |______| |______||______| |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                        Francisca Leao Cerquinho Ribeiro da Fonseca                        |'),nl,
  write('        |                                    Mariana Lopes Silva                                    |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                               1.Start Game Player vs Player                               |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                 2.Start Game PC vs Player                                 |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                   3.Start Game PC vs PC                                   |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                      4.Set Difficulty                                     |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                       5.How to Play                                       |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                           6.Exit                                          |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |                                                                                           |'),nl,
  write('        |___________________________________________________________________________________________| '),nl,nl,nl,nl,
  write('                                          Choose an option, please!                                   '),nl, nl, nl, nl.


  printHowToPlayMenu:-
    nl,nl,nl,
    write('         ___________________________________________________________________________________________'),nl,
    write('        |                                                                                           |'),nl,
    write('        |                                                                                           |'),nl,
    write('        |                                                                                           |'),nl,
    write('        |                    _   _                 _         ______ _                               |'),nl,
    write('        |                   | | | |               | |        | ___ | |                              |'),nl,
    write('        |                   | |_| | _____      __ | |_ ___   | |_/ / | __ _ _   _                   |'),nl,
    write('        |                   |  _  |/ _  |  /| / / | __/ _  | |  __/| |/ _` | | | |                  |'),nl,
    write('        |                   | | | | (_) | V  V /  | || (_) | | |   | | (_| | |_| |                  |'),nl,
    write('        |                   |_| |_/|___/ |_/|_/   | __|___/  |_|   |_||__,_||__, |                  |'),nl,
    write('        |                                                                    __/ |                  |'),nl,
    write('        |                                                                    |___/                  |'),nl,
    write('        |                                                                                           |'),nl,
    write('        |    In this game, each player tries to remove as much as possible from their of the board. |'),nl,
    write('        |In turn, the player must jump with his piece to another and if the piece that jumped is one|'),nl,
    write('        |of yours, you should remove it from the game. Otherwise, if it is one of the adversaries,  |'),nl,
    write('        |then you can remove any of your pieces ohe board (including the one used in the jump).     |'),nl,
    write('        |    Each player can "chain" up to 3 jumps with the same piece of but you can not jump over |'),nl,
    write('        |it twice. The piece with which the player jumps can not occupy the same space during the   |'),nl,
    write('        |same move. If not can jump, the player can ignore his turn. The game ends when a player has|'),nl,
    write('        |no more pieces on the board or no player can make a real leap.                             |'),nl,
    write('        |    At the end of the game, each player gets 1 point for each of their pieces out of your  |'),nl,
    write('        |starting area and 3 points for each piece that is in your area of match. The player with   |'),nl,
    write('        |the lowest number of points wins.                                                          |'),nl,
    write('        |                                                                                           |'),nl,
    write('        |                                                                                           |'),nl,
    write('        |                                          0. Back                                          |'),nl,
    write('        |___________________________________________________________________________________________| '),nl,nl,nl,nl.

    printSetLevelMenu:-
      nl,nl,nl,
      write('         ___________________________________________________________________________________________'),nl,
      write('        |                                                                                           |'),nl,
      write('        |                                                                                           |'),nl,
      write('        |                            Please choose the level of the Game:                           |'),nl,
      write('        |                                                                                           |'),nl,
      write('        |                                       1. Normal Difficulty                                |'),nl,
      write('        |                                       2. Hard Difficulty                                  |'),nl,
      write('        |                                                                                           |'),nl,
      write('        |                                                                                           |'),nl,
      write('        |___________________________________________________________________________________________| '),nl,nl,nl,nl.

      mainMenu :- printMainMenu,
      now(X), setrand(X),
      read(Input),
      set_mode_game(Input),
      set_level(1),
      readInput(Input).

      readInput(0) :- mainMenu.

      readInput(1) :- initialBoard(Board),printFinalBoard(Board),
      play(Board),
      mainMenu.

      readInput(2) :- initialBoard(Board), printFinalBoard(Board),
      set_user_is('pcX'),
      play(Board),
      mainMenu.

      readInput(3) :- initialBoard(Board), printFinalBoard(Board),
      set_user_is('pcX'),
      play(Board),
      mainMenu.

      readInput(4) :- printSetLevelMenu,
      read(Input),
      readInput2(Input).

      readInput2(1) :- set_level(1),
      mainMenu.

      readInput2(2) :- set_level(2),
      mainMenu.

      readInput(5) :- printHowToPlayMenu,
      read(Input),
      readInput(Input).

      readInput(6) :- write('Exiting...').
