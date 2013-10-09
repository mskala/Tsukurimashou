%
% Support script for running Hamlog programs in ECLiPSe-CLP
% Copyright (C) 2011, 2013  Matthew Skala
%
% This program is free software: you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation, version 3.
%
% As a special exception, if you create a document which uses this font, and
% embed this font or unaltered portions of this font into the document, this
% font does not by itself cause the resulting document to be covered by the
% GNU General Public License. This exception does not however invalidate any
% other reasons why the document might be covered by the GNU General Public
% License. If you modify this font, you may extend this exception to your
% version of the font, but you are not obligated to do so. If you do not
% wish to do so, delete this exception statement from your version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
% Matthew Skala
% http://ansuz.sooke.bc.ca/
% mskala@ansuz.sooke.bc.ca
%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ecl_run_hamlog_program:-
  argv(all,[_,TStr,GStr|Includes]),
  compile(Includes),
  ensure_dot_final(TStr,TDStr),
  ensure_dot_final(GStr,GDStr),
  open(string(TDStr),read,TF),readvar(TF,T,TBind),close(TF),
  open(string(GDStr),read,GF),readvar(GF,G,GBind),close(GF),
  ecl_match_bindings(TBind,GBind),
  findall(T,G,BU),
  sort(BU,B),
  ecl_write_results(B),
  halt.
ecl_run_hamlog_program:-halt.

ecl_match_bindings([],_):-!.
ecl_match_bindings([[N|V]|T],X):-
  delete([N|V],X,Y),!,ecl_match_bindings(T,Y).
ecl_match_bindings([_|X],Y):-ecl_match_bindings(X,Y).

ecl_write_results([]):-!.
ecl_write_results([H|T]):-
  write(H),nl,
  ecl_write_results(T).

ensure_dot_final(S,S):-append_strings(_,".",S),!.
ensure_dot_final(S,SD):-append_strings(S,".",SD).

atom_chars(Atom,List):-
  var(Atom),!,
  (foreach(Co,CList),foreach(Ch,List) do (
     atom_string(Ch,Tmp),
     string_list(Tmp,[Co])
  )),
  string_list(String,CList),
  atom_string(Atom,String).
atom_chars(Atom,List):-
  atom(Atom),
  atom_string(Atom,String),
  string_list(String,CList),
  (foreach(Co,CList),foreach(Ch,List) do (
     string_list(Tmp,[Co]),
     atom_string(Ch,Tmp)
  )).

ecl_atoi('0',0):-!.
ecl_atoi('1',1):-!.
ecl_atoi('2',2):-!.
ecl_atoi('3',3):-!.
ecl_atoi('4',4):-!.
ecl_atoi('5',5):-!.
ecl_atoi('6',6):-!.
ecl_atoi('7',7):-!.
ecl_atoi('8',8):-!.
ecl_atoi('9',9):-!.
ecl_atoi(X,X).

atom_final(AZ,A,Z):-
  atomic(AZ),!,
  atom_chars(AZ,AZL),
  append(AL,[Y],AZL),
  atom_chars(A,AL),
  ecl_atoi(Y,Z).
atom_final(AZ,A,Y):-
  ecl_atoi(Z,Y),
  atom_chars(A,AL),
  append(AL,[Z],AZL),
  atom_chars(AZ,AZL).
