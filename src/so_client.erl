-module(so_client).

-export([start/0]).
-export([stop/0]).
-export([get_entries/0]).

-spec start() -> any().
start() ->
  inets:start().

-spec stop() -> ok.
stop() ->
  inets:stop().

-spec get_entries() -> {Title :: binary(), Url :: binary()}.
get_entries() ->
  {ok, {_Status, _Headers, Body}} = httpc:request("http://stackoverflow.com/feeds/tag?tagnames=erlang&sort=newest"),
  Entries = extract_entries(Body),
  [{feeder_entries:get(title, X), feeder_entries:get(link, X)} || X <- Entries].

extract_entries(Body) ->
  Data = list_to_binary(Body),
  file:write_file("temp.xml", Data),
  {ok, EventState, _Rest} = feeder:file("temp.xml", opts()),
  file:delete("temp.xml"),
  {_Feed, Entries} = EventState,
  Entries.

event({entry, Entry}, {Feed, Entries}) ->
  {Feed, [Entry | Entries]};
event({feed, Feed}, {[], Entries}) ->
  {Feed, Entries};
event(endFeed, {Feed, Entries}) ->
  {Feed, lists:reverse(Entries)}.

opts() ->
  [{event_state, {[], []}}, {event_fun, fun event/2}].

