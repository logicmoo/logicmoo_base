:- include(test_header).
#!/usr/bin/env swipl

% =================================================================================
% Load the system
% =================================================================================

:- ensure_loaded(library(logicmoo_user)).

:- make.

:- set_lang(clif).
:- begin_pfc.

% =================================================================================
% Set our engine up
% =================================================================================

% deduce instances from usages in args having the effect of deducing human,dwelling,beverage_class are classes
==> feature_setting(make_wff,true).
% set truth maintainance system to remove previous assertions that new assertions disagree with 
==> feature_setting(tms_mode,remove_conflicting).

:- set_prolog_flag(runtime_debug,3). % mention it when we remove previous assertions

:- set_prolog_flag_until_eof(do_renames,mpred_expansion).

:- kif_compile.

% =================================================================================
% poss / ~poss sanity tests
% =================================================================================

:- mpred_trace_exec.

:- dynamic(a/1).

:- mpred_test(poss(a(b))).

poss(a(b)).

:- mpred_test(poss(a(b))).

~poss(a(b)).


:- mpred_test(\+ poss(a(b))).

:- mpred_test(~ poss(a(b))).

:- listing(poss).

:- mpred_test( ~a(b)).


