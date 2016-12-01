-module(intervals).
-export([from_list/1]).

-record(interval,{left, right}).

from_list(What) -> lists:reverse(parse(What,0,[])).

slurp([], _, Count) -> {[], Count};
slurp([X|Xs],X,Count) -> slurp(Xs,X,Count + 1);
slurp(Left, _, Count) -> {Left, Count}.

parse([], _, Intervals) -> Intervals;
parse(Tokens = [Token|_], Pos, Intervals) -> 
  {Left, NewPos} = slurp(Tokens,Token,Pos),
  case Token of
    o -> parse(Left, NewPos, Intervals);
    x -> parse(Left, NewPos,[#interval{left = Pos,right = NewPos}| Intervals])
  end.

