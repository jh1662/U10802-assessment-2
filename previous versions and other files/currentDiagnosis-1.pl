% https://medium.com/analytics-vidhya/learn-prolog-language-by-creating-an-expert-system-d46a811c58e8
% https://www.tutorialspoint.com/prolog/index.htm

glucoseFasting(A) :- A >= 126.
%^ Fasting plasma glucose level test - positive when X >= 126 mg/dL
glucoseCurrent(A) :- A >= 200.
%^ Current plasma glucose level test - positive when X >= 200 mg/dL
glycatedHemoglobin(A) :- A >= 48.
%^ Glycated hemoglobin test - positive when X >= 48 mmol/mol

hasDiabetes(A,B,C) :- op(glucoseFasting(A), glucoseCurrent(B), glycatedHemoglobin(C)).
%^ can be either type 1 or 2

%: To differ from type 1 and 2 (or both)

urineHasKetones(A) :- A=1.
autoAntibodiesPresent(A) :- A=1.
hasType1(A,B) :- urineHasKetones(A), autoAntibodiesPresent(B).

% https://www.swi-prolog.org/download/stable <-- use this as website IDE has "code limitations"
