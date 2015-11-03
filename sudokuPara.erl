-module(sudokuPara).
-export([aaa/0]).
-import(sudoku,[benchmarks/0, solve_all/0, solve/1]).




aaa()->
    ?EXECUTIONS.

%%
%% solve all puzzles in the (hardcoded) input file
%%
%-spec solve_all() -> [{name(), solution()}].
%solve_all() ->
%  {ok, Puzzles} = file:consult(?PROBLEMS),
%  [{Name, solve(M)} || {Name, M} <- Puzzles].
