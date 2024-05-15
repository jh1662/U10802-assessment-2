% required for predicate to work
:- dynamic user_fact/2.

% all relevent medical history points
medical_history(genetic_conditions, family_members_with_diabetes_when_young).
medical_history(genetic_conditions, mitochondrial_DNA_mutations).
medical_history(endocrine_diseases, defects_in_proinsulin_conversion).
medical_history(endocrine_diseases, insulin_gene_mutations).
medical_history(endocrine_diseases, insulin_receptor_mutations).
medical_history(pancreatic_affects, chronic_pancreatitis).
medical_history(pancreatic_affects, pancreatectomy).
medical_history(pancreatic_affects, pancreatic_neoplasia).
medical_history(pancreatic_affects, cystic_fibrosis).
medical_history(pancreatic_affects, hemochromatosis).
medical_history(pancreatic_affects, fibrocalculous_pancreatopathy).
medical_history(infection, cytomegalovirus_infection).
medical_history(infection, coxsackievirus_B).
medical_history(existing_medication, glucocorticoids).
medical_history(existing_medication, thyroid_hormone).
medical_history(existing_medication, adrenergic_agonists).
medical_history(existing_medication, statins).

% loop of asking user about his/her medical history
medical_history_ask :-
    medical_history(Category, Fact),
    format('Do you have this condition in either the present or past: ~w (~w)? (yes/no)~n', [Fact, Category]),
    read(Answer),
    (Answer == yes -> assert(user_fact(Category, Fact)); true),
    fail
.
% Required for looping
medical_history_ask.

medical_history_check(RESULT_HISTORY) :-
    medical_history_introduction,
    retractall(user_fact(_, _)),
    medical_history_ask,
    findall(Category, user_fact(Category, _), Categories),
    sort(Categories, UniqueCategories),
    length(UniqueCategories, NumCategories),
    (
        NumCategories < 2 -> writeln('User is unlikely to have diabeties now or in the future'), nl, RESULT_HISTORY = 0;
        NumCategories < 4 -> writeln('User is slightly likely to have diabeties now or in the future'), nl, RESULT_HISTORY = 1;
        writeln('User is very likely to have diabeties now or in the future'), nl, RESULT_HISTORY = 2
    )
.
% introduction of how to the medical history part of the expert system
medical_history_introduction :-
    write('This is the medical history part of the diagnosis test:'), nl,
    write('A bunch of relevent medical history questions will be asked.'), nl,
    write('Depending on the answer it will predict if you may have or get diabeites depending of the different aspects of medical history.'), nl,
    write('Medical terms asked are advanced and specific, so make sure a professional check if you have these or not.'), nl
.

