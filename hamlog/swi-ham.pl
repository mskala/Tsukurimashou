%
% Support script for running Hamlog programs in SWI-Prolog
% Copyright (C) 2011  Matthew Skala
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

swi_run_hamlog_program:-
  current_prolog_flag(argv,ARGV),
  swi_trim_argv(ARGV,[TStr,GStr|Includes]),
  load_files(Includes,[silent(true)]),
  atom_to_term(TStr,T,TBind),
  atom_to_term(GStr,G,GBind),
  swi_match_bindings(TBind,GBind),
  findall(T,G,BU),
  sort(BU,B),
  swi_write_results(B),
  halt.
swi_run_hamlog_program:-halt.

swi_trim_argv([--|X],X):-!.
swi_trim_argv([_|X],Y):-swi_trim_argv(X,Y).

swi_match_bindings([],_):-!.
swi_match_bindings([N=V|T],X):-
  select(N=V,X,Y),!,swi_match_bindings(T,Y).
swi_match_bindings([_|X],Y):-swi_match_bindings(X,Y).

swi_write_results([]):-!.
swi_write_results([H|T]):-
  write(H),nl,
  swi_write_results(T).

swi_atoi('0',0):-!.
swi_atoi('1',1):-!.
swi_atoi('2',2):-!.
swi_atoi('3',3):-!.
swi_atoi('4',4):-!.
swi_atoi('5',5):-!.
swi_atoi('6',6):-!.
swi_atoi('7',7):-!.
swi_atoi('8',8):-!.
swi_atoi('9',9):-!.
swi_atoi(X,X).

atom_final(AZ,A,Z):-
  atomic(AZ),!,
  atom_chars(AZ,AZL),
  append(AL,[Y],AZL),
  atom_chars(A,AL),
  swi_atoi(Y,Z).
atom_final(AZ,A,Y):-
  swi_atoi(Z,Y),
  atom_chars(A,AL),
  append(AL,[Z],AZL),
  atom_chars(AZ,AZL).

:-swi_run_hamlog_program.
