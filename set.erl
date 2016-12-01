-module(set).
-export([empty/0, from_list/1, add/2, member/2, remove/2]).

empty() -> #{}.

from_list(X) -> from_list(X,empty()).

from_list([], Acc) -> Acc;
from_list([X|Xs], Acc) -> Updated = add(X, Acc),
                          from_list(Xs, Updated).

add(X, Set) -> Set#{ X => true }.

member(X, Set) -> maps:is_key(X, Set).

remove(X, Set) -> maps:remove(X, Set).
