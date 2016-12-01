-module(utils).
-export([read_lines/1]).

read_lines(Name) -> {ok, Handle} = file:open(Name, [read]),
                    Lines = slurp(Handle, []),
                    file:close(Handle),
                    Lines.

slurp(Handle, Lines) -> case file:read_line(Handle) of
                          {ok, Line} -> slurp(Handle, [string:strip(Line)|Lines]);
                          eof -> lists:reverse(Lines)
                        end.

                          
                          
                    
