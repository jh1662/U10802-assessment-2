diabetes_type(1,ketones_in_urine).
diabetes_type(1,presense_of_antibodies).
diabetes_type(2,presense_of_insulin).
diabetes_type(2,skin_infection_or_itchiness).

type :-
    write('Now to determine which type of diabetes the patient has.\n'),
    type_ask(ketones_in_urine,0,0,Type1_1,Type2_1),
    type_ask(presense_of_antibodies,Type1_1,Type2_1,Type1_2,Type2_2),
    type_ask(presense_of_insulin,Type1_2,Type2_2,Type1_3,Type2_3),
    type_ask(skin_infection_or_itchiness,Type1_3,Type2_3,Type1_4,Type2_4),
    type_determine(Type1_4,Type2_4)
.
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
type_determine(Type1,Type2) :-
	(
    	Type1 > 1, Type2 > 1 -> write('Patient has both type 1 and type 2 diabetes');
        Type1 > 1 -> write('Patient has type 1 diabetes');
        Type2 > 1 -> write('Patient has type 2 diabetes');
		write('Patient has another type of diabetes that is not type 1 or 2')
    )
.