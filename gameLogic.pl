/*play2 :- choosePlayer,
        chooseMovement,
        validateMove,
        printBoard,
        play. /*repeat*/

play :- chooseMovement.

chooseMovement :- write('Please choose the piece that you want move:'),
                  nl,
                  write('Please enter a position (A...I)'),
                  nl,
                  read(Input1),
                  write('Please enter a position (1...9)'),
                  nl,
                  read(Input2),
                  checkIfExistsPeace,
                  write('What is the position of peace that you want move?'),
                  nl,
                  write('Please enter a position (A...I)'),
                  nl,
                  read(Input3),
                  write('Please enter a position (1...9)'),
                  nl,
                  read(Input4).

checkIfExistsPeace :-
