-module(core).

-export([update_in/3, assoc_in/3, dessoc_in/2, histogram/1]).

assoc_in(Keys, Value, Map) -> 
  update_in(Keys, fun (_) -> Value end, Map).

dessoc_in([K], Map) -> 
    maps:remove(K, Map);

dessoc_in([K|Keys], Map) -> 
    case maps:is_key(K, Map) of 
      true ->  Dessoced = dessoc_in(Keys, maps:get(K, Map)),
               Map#{K => Dessoced};
      false -> Map
    end.

update_in([K], F, Map) -> 
  update_key(K, F, Map);

update_in([K|Ks], F,  Map) -> 
   Existing = maps:get(K, Map, #{}),
   Updated = update_in(Ks, F, Existing),
   Map#{ K => Updated }.

update_key(K, F, Map) ->
    OptionalValue = get_value(K, Map),
    NewValue = F(OptionalValue),
    maps:put(K, NewValue, Map).
 
get_value(K, Map) -> 
  case maps:is_key(K, Map) of
    true -> {some, maps:get(K, Map)};
    false -> none
  end.

histogram(Elements) -> 
  histogram(Elements, #{}).

histogram([], Map) -> Map;

histogram([E|Es], Map) ->
    Count = maps:get(E, Map, 0) + 1, 
    Updated = maps:put(E, Count, Map),
    histogram(Es, Updated).

incr({some, N}) -> N + 1;
incr(none) -> 1.





