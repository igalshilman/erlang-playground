-module(markov).

-export([histogram/1]).

histogram(Tokens) -> histogram(Tokens, #{}).

histogram([], Histogram) -> Histogram;

histogram([_A], Histogram) -> Histogram;

histogram([A | Rest = [B|_]], Histogram) -> 
  Updated = update_in([A,B], fun incr/1, Histogram),
  histogram(Rest, Updated).

get_key(K, Map) -> case maps:is_key(K, Map) of
                    true -> {some, maps:get(K, Map)};
                    false -> none
                   end.

update_key(K, F, Map) ->
    OldValue = get_key(K, Map),
    NewValue = F(OldValue),
    maps:put(K, NewValue, Map).
 
update_in([K], F, Map) -> update_key(K, F, Map);

update_in([K|Ks], F,  Map) -> 
   Existing = maps:get(K, Map, #{}),
   Updated = update_in(Ks, F, Existing),
   Map#{ K => Updated }.
    
incr({some, Count}) -> Count + 1;
incr(none) -> 1.
