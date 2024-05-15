genetic_conditions(family_members_with_diabetes_when_young).
genetic_conditions(mitochondrial_DNA_mutations).

endocrine_diseases(defects_in_proinsulin_conversion).
endocrine_diseases(insulin_gene_mutations).
endocrine_diseases(insulin_receptor_mutations).

panceatic_affects(chronic_pancreatitis).
panceatic_affects(pancreatectomy).
panceatic_affects(pancreatic_neoplasia).
panceatic_affects(cystic_fibrosis).
panceatic_affects(hemochromatosis).
panceatic_affects(fibrocalculous_pancreatopathy).

infection(cytomegalovirus_infection).
infection(coxsackievirus_B).

existing_medication(glucocorticoids).
existing_medication(thyroid_hormone).
existing_medication(adrenergic_agonists).
existing_medication(statins).

has_condition :-
    ask_user(genetic_conditions),
    ask_user(endocrine_diseases),
    ask_user(panceatic_affects),
    ask_user(infection),
    ask_user(existing_medication)
.

% introduction of how to the blood diagnosis part of the expert system
diagnosis_indroduction :-
	write('This is the diabetes diagnosis test. Please make sure that the patient meet these requirements for the test:'), nl

.
% get users input of medical history
ask_user(Condition) :-
    findall(X, call(Condition, X), Conditions),
    member(Condition, Conditions),
    format('Does the patient have the condition: ~w? (yes/no)\n', [Condition]),
    read(Answer),
    (Answer == yes -> true ; fail)
.