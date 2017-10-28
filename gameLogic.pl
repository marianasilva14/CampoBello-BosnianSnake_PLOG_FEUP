game :- selectGameMode,
        displayInitialBoard,
        play.

play :- choosePlayer,
        chooseMovement,
        validateMove,
        printBoard,
        play. %repeat
