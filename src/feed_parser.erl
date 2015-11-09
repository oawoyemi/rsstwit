-module(feed_parser).

%% API
-export([parse/1, parseCount/1]).

count(Event, Acc) ->
    case Event of
        {startElement, _, "title", _, _} ->
            Acc + 1;
        _ ->
            Acc
    end.

parseCount(XmlFile) ->
    parse(XmlFile, 0, fun count/2).


parse(XmlFile) ->
    parse(XmlFile, {start, []}, fun parseElement/2).

parseElement(Event, {PreviousElement, State}) ->
    case {Event, PreviousElement} of
        {{startElement, _, "title", _, _}, _} ->
            {titleStart, State};
        {{characters, Title}, titleStart} ->
            {titleCharacters, [Title | State]};
        {endDocument, _} ->
%%            io:format("~p~n", {Event, State}),
            State;
        _ -> {PreviousElement, State}
    end.

parse(XmlFile, Acc, F) ->
    {ok, Xml} = file:read_file(XmlFile),
    erlsom:parse_sax(Xml, Acc, F).

