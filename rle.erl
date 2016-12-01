-module(rle).
-export([rle/1, rle_decode/1]).

-record(run, {elem, count}).


rle([]) -> [];
rle([X|Xs]) -> lists:reverse(loop(Xs, X, 1, [])).

run_of(What, Count) -> #run{elem = What, count = Count}.

loop([], X, Run, Acc)-> [run_of(X,Run) | Acc];
loop([X|Xs], X, Run, Acc) -> loop(Xs,X,Run + 1, Acc);
loop([X|Xs], Y, Run, Acc) -> loop(Xs,X,1, [run_of(Y, Run) | Acc]).

repeat(_What, 0, Acc) -> Acc; 
repeat(What, N, Acc) -> repeat(What, N - 1, [What | Acc]). 

rle_decoder([], Acc) -> lists:reverse(Acc);
rle_decoder([#run{elem = What, count = Count} | Rest], Acc) ->  
  rle_decoder(Rest, repeat(What, Count, Acc)).

rle_decode(What) -> rle_decoder(What, []).
