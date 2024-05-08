% https://medium.com/analytics-vidhya/learn-prolog-language-by-creating-an-expert-system-d46a811c58e8
% https://www.tutorialspoint.com/prolog/index.htm

% blood compoment levels where normal is below the number in the fact
blood_limits(glucose_fasting_mg_PER_dL,126). % Fasting (for 8 hours) plasma glucose level test - positive when >= 126 mg/dL
blood_limits(glucose_current_mg_PER_dL,200). % Current plasma glucose level (two hours after a 75 gram oral glucose load) test - positive when >= 200 mg/dL
blood_limits(glycated_hemoglobin_mmol_PER_mol,48). % Glycated hemoglobin test - positive when >= 48 mmol/mol


% initialiser predicate for blood diagnosis
diagnosis :-
    write('Starting the diabetes risk assessment...'), nl,
    diagnosis_indroduction,
    findall(Component, blood_limits(Component, _), Components),
    diagnosis_loop(0, Positives, Components),
    %%write('number of positive tests: ~w ~n', Positives),
    format('Number of positive tests: ~w ~n', [Positives]), nl, % why is 'Positives' a list?
    (
    	[Positives] > 2 -> write('Patient currently have diabetes - should be diagnosed with diabetes');
    	write('Patient currently does not have diabetes - should not be diagnosed with diabetes')
    ),
    ! % prevents other outputs
.
% loop for taking each blood composition level and counting
diagnosis_loop(Positives, Positives, []).
diagnosis_loop(PositivesIn, PositivesOut, [Component|Components]) :-
    diagnosis_ask(Component, Level),
    ( diagnosis_dictate(Component, Level) -> PositivesNext is PositivesIn + 1; PositivesNext = PositivesIn ),
    diagnosis_loop(PositivesNext, PositivesOut, Components)
.
% get users input of blood composition levels
diagnosis_ask(Component, Level) :-
    format('Please enter your ~w level: ~n', Component),
    read(Level)
.
% introduction of how to the blood diagnosis part of the expert system
diagnosis_indroduction :-
	write('This is the diabetes diagnosis test. Please make sure that the patient meet these requirements for the test:'), nl
    write('>> Patient must be currently fasting for 8 hours striaght before the fasting glucose blood test'), nl,
    write('>> Patient must take a 75-gram oral glucose load 2 hours before the current glucose blood test'), nl,
    write('>> Patient must also take the glycated hemoglobin blood test'), nl,
    write('Patient is required to do all three tests (not one or two of them) for the diagnosis test to work.'), nl,
    write('This is because the patient will be diagnosed if all three tests are positive (blood component level exceed limits)'), nl
.
% telling user if subjected blood composition level is above limit or not
diagnosis_dictate(Component, Level):-
    blood_limits(Component, Limit),
    (
    	Level > Limit ->  format('Your ~w level of ~w exceeds the normal limit of ~w ~n', [Component, Level, Limit]), true;
    	format('Your ~w level of ~w is within the normal limit.~n', [Component, Level]), false
    )
.