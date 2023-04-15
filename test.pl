% facts
father(john, jim).
father(john, kate).
father(john, lisa).
father(bob, ann).
father(bob, pat).
father(jim, lala).
% rules
grandfather(X, Y) :- father(X, Z), father(Z, Y).

is_triphthong(V0, V1, V2) :-
    string_concat(V0, V1, Temp),
    string_concat(Temp, V2, Check),
    format("CHECK : ~w", [Check]),
    member([V0, V1, V2], [['e','a','i'], ['e','a','u'],['i','a','i']]).

:- is_triphthong('e','a','i').
