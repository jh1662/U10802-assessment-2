:- consult('symptoms.pl').
:- consult('currentDiagnosis.pl').
:- consult('diabetiesType.pl').
:- consult('medicalHistoryRisk.pl').

initial :-
    symptoms(RESULT_SYMPTOMS),
    blood(RESULT_BLOOD),
    type(RESULT_TYPE),
    medical_history_check(RESULT_HISTORY),
    (
        RESULT_SYMPTOMS == 0 -> write('Patient has low or no visual symptoms ');
        RESULT_SYMPTOMS == 1 -> write('Patient has medium amount visual symptoms ');
        RESULT_SYMPTOMS == 2 -> write('Patient has high amount of visual symptoms ')
    ),
    (
        RESULT_BLOOD == 0 -> write('with blood composition in normal levels ');
        RESULT_BLOOD == 1 -> write('with blood composition in diabetic levels ')
    ),
    (
        RESULT_HISTORY == 0 -> write('and medical records suggesting that patient is not volatile to diabetes ');
        RESULT_HISTORY == 1 -> write('and medical records suggesting that patient is slightly volatile to diabetes ');
        RESULT_HISTORY == 2 -> write('and medical records suggesting that patient is highly volatile to diabetes ')
    ),
    (
        RESULT_TYPE == 0 -> write('which is predicted to be of both type 1 and type 2'), nl;
        RESULT_TYPE == 1 -> write('which is predicted to be of type 1'), nl;
        RESULT_TYPE == 2 -> write('which is predicted to be of type 2'), nl;
        RESULT_TYPE == 3 -> write('which is predicted to be of another type of diabetes that is not type 1 nor type 2'), nl
    ),
    FinalSay is RESULT_SYMPTOMS + RESULT_BLOOD + RESULT_HISTORY,
    (
        FinalSay < 3 -> write('Patient does not have diabetes.');
        (
            RESULT_TYPE == 0 -> write('Patient does have diabetes of types 1 and 2.');
            RESULT_TYPE == 1 -> write('Patient does have diabetes of type 1.');
            RESULT_TYPE == 2 -> write('Patient does have diabetes of type 2.');
            RESULT_TYPE == 3 -> write('Patient does have diabetes of a non-primary type (other than 1 and 2).')
        )
    ).

:- initialization(initial).
