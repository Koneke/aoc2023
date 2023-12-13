-module(day1).
-export([part1/0]).

get_all_lines(Handle) ->
    case io:get_line(Handle, "") of
        eof -> [];
        Line -> [Line | get_all_lines(Handle)]
    end.

readlines(Path) ->
    {ok, File} = file:open(Path, [read]),
    try
        get_all_lines(File)
    after
        file:close(File)
    end.

part1() ->
    Input = readlines("day1-1.txt"),

    Filtered = lists:map(
        fun(Line) ->
            lists:filter(
                fun(Character) -> Character >= $0 andalso Character =< $9 end,
                Line
            )
        end,
        Input
    ),

    lists:sum(
        lists:map(
            fun(Line) ->
                [First, Last] = [hd(Line) - $0, hd(lists:reverse(Line)) - $0],
                First * 10 + Last
            end,
            Filtered
        )
    ).
