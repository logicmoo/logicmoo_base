/*  LogicMOO User Modules Setup
%
%
% Dec 13, 2035
% Douglas Miles

*/
:- module(logicmoo_lib,
 [
 % logicmoo_user_stacks/0,
 /*op(1199,fx,('==>')),
 op(1190,xfx,('::::')),
 op(1180,xfx,('==>')),
 op(1170,xfx,'<==>'),
 op(1160,xfx,('<-')),
 op(1150,xfx,'=>'),
 op(1140,xfx,'<='),
 op(1130,xfx,'<=>'),
 op(600,yfx,'&'),
 op(600,yfx,'v'),
 op(350,xfx,'xor'),
 op(300,fx,'~'),
 op(300,fx,'-')*/  ]).

/*

:- current_prolog_flag(readline,Was),writeln(readline=Was).
:- if(exists_source(library(editline))).
:- set_prolog_flag(readline,editline).
:- endif.
% :- set_prolog_flag(readline,true).

:- if(current_prolog_flag(readline,editline)).
:- ensure_loaded(library(readline)).
:- listing(prolog:history/2).
:- abolish(prolog:history/2).
:- reconsult(library(editline)).
:- else.
:- if(exists_source(library(readline))).
:- if(exists_source(library(editline))).
:- ensure_loaded(library(editline)).
:- listing(prolog:history/2).
:- abolish(prolog:history/2).
:- endif.
:- unload_file(library(readline)).
:- consult(library(readline)).
:- endif.
:- endif.
:- current_prolog_flag(readline,Was),writeln(readline=Was).
*/

:- set_prolog_flag(report_error,true).
:- set_prolog_flag(access_level,system).
:- set_prolog_flag(debug_on_error,true).
:- set_prolog_flag(optimise,false).
:- set_prolog_flag(last_call_optimisation,false).
/*
:- set_prolog_flag(fileerrors,false).
:- set_prolog_flag(debug,true).
:- set_prolog_flag(gc,false).
:- set_prolog_flag(gc,true).
:- debug.
*/

:- '$set_source_module'(baseKB).
use_shared_module(USM):-baseKB:ensure_loaded(USM).

:- set_prolog_flag(pfc_booted,false).
:- current_prolog_flag(unsafe_speedups,_)->true;set_prolog_flag(unsafe_speedups,true).
:- use_shared_module(library(gvar_syntax)).
:- use_shared_module(library(dictoo)).
:- use_shared_module(library(pfc_lib)).
:- use_shared_module(library(xlisting)).
:- use_shared_module(library('logicmoo/plarkc/logicmoo_i_cyc_rewriting')).
:- use_shared_module(logicmoo_swilib).

%:- kb_shared(col_as_isa/1). % members are used thru  isa(ELEM,COL).
%:- kb_shared(col_as_static/1). % hard coded like: compound/1
%:- kb_shared(col_as_unary/1). % written as COL(ELEM)

:- kb_shared(mpred_prop/3).
:- kb_shared(mudToCyc/2).
:- kb_shared(quotedIsa/2).
:- kb_shared(rtReformulatorDirectivePredicate/1).
:- kb_shared(tCol/1).
:- kb_shared(tSet/1).
:- kb_shared(ttRelationType/1).
:- kb_shared(type_checking/0).
:- kb_shared(disjointWith/2).
:- kb_shared(isa/2).
:- kb_shared(genlsFwd/2).
:- kb_shared(genls/2).
:- kb_shared(meta_argtypes/1).

:- use_shared_module(library('logicmoo/typesystem/mpred_agenda.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_hooks.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_storage.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_stubs.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_type_isa.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_type_constraints.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_type_args.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_type_wff.pl')).
:- use_shared_module(library('logicmoo/typesystem/mpred_type_naming.pl')).

:- use_module(logicmoo_clif).
:- use_module(logicmoo_plarkc).
:- multifile(baseKB:cycBetween/3).
:- dynamic(baseKB:cycBetween/3).
:- baseKB:export(baseKB:cycBetween/3).
:- system:import(baseKB:cycBetween/3).
:- set_prolog_flag(pfc_booted,false).


:- set_prolog_flag(pfc_booted,true).
:- create_prolog_flag(retry_undefined,default,[type(term),keep(true)]).
:- set_prolog_flag(retry_undefined,true).
:- set_prolog_flag(read_attvars,false).

:- ((hook_database:call(asserta_if_new,(ereq(G):- !, baseKB:call_u(G))))).
:- after_boot((wdmsg(after_boot),hook_database:call(asserta_new,(ereq(G):- !, baseKB:call_u(G))))).

:- after_boot((wdmsg(after_boot),hook_database:call(asserta_new,(ereq(G):- !, baseKB:call_u(G))))).




:- must_not_be_pfc_file.


:-  call(prolog_statistics:time,((baseKB:use_shared_module(baseKB:library(logicmoo/pfc/'autoexec.pfc'))))).


:- must_not_be_pfc_file.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SETUP KB EXTENSIONS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%:- '$set_source_module'(baseKB).
%:- '$set_typein_module'(baseKB).

%:- clause(user:term_expansion(I,O),M:Body).
%:- clause(system:term_expansion(I,O),M:Body).


% 	 	 
%% m1 is semidet.
%
% Hook To [checkkb:m1/0] For Module Logicmoo_snark.
% Module Secondary Helper.
%
%:- add_library_search_path('./mpred_online/',[ '*.pl']).
checkKB:m1:- gripe_time(40,ensure_loaded(logicmoo(mpred_online/xlisting_web))),if_defined(ensure_webserver), make,list_undefined.

% :- hook_message_hook.
% :- set_prolog_flag(verbose_autoload,false).
% :- set_prolog_flag(verbose_load,true).
% m9   :-asserta_if_new((user:term_expansion(I,O):- lmbase_expansion(term,user,I,O))).
%m31 :-   (F = mpred/_),foreach(must(baseKB:mpred_is_impl_file(F)),must_det_l((dmsg(list_file_preds(F)),ensure_loaded(F),export_file_preds(F),list_file_preds(F)))).
%m32:- rtrace(ensure_mpred_system).
% m33:- must(filematch_ext(['',mpred,ocl,moo,plmoo,pl,plt,pro,p,'pl.in',pfc,pfct],logicmoo_user:pfc/mpred,W)),dmsg(W),!.

%:-export(m2/0).
% m2:- ensure_mpred_file_loaded(logicmoo(pfc/relationAllExists)).

% :-ain(((P,Q,z(_))==>(p(P),q(Q)))).
%:-export(m3/0).
% m3:- put_variable_names( ['P'=P,'Q'=Q]), R = (==>((P,Q,z(_)),(p(P),q(Q)))),  renumbervars(write_functor,R,O), writeq(O).
%   put_variable_names( ['P'=P,'Q'=Q]), R = (==>((P,Q,z(_)),(p(P),q(Q)))), write_term(R,[numbervars(true),protray(_)]),renumbervars_prev(R,O).

%:-export(m4/0).

%m5 :- enable_mpred_system(baseKB).


ensure_autoexec:- !. % call_u(consult(logicmoo(pfc/'autoexec.pfc'))).

%:- use_listing_vars.
%:- autoload([verbose(false)]).
%:- use_listing_vars.
%:- nop((autoload,scan_for_varnames)).


:- module_transparent((mpred_load_restore_file/1,mpred_load_restore_file/1,mpred_save_restore_file/1)).


mpred_load_restore_file(never):- !,ensure_autoexec,!.
mpred_load_restore_file(File):- absolute_file_name(File,AFN),AFN\=File,!,mpred_load_restore_file(AFN).
mpred_load_restore_file(File):- \+ exists_file(File),
  ensure_autoexec, !,
  mpred_save_restore_file(File),!.

mpred_load_restore_file(File):-
  must_det_l((
  time_file(File,Time),
  qcompile(File),
  ensure_loaded(File),
   ((\+ (baseKB:loaded_file_world_time(N,_,NewTime),NewTime>=Time)) ->true ;
    (
    ignore((baseKB:loaded_file_world_time(N,_,NewTime),NewTime>Time,
     with_umt(baseKB,ensure_mpred_file_loaded(N)),fail)),
    mpred_save_restore_file('some_test.pl~'))))),!.

mpred_save_resore_predicate(M:H,AFN):-
   functor(H,F,A),
   format('~N:- multifile(~q:(~q)/~q).~n',[M,F,A]),
   once((prolog_listing:list_declarations(M:H,M))),
   clause(M:H,B,R), 
   once(clause_property(R,file(AFN));\+clause_property(R,file(_))),
   ignore(once(get_clause_vars(H:-B))),
   prolog_listing:portray_clause((H:-B)).


mpred_save_restore_file(File):- 
 must_det_l((   
  absolute_file_name(File,AFN),
   tell(AFN), 
   format('~N:- ~q.~n',['$set_source_module'(basePFC)]),
   format('~N:- style_check(-singleton).'),  
   listing(_),
   flush_output,
   format('~N:- style_check(-singleton).'),
   format('~N:- ~q.~n',['$set_source_module'(baseKB)]),
   ignore((
   cur_predicate(_,baseKB:H),
    mpred_save_resore_predicate(baseKB:H,AFN),
   flush_output,
   fail)),!,
      format('~N:- ~q.~n',['$set_source_module'(baseKB)]),
      format('~N:- style_check(-singleton).~n'),
      listing(baseKB:loaded_file_world_time/3),
      flush_output,
   told)),!.

:- fixup_exports.

:- baseKB:qsave_lm(lm_repl4).


