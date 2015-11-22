-module(feed_parser).

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


parse(Xml) ->
    {ok, Result, _TrailingChars} = erlsom:parse_sax(Xml, {start, []}, fun parseElement/2),
    {ok, Result}.

parse(Xml, Acc, F) ->
    erlsom:parse_sax(Xml, Acc, F).

parseElement(Event, {PreviousElement, State}) ->
    case {Event, PreviousElement} of
        {{startElement, _, "title", _, _}, _} ->
            {titleStart, State};
        {{characters, Title}, titleStart} ->
            {titleCharacters, [Title | State]};
        {endDocument, _} ->
            State;
        _ -> {PreviousElement, State}
    end.



