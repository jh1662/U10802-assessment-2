% All possible symptoms
%% symptom("polyuria", "thirst", "weight loss", "fatigue", "blurred vision", "genital itchiness").
symptom("polyuria").
symptom("thirst").
symptom("weight loss").
symptom("fatigue").
symptom("blurred vision").
symptom("ginital itchiness").

body_code :-
    write('smth'),
    ask_symptoms,
    ask_again(N),
    dictateSeverity(N),

ask_symptoms :-
    write('Please enter your symptoms, one per line in speech marks.'), nl,
    write('Respond with "done" when you finished (not including the speech marks)'), nl,
    write('All possible symptoms: "polyuria", "thirst", "weight loss", "fatigue", "blurred vision", "genital itchiness"'), nl,
    write('weighting of a symptom can be increased if you entered it multiple times'), nl,
    loop(0).

% incase user made a mistake:
ask_again(N) :-
    write('Do you want to redo (otherwise continue) [y/n]'), nl,
    read(Decision),
    (Decision = y -> ask_symptoms;
    Decision = n -> dictateSeverity(N);
    write('invalid answer - enter either: y or n'), nl, ask_again(N)
    ).

loop(N) :-
    read(Symptom),
    ( Symptom = done ->
        write('Number of matching symptoms: '), write(N), nl
    ; symptom(Symptom) ->
        N1 is N + 1, loop(N1),
    	write(Symptom), write(' - matching symptom added!'), nl
    ; loop(N), write(Symptom), write(' - symptom doesnt match existing syptoms or is mispelled'), nl
    ).

dictate_severity(N) :-
    write(N).