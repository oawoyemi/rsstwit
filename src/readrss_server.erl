-module(readrss_server).

-behaviour(gen_server).

-export([start_link/0]).

-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2,  code_change/3]).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []),
    inets:start().

init([]) ->
    {ok, []}.

%% callbacks
handle_call(read, _From, State) ->
    {ok, _Status, Body} = httpc:request("http://stackoverflow.com/feeds/tag?tagnames=erlang&sort=newest"),
    {reply, xmerl_scan:string(Body), State};
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%     P = fun(Event, Acc) -> case Event of {startElement, _, "title", _, _} -> ParseTitle; _ -> Acc end end,
%%     erlsom:parse_sax(Xml, 0, fun(Event, Acc) -> case Event of {startElement, _, "entry", _, _} -> Acc + 1; _ -> Acc end.

%% printTitle(Event) -> case Event of {characters, Title} -> io:format("~p~n", [Title]); _ -> "" end end.
