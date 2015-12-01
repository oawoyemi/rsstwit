-module(feed_parser_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0]).
-export([parse_entries/1]).

all() ->
    [parse_entries].

parse_entries(Config) ->
    File = list_to_binary([?config(data_dir, Config), "test_feed.xml"]),
    {ok, Xml} = file:read_file(File),
    {ok, Entries} = feed_parser:parse(Xml),
    ["Create mnesia tables without using atoms", 
     "How to create Error log for ejabberd messages", 
     "Race condition example in Programming Erlang book"] = lists:sublist(Entries, 3).
       
