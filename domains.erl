-module(domains).

-export([example/0, ads/2]).


example() -> #{ "com" => #{ "google" => #{ "mail" => [ad1,ad2] },
                         "ebay" =>  [ad3, ad4],
                         "wix" => #{ "sale" => [squarespace] } },
                "co" => #{ "jp" => #{ "pokemon" => [ad5]},
                        "il" => #{ "ynet" => #{ "talkback" => [ad6] }}}}.

ads(X, Db) -> Tokens = string:tokens(X, "."), 
              Query = lists:reverse(Tokens),
              find(Query, Db).          

find(_ , Db) when is_list(Db) -> {ok, Db}; 

find([], _) -> false;

find([X|Xs], Map) when is_map(Map) -> 
    case maps:is_key(X,Map) of 
      true -> find(Xs, maps:get(X, Map));
      false -> undefined
    end.
                                   

  
