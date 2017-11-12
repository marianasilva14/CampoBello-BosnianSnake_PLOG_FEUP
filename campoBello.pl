:- include('gameLogic.pl').
:- include('menus.pl').
:- include('displayBoard.pl').
:- include('utilities.pl').
:- include('validateMoves.pl').
:- include('levelDifficulty.pl').

campoBello :- mainMenu.

reload:-reconsult('/Users/francisca/Documents/FEUP/3 ano/1 semestre/PLOG/feup-PLOG/CampoBello.pl').
