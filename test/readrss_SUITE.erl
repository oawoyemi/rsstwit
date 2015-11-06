-module(readrss_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0]).

-export([test1/1, init_per_suite/1]).

all() -> [test1].

init_per_suite(Config) ->
    Config.

test1(_Config) ->