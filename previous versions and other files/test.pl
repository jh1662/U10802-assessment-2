first :-
    second(Data),
    format('~w', Data).

second(Data) :-
    third(Data).

third(Data) :-
    Data = 1.