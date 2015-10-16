-module(readrss).
-export([read/0]).


read() -> httpc:request(get, {"http://www.erlang.org", []}, [], []).