-module(flags).
-export([bucketify/2]).


bucketify([],M) -> lists:sort(maps:to_list(M));

bucketify([X|Xs], M) -> Count = maps:get(X,M,0),
                        Updated = maps:put(X,Count + 1,M),
                        bucketify(Xs, Updated).


             


