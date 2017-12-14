:- use_module(library(clpfd)).
:- use_module(library(random)).
:- use_module(library(lists)).
:- include('dictionaryOfBoards.pl').

bosnianSnake :-
  board(Board), printFinalBoard(Board), findSolution(Board, Head, Tail).

findSolution(Board, Head, Tail) :- printPath().
