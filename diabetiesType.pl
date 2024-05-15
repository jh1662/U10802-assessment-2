diabetes_type(1, ketones_in_urine).
diabetes_type(1, presense_of_antibodies).
diabetes_type(2, presense_of_insulin).
diabetes_type(2, skin_infection_or_itchiness).

% initialiser for the type detector
type(RESULT_TYPE) :-
    type_indroduction,
    type_ask(ketones_in_urine,0,0,Type1_1,Type2_1),
    type_ask(presense_of_antibodies,Type1_1,Type2_1,Type1_2,Type2_2),
    type_ask(presense_of_insulin,Type1_2,Type2_2,Type1_3,Type2_3),
    type_ask(skin_infection_or_itchiness,Type1_3,Type2_3,Type1_4,Type2_4),
    type_determine(Type1_4,Type2_4, RESULT_TYPE)
.
% loop for asking user for type-specific symtoms
type_ask(Point,Type1_in,Type2_in,Type1_out,Type2_out) :-
    format('Does the patient have: ~w? (yes/no)\n', [Point]),
    read(Answer),
    (
        Answer == yes,
        diabetes_type(X,Point) ->
            (
                X == 1 -> Type1_out is Type1_in + 1, Type2_out = Type2_in;
                X == 2 -> Type2_out is Type2_in + 1, Type1_out = Type1_in
            )
    ;
        Type1_out = Type1_in, Type2_out = Type2_in
    )
.
% determines what type of diabetes the patient has if patient have diabetes
type_determine(Type1,Type2,RESULT_TYPE) :-
	(
    	Type1 > 1, Type2 > 1 -> write('Patients blood composition suggests that pateint has both type 1 and type 2 diabetes'), nl, RESULT_TYPE = 0;
        Type1 > 1 -> write('Patients blood composition suggests that pateint has type 1 diabetes'), nl, RESULT_TYPE = 1;
        Type2 > 1 -> write('Patients blood composition suggests that pateint has type 2 diabetes'), nl, RESULT_TYPE = 2;
		write('Patients blood composition suggests that pateint has another type of diabetes that is not type 1 nor type 2'), nl, RESULT_TYPE =3
    )
.
% introduction of how to the diabeties type part of the expert system
type_indroduction :-
	write('This is the type detection part of the diagnosis test:'), nl,
    write('Diabeties type specific symtoms will be asked'), nl,
    write('based on the anwers, the type of potential diabetes will be 1, 2, both or a non-primary type'), nl
.