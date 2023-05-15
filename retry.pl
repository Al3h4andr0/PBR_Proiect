vowel(Char) :-
    member(Char, ['a', 'e', 'i', 'o', 'u', 'ă', 'î', 'â']).

consonant(Char) :-
    \+ vowel(Char).

is_letter(Char) :-
    char_type(Char, alpha).

is_triphthong(V0, V1, V2) :-
    member([V0,V1,V2], [['e','a','i'], ['e','a','u'], ['i','a','i'], ['i','a','u'], ['i','e','i'], ['i','e','u'], ['i','o','u'], ['o','a','i'], ['e','o','a'], ['i','o','a']]).

insert_hyphen(Str, Output, Ignore) :-
    atom_chars(Str, Chars), % Convert the input string to a list of characters
    insert_hyphen(Chars, ResultChars), % Call the helper predicate with the list of characters
    flatten(ResultChars, Output).


insert_hyphen([C0, V0, C1, V1], [C0, V0, C1, V1]) :-
    vowel(V0),
    vowel(V1),
    consonant(C0),
    consonant(C1),
    member(C0, ['t']),
    member(V0, ['a']),
    member(V1, ['i']),
    member(C1, ['z']).

insert_hyphen([V0, C, V1| Rest], [V0, "-", Result]) :-
    vowel(V0),
    vowel(V1),
    consonant(C),
    insert_hyphen([C,V1|Rest], Result).

insert_hyphen([V0, C0, C1, V1| Rest], [V0, C0, "-", Result]) :-
    vowel(V0),
    vowel(V1),
    consonant(C0),
    consonant(C1),
    member(C0, ['f','c', 't']),
    member(C1, ['t','n', 'v']),
    insert_hyphen([ C1, V1 | Rest], Result ).


insert_hyphen([V0, C0, C1, V1| Rest], [V0, "-", Result]) :-
    vowel(V0),
    vowel(V1),
    consonant(C0),
    consonant(C1),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h']),
    insert_hyphen([C0, C1, V1|Rest], Result).

insert_hyphen([V0, C0, C1, V1| Rest], [V0, C0, "-", Result]) :-
    vowel(V0),
    vowel(V1),
    consonant(C0),
    consonant(C1),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h', 's']),
    insert_hyphen([C1, V1|Rest], Result).


insert_hyphen([C0, C1, V0 | Rest], [C0, C1, V0, Rest]) :-
    consonant(C0),
    consonant(C1),
    vowel(V0),
    \+ member(C0, ['s']),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h']),
    length(Rest, 2).


insert_hyphen([C0, C1, V0, C2 | Rest], [C0, C1, V0, C2]) :-
    consonant(C0),
    consonant(C1),
    consonant(C2),
    vowel(V0),
    member(C0, ['g','h']),
    member(C1, ['l','r', 'h']),
    length(Rest, 0).


insert_hyphen([C0, C1, V0, C2| Rest], [C0, C1, V0, "-", Result]) :-
    consonant(C0),
    consonant(C1),
    consonant(C2),
    vowel(V0),
    \+ member(C0, ['s']),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h']),
    insert_hyphen([C2|Rest], Result).

insert_hyphen([C0, C1, V0, V1 | Rest], [C0, C1, V0, "-", V1]) :-
    consonant(C0),
    consonant(C1),
    vowel(V0),
    vowel(V1),
    length(Rest, 0),
    \+ member(C0, ['s']),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h']).


insert_hyphen([C0, C1, V0, C2 | Rest], [C0, C1, V0, C2]) :-
    consonant(C0),
    consonant(C1),
    consonant(C2),
    vowel(V0),
    \+ member(C0, ['s']),
    member(C0, ['b','c','d','f','g','h','p','t','v']),
    member(C1, ['l','r', 'h']),
    member(C2, ['z','l','r', 'h', 'g']),
    length(Rest, 0).

insert_hyphen([V0, C0, C1, C2, V1| Rest], [V0, C0, "-", Result]) :-
    consonant(C0),
    consonant(C1),
    consonant(C2),
    vowel(V0),
    member(C0, ['s']),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r', 'h']),
    insert_hyphen([C1, C2, V1|Rest], Result).


insert_hyphen([C0, C1, C2| Rest], [C0, "-", Result]) :-
    consonant(C0),
    consonant(C1),
    consonant(C2),
    \+ member(C0, ['s']),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r', 'h']),
    insert_hyphen([C1, C2|Rest], Result).

insert_hyphen([C0, C1, V0 | Rest],[C0, C1, V0, "-", Result]) :-
    consonant(C0),
    consonant(C1),
    vowel(V0),
    member(C0, ['c','g']),
    member(C1, ['h']),
    \+ length(Rest, 0),
    insert_hyphen(Rest, Result).

insert_hyphen([C0, V0, V1 | Rest], [C0, V0, "-", V1]) :-
    consonant(C0),
    member(C0, ['d','m','h']),
    vowel(V0),
    vowel(V1),
    length(Rest, 0).

insert_hyphen([V0, V1, V2, V3| Rest], [V0, "-", Result]) :-
    vowel(V0),
    vowel(V1),
    vowel(V2),
    vowel(V3),
    is_triphthong(V1,V2,V3),
    insert_hyphen([V1, V2, V3|Rest], Result).

insert_hyphen([C0,C1, V | Rest], [C0, "-", Result]) :-
    consonant(C0),
    consonant(C1),
    \+ member(C0, ['b','c','d','f','g','h','p','t','v']),
    \+ member(C1, ['l','r']),
    vowel(V),
    insert_hyphen([C1, V|Rest], Result).

insert_hyphen([C | Rest], [C | Result]) :-
    insert_hyphen(Rest, Result).

insert_hyphen([], []).
/*
:- format("Regula 1: \n").
:- insert_hyphen("casa").
:- format("\n").
:- insert_hyphen("padure").
:- format("\n").
:- insert_hyphen("utilizare").
:- format("\n").
:- insert_hyphen("rece").
:- format("\n").
:- insert_hyphen("vecin").
:- format("\n").
:- insert_hyphen("podis").
:- format("\n").
:- insert_hyphen("afis").
:- format("\n").
:- insert_hyphen("lege").
:- format("\n").
:- insert_hyphen("oleaca").
:- format("\n").
:- insert_hyphen("luna").
:- format("\n").
:- insert_hyphen("soare").
:- format("\n").
:- insert_hyphen("razei").
:- format("\n").
:- insert_hyphen("paine").
:- format("\n").
:- insert_hyphen("stropeala").
:- format("\n").
:- insert_hyphen("creioane").
:- format("\n").
:- insert_hyphen("axa").
:- format("\n").
:- insert_hyphen("examen").
:- format("\n").
:- insert_hyphen("exercitiu").
:- format("\n").
:- insert_hyphen("ureche").
:- format("\n").
:- insert_hyphen("achitat").
:- format("\n").
:- insert_hyphen("leghe").
:- format("\n").
:- insert_hyphen("oghial").
:- format("\n").
:- format("Regula 2\n").
:- insert_hyphen("arca").
:- format("\n").
:- insert_hyphen("artist").
:- format("\n").
:- insert_hyphen("munte").
:- format("\n").
:- insert_hyphen("unghie").
:- format("\n").
:- insert_hyphen("icni").
:- format("\n").
:- insert_hyphen("ticsit").
:- format("\n").
:- insert_hyphen("activ").
:- format("\n").
:- insert_hyphen("caftan").
:- format("\n").
:- insert_hyphen("multe").
:- format("\n").
:- insert_hyphen("inger").
:- format("\n").
:- insert_hyphen("lungit").
:- format("\n").
:- insert_hyphen("ungher").
:- format("\n").
:- insert_hyphen("inghiti").
:- format("\n").
:- insert_hyphen("munte").
:- format("\n").
:- insert_hyphen("ascet").
:- format("\n").
:- insert_hyphen("ischemie").
:- format("\n").
:- insert_hyphen("aschimodie").
:- format("\n").
:- insert_hyphen("astazi").
:- format("\n").
:- insert_hyphen("obraz").
:- format("\n").
:- insert_hyphen("codru").
:- format("\n").
:- insert_hyphen("afluent").
:- format("\n").
:- insert_hyphen("african").
:- format("\n").
:- insert_hyphen("agrafa").
:- format("\n").
:- insert_hyphen("suplete").
:- format("\n").
:- insert_hyphen("patru").
:- format("\n").
:- insert_hyphen("covrig").
:- format("\n").
:- insert_hyphen("evlavie").
:- format("\n").
:- insert_hyphen("obloni").
:- format("\n").
:- insert_hyphen("aclama").
:- format("\n").
:- insert_hyphen("acru").
:- format("\n").
:- insert_hyphen("codlea").
:- format("\n").
:- insert_hyphen("afla").
:- format("\n").
:- insert_hyphen("africa").
:- format("\n").
:- insert_hyphen("aglutinant").
:- format("\n").
:- insert_hyphen("agronom").
:- format("\n").
:- insert_hyphen("pehlivan").
:- format("\n").
:- insert_hyphen("pohrib").
:- format("\n").
:- insert_hyphen("suplu").
:- format("\n").
:- insert_hyphen("cupru").
:- format("\n").
:- insert_hyphen("atlet").
:- format("\n").
*/
