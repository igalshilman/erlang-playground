-module(balanced).
-export([test/1]).

test(What) -> balanced(What, 0).

balanced([], 0) -> true;
balanced([], N) -> false;
balanced([open|Rest], N) -> balanced(Rest, N + 1);
balanced([closed|Rest], N) -> balanced(Rest, N - 1);
balanced([_|Rest], N) -> balanced(Rest, N).


