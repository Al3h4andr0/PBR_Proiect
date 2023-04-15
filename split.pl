vowel(Char) :-
    member(Char, ['a', 'e', 'i', 'o', 'u', 'ă', 'î', 'â']).

consonant(Char) :-
    \+ vowel(Char).

is_letter(Char) :-
    char_type(Char, alpha).

is_diphthong(Chars) :-
    member(Chars, ['ai', 'ae', 'au', 'ea', 'ee', 'ei', 'eu', 'ia', 'ie', 'io', 'iu', 'oa', 'oe', 'oi', 'ou', 'ua', 'ue', 'ui', 'uo']).

is_triphthong(Chars) :-
    member(Chars, ['eai', 'eau','iai','iau','iei','ieu','iou','uai','uau','uai','oai','eoa','ioa']).

is_length_one(List) :-
    length(List, 1). % Check if the length of the list is one

insert_hyphen(Str) :-
    atom_chars(Str, Chars), % Convert the input string to a list of characters
    insert_hyphen(Chars, ResultChars), % Call the helper predicate with the list of characters
    flatten(ResultChars, Output),
    format("Output = ~w", [Output]).


insert_hyphen([C0, V1, C1, C2 | Rest], [C0, V1,"-", Result]) :-
    vowel(V1),
    consonant(C0),
    consonant(C1),
    consonant(C2),
    \+ is_length_one(Rest),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r']),
    % format("INTRU 70 3 aici ?cu ~w\n", [Rest]),
    insert_hyphen([C1,C2 | Rest], Result).


insert_hyphen([V1, C1, C2, V2 | Rest], [V1,"-", Result]) :-
    vowel(V1),
    vowel(V2),
    consonant(C1),
    consonant(C2),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r']),
    % format("INTRU 70 2 cu ~w\n", [Rest]),
    insert_hyphen([C1,C2,V2 |Rest], Result).

insert_hyphen([C1, C2, V1 | Rest], [C1, C2, V1,"-", Result]) :-
    vowel(V1),
    consonant(C1),
    consonant(C2),
    consonant(Rest),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r']),
    % format("INTRU 70 2 cu ~w\n", [Rest]),
    insert_hyphen(Rest, Result).

insert_hyphen([C0, V0, C1, V1 | Rest], [C0, V0,"-", C1, V1]) :-
    vowel(V0),
    vowel(V1),
    consonant(C0),
    consonant(C1),
    length(Rest, 0).
    % format("INTRU 70 3cu ~w\n", [Rest]).


insert_hyphen([C0, V1, C1, C2, V2 | Rest], [C0, V1,"-", C1, C2, V2]) :-
    vowel(V1),
    vowel(V2),
    consonant(C0),
    consonant(C1),
    consonant(C2),
    length(Rest, 0),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r']).
    % format("INTRU 70 3cu ~w\n", [Rest]).

insert_hyphen([C1, C2, V1, V2 | Rest], [C1, C2, V1, "-", Result]) :-
    vowel(V1),
    vowel(V2),
    consonant(C1),
    consonant(C2),
    consonant(Rest),
    member(C1, ['b','c','d','f','g','h','p','t','v']),
    member(C2, ['l','r']),
    % format("INTRU 70  4cu ~w\n", [Rest]),
    insert_hyphen([V2|Rest], Result).


insert_hyphen([V1, C1, C2, C3, V2 | Rest], [V1, C1, "-", C2, C3, V2, "-", Result]) :-
    vowel(V1),
    vowel(V2),
    consonant(C1),
    consonant(C2),
    consonant(C3),
    member([C2, C3], [['c', 'h'], ['g', 'h']]),
    \+ length(Rest, 0),
    \+ length(Rest, 1),
    % # format("INTRU 70 cu ~w\n", [Rest]),
    insert_hyphen(Rest, Result).


insert_hyphen([V1, C1, C2, C3, V2 | Rest], [V1, C1, "-", Result]) :-
    vowel(V1),
    vowel(V2),
    consonant(C1),
    consonant(C2),
    consonant(C3),
    member([C2, C3], [['c', 'h'], ['g', 'h']]),
    % # format("INTRU 81\n"),

    insert_hyphen([C2, C3, V2 | Rest], Result).


insert_hyphen([V1, C1, C2, V2 | Rest], [V1, C1, '-' | Result]) :-
    vowel(V1), % Check if V1 is a vowel
    vowel(V2), % Check if V2 is a vowel
    consonant(C1), % Check if C1 is a consonant
    consonant(C2), % Check if C2 is a consonant
    \+ member([C1, C2], [['c', 'h'], ['g', 'h']]), % Check if [C1, C2] is not ['ch'] or ['gh']
    % # format("INTRU 92\n"),
    
    insert_hyphen([C2, V2 | Rest], Result). % Recursive call with remaining characters

insert_hyphen([C0, V1, C1, C2, V2 | Rest], [C0, V1, C1, '-', C2 | Result]) :-
    vowel(V1), % Check if V1 is a vowel
    vowel(V2), % Check if V2 is a vowel
    consonant(C0), % Check if C1 is a consonant
    consonant(C1), % Check if C1 is a consonant
    consonant(C2), % Check if C2 is a consonant
    \+ member([C1, C2], [['c', 'h'], ['g', 'h']]), % Check if [C1, C2] is not ['ch'] or ['gh']
    % # format("INTRU 103\n"),
    
    insert_hyphen([V2 | Rest], Result). % Recursive call with remaining characters

insert_hyphen([C, V1, V2, C2 | Rest], [C, V1, V2, '-' | Result]) :-
    vowel(V1), % Check if V is a vowel
    vowel(V2), % Check if V is a vowel
    consonant(C), % Check if C is a consonant
    consonant(C2), % Check if the next character after V is not a vowel
    % # format("INTRU 112\n"),

    insert_hyphen([C2|Rest], Result). % Recursive call with remaining characters

insert_hyphen([V1, V2, V3, C | Rest], [V1, V2, V3, '-' | Result]) :-
    vowel(V1),
    vowel(V2),
    vowel(V3),
    consonant(C),
    is_triphthong([V1, V2, V3]), % Check if V1 and V2 form a diphthong
    % # format("INTRU 122\n"),
    
    insert_hyphen([C | Rest], Result). % Recursive call with remaining characters


insert_hyphen([C, V | Rest], [C, V, '-' | Result]) :-
    vowel(V), % Check if V is a vowel
    consonant(C), % Check if C is a consonant
    consonant(Rest), % Check if the next character after V is not a vowel
    \+ is_length_one(Rest),
    \+ length(Rest, 0),
    \+ length(Rest, 2),
    % # format("INTRU 134\n"),

    insert_hyphen(Rest, Result). % Recursive call with remaining characters

insert_hyphen([V | Rest], [V | Rest]) :- 
    % # format("INTRU 139 cu ~w\n", [Rest]),

    vowel(V),
    length(Rest, 2).

insert_hyphen([V1, V2 | Rest], [V1, "-", V2 | Rest]) :-
    vowel(V1),
    vowel(V2),
    % # format("INTRU 147\n"),

    length(Rest, 0).

insert_hyphen([C, V | Rest], [C, V, Rest]) :-
    vowel(V), % Check if V is a vowel
    consonant(C), % Check if C is a consonant
    consonant(Rest), % Check if the next character after V is not a vowel
    is_length_one(Rest),
    % # format("INTRU 156\n"),
    length(Rest, 2).
    

insert_hyphen([C, V | Rest], [C, V | Rest]) :-
    vowel(V), % Check if V is a vowel
    % # format("INTRU 163\n"),
    consonant(C), % Check if C is a consonant
    length(Rest, 0).

insert_hyphen([V, C | Rest], [V, '-', Result]) :-
    vowel(V), % Check if V is a vowel
    consonant(C), % Check if the next character after V is not a vowel
    \+ consonant(Rest),

    insert_hyphen([C|Rest], Result). % Recursive call with remaining characters


insert_hyphen([C | Rest], [C | Result]) :-
    insert_hyphen(Rest, Result).

insert_hyphen([], []).
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

