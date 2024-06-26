% All possible symptoms
symptom(polyuria).
symptom(thirst).
symptom(weight_loss).
symptom(fatigue).
symptom(blurred_vision).
symptom(genital_itchiness).

% initialiser predicate for visual symptoms
symptoms(RESULT_SYMPTOMS) :-
    write('Starting visual symptom count...'), nl,
    symptoms_introduction,
    symptoms_dictate(RESULT_SYMPTOMS)
    %% symptoms_ask_again
.
% get users input of sypmtoms
symptoms_ask(Symptom) :-
    format('Do you have this symptom: ~w? (yes/no)~n', [Symptom]),
    read(Answer),
    Answer == yes
.
% introduction of how to the visual symptom part of the expert system
symptoms_introduction :-
    write('This is the visual symptoms part of the diagnosis test:'), nl,
    write('All possible symptoms: "polyuria", "thirst", "weight loss", "fatigue", "blurred vision", "genital itchiness"'), nl,
    write('Each symptom will be saperately asked, respond if patient has them'), nl,
    write('All symptom are all easily identifiable, as they are all visual, so if you are having trouble spotting a particular then the patient does not have it'), nl
.
% dictating the result based on users inputs
symptoms_dictate(RESULT_SYMPTOMS) :-
    findall(Symptom, (symptom(Symptom), symptoms_ask(Symptom)), Symptoms),
    length(Symptoms, Count),
    (
        Count < 2 ->  write('Patient has little or no visual symptoms of diabetes - patient is fine'), nl, RESULT_SYMPTOMS = 0;
        Count < 4 ->  write('Patient has a medium amount of visual symptoms of diabetes - patient is mostly fine but still at risk, please concider taking a diagnostic test if situation gets worse'), nl, RESULT_SYMPTOMS = 1;
        write('Patient has little or no visual symptoms of diabetes - patient is fine'), RESULT_SYMPTOMS = 2
    )
.
%%% incase user made a mistake
%% symptoms_ask_again :-
%%    write('Do you want to redo (otherwise continue) [y/n]'), nl,
%%    read(Decision),
%%    (Decision = y -> symptoms;
%%    Decision = n -> write('proceeding...'), nl;
%%    write('invalid answer - enter either: y or n'), nl, symptoms_ask_again
%%    )
%% .