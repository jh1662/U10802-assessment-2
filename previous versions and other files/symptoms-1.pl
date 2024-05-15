% All possible symptoms
symptom("polyuria").
symptom("thirst").
symptom("weight loss").
symptom("fatigue").
symptom("blurred vision").
symptom("genital itchiness").

% initialiser predicate
symptoms :-
    write('Starting symptom count'), nl,
    ask_symptoms,
    loop(0),
    ask_again.

% introduction
ask_symptoms :-
    write('Please enter your symptoms, one per line in speech marks.'), nl,
    write('Respond with "done" when you finished (not including the speech marks)'), nl,
    write('All possible symptoms: "polyuria", "thirst", "weight loss", "fatigue", "blurred vision", "genital itchiness"'), nl,
    write('weighting of a symptom can be increased if you enter it multiple times'), nl.

% incase user made a mistake:
ask_again :-
    write('Do you want to redo (otherwise continue) [y/n]'), nl,
    read(Decision),
    (Decision = y -> symptoms;
    Decision = n -> write('proceeding...'), nl;
    write('invalid answer - enter either: y or n'), nl, ask_again
    ).

% iterate over each symptom input
loop(N) :-
    read(Symptom),
    (
    Symptom = done -> write('Number of matching symptoms: '), write(N), nl,
    (
    	N < 2 -> write('Patient has little or no visible symptoms of diabetes'), nl;
    	N < 4 -> write('Patient has medium visible symptoms of diabetes'), nl;
    	write('Patient has high visible symptoms of diabetes'), nl
    )
    ;
    symptom(Symptom) -> N1 is N + 1, loop(N1),
    write(Symptom), write(' - matching symptom added!'), nl
    ;
    loop(N), write(Symptom), write(' - symptom doesnt match existing syptoms or is mispelled'), nl
    ).
