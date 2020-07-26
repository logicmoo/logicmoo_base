/*
2.15.1.9 Singleton variable checking

A singleton variable is a variable that appears only one time in a 
clause. It can always be replaced by _, the anonymous variable. 

In some cases, however, people prefer to give the variable a name. 
As mistyping a variable is a common mistake, Prolog systems generally 
give a warning (controlled by style_check/1) if a variable is used 
only once. 
The system can be informed that a variable is meant to appear once by 
starting it with an underscore, e.g., _Name. 
Please note that any variable, except plain _, shares with variables 
of the same name. The term t(_X, _X) is equivalent to t(X, X), which 
is different from t(_, _). 
% http://www.swi-prolog.org/pldoc/man?section=singleton
*/
test(_).    
test(_a).	% Singleton variables: [_a]
test(_12).	% Singleton variables: [_12]
test(A).	% Singleton variables: [A]
test(_A).
test(__a).
test(_, _).
test(_a, _a).
test(__a, __a).	% Singleton-marked variables appearing more than once: [__a]
test(_A, _A).	% Singleton-marked variables appearing more than once: [_A]
test(A, A). 

/*
Semantic singletons

Starting with version 6.5.1, SWI-Prolog has syntactic singletons and 
semantic singletons. The first are checked by read_clause/3 (and 
read_term/3 using the option singletons(warning)). 

The latter are generated by the compiler for variables that appear 
alone in a branch. For example, in the code below the variable X is 
not a syntactic singleton, but the variable X does not communicate any 
bindings and replacing X with _ does not change the semantics.
*/

test :-
        (   test_1(X)
        ;   test_2(X)
        ).