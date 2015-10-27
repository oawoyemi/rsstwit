-module(readrss_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0]).

-export([test1/1, init_per_suite/1]).

all() -> [test1].

init_per_suite(Config) ->
    inets:start(),
    Config.

readme() -> {ok, {_Status, _Headers, Body}}  = httpc:request(get, {"http://stackoverflow.com/feeds/tag?tagnames=erlang&sort=newest", []}, [], []),
    Body.

test1(_Config) -> ct:pal(" ~s ", [readme()]).