-module(feed_parser_SUITE).
-include_lib("common_test/include/ct.hrl").
-compile(export_all).

all() ->
    [parse].

parse(Config) ->
    File = list_to_binary([?config(data_dir, Config), "test_feed.xml"]),
    {ok, Xml} = file:read_file(File),
    {ok, _} = feed_parser:parse(Xml).