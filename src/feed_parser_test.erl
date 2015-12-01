-module(feed_parser_test).
-include_lib("eunit/include/eunit.hrl").


-ifdef(TEST).
-compile(export_all).
-endif.

all_test_() ->
    {setup,
        fun start/0,
        fun stop/0}.


start() ->
        ok.

stop() ->
        ok.
    
        
