-module(feedParser).

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
    parse(XmlFile, [],
          fun(Event, State) ->
              case {Event, State} of
                  {{startElement, _, "title", _, _}, {_PreviousEvent, State}} ->
                      {titleStart, State};
                  {{characters, Title}, {titleStart, State}} ->
                      {titleCharacters, [Title | State]};
                  _ -> {ignore, State}
              end
          end).

parse(XmlFile, Acc, F) ->
    {ok, Xml} = file:read_file(XmlFile),
    erlsom:parse_sax(Xml, Acc, F).

