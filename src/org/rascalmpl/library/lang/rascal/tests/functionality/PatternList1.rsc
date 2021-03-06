  module lang::rascal::tests::functionality::PatternList1
 
  /*******************************************************************************
   * Copyright (c) 2009-2015 CWI
   * All rights reserved. This program and the accompanying materials
   * are made available under the terms of the Eclipse Public License v1.0
   * which accompanies this distribution, and is available at
   * http://www.eclipse.org/legal/epl-v10.html
   *
   * Contributors:
  
   *   * Jurgen J. Vinju - Jurgen.Vinju@cwi.nl - CWI
   *   * Paul Klint - Paul.Klint@cwi.nl - CWI
   *   * Bert Lisser - Bert.Lisser@cwi.nl - CWI
  *******************************************************************************/
  
  
import List;
  	
public int ModVar42 = 42;
public int ModVar44 = 44;
public list[int] ModVarList_41_42_43 = [41, 42, 43];

test bool matchModuleVar1() = ModVar42 := 42;
test bool matchModuleVar2() = ModVarList_41_42_43 := ModVarList_41_42_43;

// matchList1
  		
test bool matchList1() = !([] := [2]);
test bool matchList2() = !([1] := []);
  
test bool matchList3() = [] := [];
test bool matchList4() = [1] := [1];
test bool matchList5() = [1,2] := [1,2];
  		
test bool matchList6() = !([1] := [2]);
test bool matchList7() = !([1,2] := [1,2,3]);
  
test bool matchList8() = ([int N] := [1]) && (N == 1);
test bool matchList9() = [ _ ] := [1];
  		
test bool matchList10() = ([int N, 2, int M] := [1,2,3]) && (N == 1) && (M==3);
test bool matchList11() = [ _, 2, _] := [1,2,3];
  		
test bool matchList12() = ([int N, 2, N] := [1,2,1]) && (N == 1);
  		
test bool matchList13() = !(([int N, 2, N] := [1,2,3]));
test bool matchList14() = !([int N, 2, N] := [1,2,"a"]);
  		
test bool matchList15() {int N = 1; return ([N, 2, int M] := [1,2,3]) && (N == 1) && (M==3);}
test bool matchList16() {int N = 1; return !([N, 2, int M] := [4,2,3]);}
  		
test bool matchList17() {list[int] L = [3]; return [1,2,*L] := [1,2,3];}
test bool matchList18() {list[int] L = [2, 3]; return [1, *L] := [1,2,3];}
  
test bool matchList19() = [1, [2, 3], 4] := [1, [2, 3], 4];
test bool matchList20() = !([1, [2, 3], 4] := [1, [2, 3, 4], 4]);
  		
test bool matchList21() = ([list[int] L] := [[]]) && (L == []);
test bool matchList22() = ([1, list[int] L] := [1, [2]]) && (L == [2]);
test bool matchList23() = ([1, list[int] L, 10] := [1,[],10]) && (L == []);
test bool matchList24() = ([1, list[int] L, 10] := [1,[2],10]) && (L == [2]);
test bool matchList25() = ([*list[int] L] := []) && (L == []);
test bool matchList26() { list[int] X = []; return ([*int L] := X) && (L == []);} 
test bool matchList27() = ([*int L] := ([1] - [1])) && (L == []);
test bool matchList28() = ([*int L] := [1]) && (L == [1]);
test bool matchList29() = ([*int L] := [1,2]) && (L == [1,2]);
  
test bool matchList30() = ([1, *int L] := [1]) && (L == []);
test bool matchList31() = ([1, *int L] := [1, 2]) && (L == [2]);
test bool matchList32() = ([1, *int L] := [1, 2, 3]) && (L == [2, 3]);
  
test bool matchList33() = ([*int L, 10] := [10]) && (L == []);
test bool matchList34() = ([*int L, 10] := [1,10]) && (L == [1]);
test bool matchList35() = ([*int L, 10] := [1,2,10]) && (L == [1,2]);
  
test bool matchList36() = ([1, *int L, 10] := [1,10]) && (L == []);
test bool matchList37() = ([1, *int L, 10] := [1,2,10]) && (L == [2]);
test bool matchList38() = ([1, *int L, 10, *int M, 20] := [1,10,20]) && (L == []) && (M == []);
test bool matchList39() = ([1, *int L, 10, *int M, 20] := [1,2,10,20]) && (L == [2]) && (M == []);
test bool matchList40() = ([1, *int L, 10, *int M, 20] := [1,2,10,3,20]) && (L == [2]) && (M==[3]);
test bool matchList41() = ([1, *int L, 10, *int M, 20] := [1,2,3,10,4,5,20]) && (L == [2,3]) && (M==[4,5]);
  		
test bool matchList42() = ([1, *int L, 10, *L, 20] := [1,2,3,10,2,3,20]) && (L == [2,3]);
test bool matchList43() = !(([1,*int L, 10, *L, 20] := [1,2,3,10,2,4,20]));
  		
test bool matchList44() = [*int _] := [];
test bool matchList45() = [*int _] := [1];
test bool matchList46() = [*int _] := [1,2];
test bool matchList47() = ([1, *int _, 10, *int _, 20] := [1,2,10,20]);

test bool matchList48() {
	res = [];
 	for([*int a, *int b, *int c, *int d] := [1,2,3,4,5,6]) { res = res + [[a,b,c,d]]; }
 	return res ==
		[
		  [
		    [],
		    [],
		    [],
		    [1,2,3,4,5,6]
		  ],
		  [
		    [],
		    [],
		    [1],
		    [2,3,4,5,6]
		  ],
		  [
		    [],
		    [],
		    [1,2],
		    [3,4,5,6]
		  ],
		  [
		    [],
		    [],
		    [1,2,3],
		    [4,5,6]
		  ],
		  [
		    [],
		    [],
		    [1,2,3,4],
		    [5,6]
		  ],
		  [
		    [],
		    [],
		    [1,2,3,4,5],
		    [6]
		  ],
		  [
		    [],
		    [],
		    [1,2,3,4,5,6],
		    []
		  ],
		  [
		    [],
		    [1],
		    [],
		    [2,3,4,5,6]
		  ],
		  [
		    [],
		    [1],
		    [2],
		    [3,4,5,6]
		  ],
		  [
		    [],
		    [1],
		    [2,3],
		    [4,5,6]
		  ],
		  [
		    [],
		    [1],
		    [2,3,4],
		    [5,6]
		  ],
		  [
		    [],
		    [1],
		    [2,3,4,5],
		    [6]
		  ],
		  [
		    [],
		    [1],
		    [2,3,4,5,6],
		    []
		  ],
		  [
		    [],
		    [1,2],
		    [],
		    [3,4,5,6]
		  ],
		  [
		    [],
		    [1,2],
		    [3],
		    [4,5,6]
		  ],
		  [
		    [],
		    [1,2],
		    [3,4],
		    [5,6]
		  ],
		  [
		    [],
		    [1,2],
		    [3,4,5],
		    [6]
		  ],
		  [
		    [],
		    [1,2],
		    [3,4,5,6],
		    []
		  ],
		  [
		    [],
		    [1,2,3],
		    [],
		    [4,5,6]
		  ],
		  [
		    [],
		    [1,2,3],
		    [4],
		    [5,6]
		  ],
		  [
		    [],
		    [1,2,3],
		    [4,5],
		    [6]
		  ],
		  [
		    [],
		    [1,2,3],
		    [4,5,6],
		    []
		  ],
		  [
		    [],
		    [1,2,3,4],
		    [],
		    [5,6]
		  ],
		  [
		    [],
		    [1,2,3,4],
		    [5],
		    [6]
		  ],
		  [
		    [],
		    [1,2,3,4],
		    [5,6],
		    []
		  ],
		  [
		    [],
		    [1,2,3,4,5],
		    [],
		    [6]
		  ],
		  [
		    [],
		    [1,2,3,4,5],
		    [6],
		    []
		  ],
		  [
		    [],
		    [1,2,3,4,5,6],
		    [],
		    []
		  ],
		  [
		    [1],
		    [],
		    [],
		    [2,3,4,5,6]
		  ],
		  [
		    [1],
		    [],
		    [2],
		    [3,4,5,6]
		  ],
		  [
		    [1],
		    [],
		    [2,3],
		    [4,5,6]
		  ],
		  [
		    [1],
		    [],
		    [2,3,4],
		    [5,6]
		  ],
		  [
		    [1],
		    [],
		    [2,3,4,5],
		    [6]
		  ],
		  [
		    [1],
		    [],
		    [2,3,4,5,6],
		    []
		  ],
		  [
		    [1],
		    [2],
		    [],
		    [3,4,5,6]
		  ],
		  [
		    [1],
		    [2],
		    [3],
		    [4,5,6]
		  ],
		  [
		    [1],
		    [2],
		    [3,4],
		    [5,6]
		  ],
		  [
		    [1],
		    [2],
		    [3,4,5],
		    [6]
		  ],
		  [
		    [1],
		    [2],
		    [3,4,5,6],
		    []
		  ],
		  [
		    [1],
		    [2,3],
		    [],
		    [4,5,6]
		  ],
		  [
		    [1],
		    [2,3],
		    [4],
		    [5,6]
		  ],
		  [
		    [1],
		    [2,3],
		    [4,5],
		    [6]
		  ],
		  [
		    [1],
		    [2,3],
		    [4,5,6],
		    []
		  ],
		  [
		    [1],
		    [2,3,4],
		    [],
		    [5,6]
		  ],
		  [
		    [1],
		    [2,3,4],
		    [5],
		    [6]
		  ],
		  [
		    [1],
		    [2,3,4],
		    [5,6],
		    []
		  ],
		  [
		    [1],
		    [2,3,4,5],
		    [],
		    [6]
		  ],
		  [
		    [1],
		    [2,3,4,5],
		    [6],
		    []
		  ],
		  [
		    [1],
		    [2,3,4,5,6],
		    [],
		    []
		  ],
		  [
		    [1,2],
		    [],
		    [],
		    [3,4,5,6]
		  ],
		  [
		    [1,2],
		    [],
		    [3],
		    [4,5,6]
		  ],
		  [
		    [1,2],
		    [],
		    [3,4],
		    [5,6]
		  ],
		  [
		    [1,2],
		    [],
		    [3,4,5],
		    [6]
		  ],
		  [
		    [1,2],
		    [],
		    [3,4,5,6],
		    []
		  ],
		  [
		    [1,2],
		    [3],
		    [],
		    [4,5,6]
		  ],
		  [
		    [1,2],
		    [3],
		    [4],
		    [5,6]
		  ],
		  [
		    [1,2],
		    [3],
		    [4,5],
		    [6]
		  ],
		  [
		    [1,2],
		    [3],
		    [4,5,6],
		    []
		  ],
		  [
		    [1,2],
		    [3,4],
		    [],
		    [5,6]
		  ],
		  [
		    [1,2],
		    [3,4],
		    [5],
		    [6]
		  ],
		  [
		    [1,2],
		    [3,4],
		    [5,6],
		    []
		  ],
		  [
		    [1,2],
		    [3,4,5],
		    [],
		    [6]
		  ],
		  [
		    [1,2],
		    [3,4,5],
		    [6],
		    []
		  ],
		  [
		    [1,2],
		    [3,4,5,6],
		    [],
		    []
		  ],
		  [
		    [1,2,3],
		    [],
		    [],
		    [4,5,6]
		  ],
		  [
		    [1,2,3],
		    [],
		    [4],
		    [5,6]
		  ],
		  [
		    [1,2,3],
		    [],
		    [4,5],
		    [6]
		  ],
		  [
		    [1,2,3],
		    [],
		    [4,5,6],
		    []
		  ],
		  [
		    [1,2,3],
		    [4],
		    [],
		    [5,6]
		  ],
		  [
		    [1,2,3],
		    [4],
		    [5],
		    [6]
		  ],
		  [
		    [1,2,3],
		    [4],
		    [5,6],
		    []
		  ],
		  [
		    [1,2,3],
		    [4,5],
		    [],
		    [6]
		  ],
		  [
		    [1,2,3],
		    [4,5],
		    [6],
		    []
		  ],
		  [
		    [1,2,3],
		    [4,5,6],
		    [],
		    []
		  ],
		  [
		    [1,2,3,4],
		    [],
		    [],
		    [5,6]
		  ],
		  [
		    [1,2,3,4],
		    [],
		    [5],
		    [6]
		  ],
		  [
		    [1,2,3,4],
		    [],
		    [5,6],
		    []
		  ],
		  [
		    [1,2,3,4],
		    [5],
		    [],
		    [6]
		  ],
		  [
		    [1,2,3,4],
		    [5],
		    [6],
		    []
		  ],
		  [
		    [1,2,3,4],
		    [5,6],
		    [],
		    []
		  ],
		  [
		    [1,2,3,4,5],
		    [],
		    [],
		    [6]
		  ],
		  [
		    [1,2,3,4,5],
		    [],
		    [6],
		    []
		  ],
		  [
		    [1,2,3,4,5],
		    [6],
		    [],
		    []
		  ],
		  [
		    [1,2,3,4,5,6],
		    [],
		    [],
		    []
		  ]
		];
}		
  		
@ignore{investigate} test bool matchList() {([1, list[int] L, [10, list[int] M, 100], list[int] N, 1000] := [1, [10,100],1000]);}
  		
test bool matchListFalse1() {list[value] l = [1,2,3]; return [1, str S, 2] !:= l; }

test bool matchListModuleVar1() = [ModVar42] := [42];
test bool matchListModuleVar2() = [*ModVarList_41_42_43] := ModVarList_41_42_43;
test bool matchListModuleVar3() = [ModVar42, *ModVarList_41_42_43] := [ModVar42, *ModVarList_41_42_43];
@ignoreInterpreter{Seems to be a bug in the interpreter}
test bool matchListModuleVar4() = [ModVar42, ModVarList_41_42_43] := [ModVar42, ModVarList_41_42_43];

//	matchNestedList

test bool matchNestedList1() = !([] := [[2]]);
  
test bool matchNestedList3() = [] := [];
test bool matchNestedList4() = [[1]] := [[1]];
test bool matchNestedList5() = [[1,2]] := [[1,2]];
  		
test bool matchNestedList6() = !([[1]] := [[2]]);
test bool matchNestedList7() = !([[1,2]] := [[1,2,3]]);
  		
test bool matchNestedList8() = [*list[int] L] := [];
  		
test bool matchNestedList9() = [*list[int] L] := [[1]];
test bool matchNestedList10() = [*list[int] L] := [[1,2]];
  		
test bool matchNestedList11() = ([[1], *list[int] L, [6,7,8]] := [[1],[2,3],[4,5],[6,7,8]]) && (L == [[2,3],[4,5]]);
test bool matchNestedList12() = !(([[1], *list[int] L, [6,7,8]] := [[1],[2,3],[4,5],[8]]) && (L == [[2,3],[4,5]]));
  		
test bool matchNestedList13() = ([[1], *list[int] L, [6,7,8], *L] := [[1],[2,3],[4,5],[6,7,8],[2,3],[4,5]]) && (L == [[2,3],[4,5]]);

// matchExternalListVars

test bool matchExternalListVars1() {int n;  return n := 3 && n == 3; }

/*TODO:fails*/
@Ignore
test bool matchExternalListVars2() {list[int] L; return ([1, *L, 4, 5] := [1, 2, 3, 4, 5] && L == [2, 3]);}

//	matchListMultiVars

test bool matchListMultiVars1() = [1, L*, 4, 5] := [1, 2, 3, 4, 5] && L == [2, 3];
test bool matchListMultiVars2() = [1, _*, 4, 5] := [1, 2, 3, 4, 5];
test bool matchListMultiVars3() = [1, L*, 4, *L, 5] := [1, 2, 3, 4, 2, 3, 5] && L == [2, 3];
  	
//	matchListSpliceVars

test bool matchListSpliceVars1() = [1, *L, 4, 5] := [1, 2, 3, 4, 5] && L == [2, 3];
test bool matchListSpliceVars2() = [1, * int L, 4, 5] := [1, 2, 3, 4, 5] && L == [2, 3];
test bool matchListSpliceVars3() = [1, *_, 4, 5] := [1, 2, 3, 4, 5];
test bool matchListSpliceVars4() = [1, * int _, 4, 5] := [1, 2, 3, 4, 5];
test bool matchListSpliceVars5() = [1, *L, 4, *L, 5] := [1, 2, 3, 4, 2, 3, 5] && L == [2, 3];
test bool matchListSpliceVars6() = [1, * int L, 4, *L, 5] := [1, 2, 3, 4, 2, 3, 5] && L == [2, 3];
  
//	matchListHasOrderedElement

test bool matchListHasOrderedElement1() = hasOrderedElement([]) == false;
test bool matchListHasOrderedElement2() = hasOrderedElement([1]) == false;
test bool matchListHasOrderedElement3() = hasOrderedElement([1,2]) == false;
test bool matchListHasOrderedElement4() = hasOrderedElement([1,2,1]) == true;
test bool matchListHasOrderedElement5() = hasOrderedElement([1,2,3,4,3,2,1]) == true;
  	
//	matchListHasDuplicateElement

test bool matchListHasDuplicateElement1() = hasDuplicateElement([]) == false;
test bool matchListHasDuplicateElement2() = hasDuplicateElement([1]) == false;
test bool matchListHasDuplicateElement3() = hasDuplicateElement([1,2]) == false;
test bool matchListHasDuplicateElement4() = hasDuplicateElement([1,1]) == true;
test bool matchListHasDuplicateElement5() = hasDuplicateElement([1,2,3]) == false;
test bool matchListHasDuplicateElement6() = hasDuplicateElement([1,2,3,1]) == true;
test bool matchListHasDuplicateElement7() = hasDuplicateElement([1,2,3,2]) == true;
test bool matchListHasDuplicateElement8() = hasDuplicateElement([1,2,3,3]) == true;
  
//	matchListIsDuo1

test bool matchListIsDuo1() = isDuo1([]) == true;
test bool matchListIsDuo2() = isDuo1([1]) == false;
test bool matchListIsDuo3() = isDuo1([1,1]) == true;
test bool matchListIsDuo4() = isDuo1([1,2]) == false;
test bool matchListIsDuo5() = isDuo1([1,2, 1]) == false;
test bool matchListIsDuo6() = isDuo1([1,2, 1,2]) == true;
test bool matchListIsDuo7() = isDuo1([1,2,3, 1,2]) == false;
test bool matchListIsDuo8() = isDuo1([1,2,3, 1,2, 3]) == true;
  		
//	matchListIsDuo2

test bool matchListIsDuo9() = isDuo2([]) == true;
test bool matchListIsDuo10() = isDuo2([1]) == false;
test bool matchListIsDuo11() = isDuo2([1,1]) == true;
test bool matchListIsDuo12() = isDuo2([1,2]) == false;
test bool matchListIsDuo13() = isDuo2([1,2, 1]) == false;
test bool matchListIsDuo14() = isDuo2([1,2, 1,2]) == true;
test bool matchListIsDuo15() = isDuo2([1,2,3, 1,2]) == false;
test bool matchListIsDuo16() = isDuo2([1,2,3, 1,2, 3]) == true;
  	
//	matchListIsDuo3

test bool matchListIsDuo17() = isDuo3([]) == true;
test bool matchListIsDuo18() = isDuo3([1]) == false;
test bool matchListIsDuo19() = isDuo3([1,1]) == true;
test bool matchListIsDuo20() = isDuo3([1,2]) == false;
test bool matchListIsDuo21() = isDuo3([1,2, 1]) == false;
test bool matchListIsDuo22() = isDuo3([1,2, 1,2]) == true;
test bool matchListIsDuo23() = isDuo3([1,2,3, 1,2]) == false;
test bool matchListIsDuo24() = isDuo3([1,2,3, 1,2, 3]) == true;
  
// matchListIsTrio1

test bool matchListIsTrio1() = isTrio1([]) == true;
test bool matchListIsTrio2() = isTrio1([1]) == false;
test bool matchListIsTrio3() = isTrio1([1,1]) == false;
test bool matchListIsTrio4() = isTrio1([1,1,1]) == true;
test bool matchListIsTrio5() = isTrio1([2,1,1]) == false;
test bool matchListIsTrio6() = isTrio1([1,2,1]) == false;
test bool matchListIsTrio7() = isTrio1([1,1,2]) == false;
test bool matchListIsTrio8() = isTrio1([1,2, 1,2, 1,2]) == true;
  	
//	matchListIsTrio2

test bool matchListIsTrio9() = isTrio2([]) == true;
test bool matchListIsTrio10() = isTrio2([1]) == false;
test bool matchListIsTrio11() = isTrio2([1,1]) == false;
test bool matchListIsTrio12() = isTrio2([1,1,1]) == true;
test bool matchListIsTrio13() = isTrio2([2,1,1]) == false;
test bool matchListIsTrio14() = isTrio2([1,2,1]) == false;
test bool matchListIsTrio15() = isTrio2([1,1,2]) == false;
test bool matchListIsTrio16() = isTrio2([1,2, 1,2, 1,2]) == true;
  	
// 	matchListIsTrio3

test bool matchListIsTrio17() = isTrio3([]) == true;
test bool matchListIsTrio18() = isTrio3([1]) == false;
test bool matchListIsTrio19() = isTrio3([1,1]) == false;
test bool matchListIsTrio20() = isTrio3([1,1,1]) == true;
test bool matchListIsTrio21() = isTrio3([2,1,1]) == false;
test bool matchListIsTrio22() = isTrio3([1,2,1]) == false;
test bool matchListIsTrio23() = isTrio3([1,1,2]) == false;
test bool matchListIsTrio24() = isTrio3([1,2, 1,2, 1,2]) == true;
 
 
data Bool = and(Bool, Bool) | t();
data Prop = or(Prop, Prop) | f();
  
// matchLiteral
  
test bool matchListLiteral1() = true     := true;
test bool matchListLiteral2() = !(true    := false);
test bool matchListLiteral3() = true     !:= false;
  
test bool matchListLiteral4() = 1        := 1;
test bool matchListLiteral5() = !(2       := 1);
test bool matchListLiteral6() = 2        !:= 1;
  
test bool matchListLiteral7() = 1.5      := 1.5;
test bool matchListLiteral8() = !(2.5     := 1.5);
test bool matchListLiteral9() = 2.5      !:= 1.5;
  		
test bool matchListLiteral10() = !(1.0     := 1.5);
test bool matchListLiteral11() = 1.0      !:= 1.5;
  
test bool matchListLiteral12()=  "abc"  := "abc";
test bool matchListLiteral13() = "def" !:= "abc";
test bool matchListLiteral14()=  "def" !:= "abc";
  
//	matchADT
  
test bool matchADT1() = f(1)                   := f(1);
test bool matchADT2() = f(1, g("abc"), true) := f(1, g("abc"), true);
test bool matchADT3() = g("abc") !:= f(1);
test bool matchADT4() = f(1, 2)!:= f(1);
test bool matchADT5() = f(1, 2)!:= f(1);	
test bool matchADT6() = f(_):= f(1);
test bool matchADT7() = f(_,_):= f(1,2);
test bool matchADT8() = f(_,_,_):= f(1,2.5,true);
  
//	matchADTWithKeywords
  		
test bool matchADTwithKeywords1() = f1(1)                   := f1(1);
test bool matchADTwithKeywords2() = f1(1, M=10)             := f1(1);
test bool matchADTwithKeywords3() = f1(1, B=false, M=10)    := f1(1);
test bool matchADTwithKeywords4() = f1(1, M=20)             := f1(1, B=false, M=20);
  		
test bool matchADTwithKeywords5() = f1(1, M=X)             := f1(1, B=false, M=20) && X == 20;
  	
//	matchNode
  		
test bool matchNode1() ="f"(1)                := "f"(1);
test bool matchNode2() ="f"(1, "g"("abc"), true) := "f"(1, "g"("abc"), true);
test bool matchNode3() = "g"(1)               !:= "f"(1);
test bool matchNode4() = "g"(1)                !:= "f"(1);
test bool matchNode5() = "f"(1, 2)            !:= "f"(1);
test bool matchNode6() = "f"(1, 2)             !:= "f"(1);
  		
test bool matchNode7() = "f"(_)                := "f"(1);
test bool matchNode8() = "f"(_,_)              := "f"(1,2);
test bool matchNode9() = "f"(_,_,_)            := "f"(1,2.5,true);
test bool matchNode10() = "f"(1,_,3)            := "f"(1,2,3);
test bool matchNode11() = "f"(_,2,_)            := "f"(1,2,3);
  
// matchNodeWithKeywords
  
test bool matchNodeWithKeywords1() ="f1"(1)                := "f1"(1);
  		
test bool matchNodeWithKeywords2() ="f1"(1)               !:= "f1"(2);
test bool matchNodeWithKeywords3() ="f1"(1, M=10)          := "f1"(1, M=10);
test bool matchNodeWithKeywords4() ="f1"(1)                := "f1"(1, M=10);
test bool matchNodeWithKeywords5() ="f1"(1, M=10)         !:= "f1"(1, M=20);
test bool matchNodeWithKeywords6() ="f1"(1, M=10)         !:= "f1"(1);
test bool matchNodeWithKeywords7() ="f1"(1, M=10)         !:= "f1"(1, B=false);
  		
test bool matchNodeWithKeywords8() ="f1"(1, B=false, M=10) := "f1"(1, M=10, B=false);
test bool matchNodeWithKeywords9() ="f1"(1, M=20, B=false) := "f1"(1, B=false, M=20);
test bool matchNodeWithKeywords10() ="f1"(1, M=20)          := "f1"(1, B=false, M=20);
test bool matchNodeWithKeywords11() ="f1"(1)                := "f1"(1, B=false, M=20);
test bool matchNodeWithKeywords12() ="f1"(1, B=false, M=10) !:= "f1"(1, M=20, B=false);
test bool matchNodeWithKeywords13() ="f1"(1, M=10, B=false)!:= "f1"(1, B=false, M=20);
test bool matchNodeWithKeywords14() ="f1"(1, M=_, B=false)  := "f1"(1, B=false, M=20);
test bool matchNodeWithKeywords15() ="f1"(_, M=20, B=false) := "f1"(1, B=false, M=20);
  		
test bool matchNodeWithKeywords16() = "f1"(1, M=X) := "f1"(1, B=false, M=20) && X == 20;

  	
// matchListSetVariableScopes
  		
test bool matchListSetVariableScopes1() = {PAIR D, pair(D, b1())} := {pair(a1(),b1()), a1()} && D == a1();
test bool matchListSetVariableScopes2() = {PAIR D, pair(D, b1())} !:= {pair(a1(),b1()), c1()};
  		
test bool matchListSetVariableScopes3() = {pair(PAIR D, b1()), D} := {pair(a1(),b1()), a1()} && D == a1();
test bool matchListSetVariableScopes4() = {pair(PAIR D, b1()), D} !:= {pair(a1(),b1()), c1()};
  		
test bool matchListSetVariableScopes5() = {pair(s1(set[PAIR] S1), c1()), *S1} :=  {pair(s1({a1(), b1()}), c1()), a1(), b1()} && S1 == {a1(), b1()};
test bool matchListSetVariableScopes6() = {pair(s1(set[PAIR] S1), c1()), *S1} !:= {pair(s1({a1(), b1()}), c1()), a1(), d1()};
  		
test bool matchListSetVariableScopes7() {list[PAIR] L1 = [a1(), b1()]; return [*L1, c1()] := [a1(), b1(), c1()];}
test bool matchListSetVariableScopes8() {list[PAIR] L1 = [a1(), b1()]; return [*L1, c1()] !:= [a1(), d1(), c1()];}
  		
test bool matchListSetVariableScopes9() = [pair(l1(list[PAIR] L1), c1()), *L1] := [pair(l1([a1(), b1()]), c1()), a1(), b1()];
test bool matchListSetVariableScopes10() = [pair(l1(list[PAIR] L1), c1()), *L1] !:= [pair(l1([a1(), b1()]), c1()), a1(), d1()];
  		
test bool matchListSetVariableScopes11() = [pair(PAIR L1, b1()), L1] := [pair(a1(), b1()), a1()];
test bool matchListSetVariableScopes12() = [pair(PAIR L1, b1()), L1] !:= [pair(a1(), b1()), d1()];
  
// matchSetExternalVar
  
test bool matchSetExternalVar1() {set[int] S; return ({1, *S, 2} := {1,2,3} && S == {3});}
  
//	matchTuple
  
test bool matchTuple1() = <1> := <1>;
test bool matchTuple2() = <1, "abc">  := <1, "abc">;
test bool matchTuple3() = !(<2>  := <1>);
test bool matchTuple4() = <2> !:= <1>;
  		
test bool matchTuple5() = <1, "abc"> !:= <1, "def">;
test bool matchTuple6() = <1, "abc"> !:= <1, "def">;
  		
test bool matchTuple7() = <_, "abc">  := <1, "abc">;
test bool matchTuple8() = <1, _>        := <1, "abc">;
test bool matchTuple9() = <_, _>        := <1, "abc">;
  	
//	matchTupleExternalVar
 
test bool matchTupleExternalVar1() {tuple[int,int] T; return T := <1,2> && T[0] == 1 && T[1] == 2;}
  
//	matchVariable

test bool matchVariable1() = (n1 := 1) && (n1 == 1);
test bool matchVariable2() {int n2 = 1;return  (n2 := 1) && (n2 == 1);}
test bool matchVariable3()  {int n3 = 1; return (n3 !:= 2) && (n3 == 1);}
  
test bool matchVariable4() = (f(n5) := f(1)) && (n5 == 1);
test bool matchVariable5() {int n6 = 1; return (f(n6) := f(1)) && (n6 == 1);}
  		
test bool matchVariable6() = f(_) := f(1);
  	
//	matchTypedVariableBecomes

test bool matchTypedVariableBecomes1() = int N : 3 := 3 && N == 3;
test bool matchTypedVariableBecomes2() = list[int] L1 : [int N, *int L2, int M] := [1,2,3] && L1 == [1,2,3] && N == 1 && L2 == [2] && M == 3;
test bool matchTypedVariableBecomes3() = [1, list[int] L: [int N], 2] := [1,[2],2] && L == [2];
test bool matchTypedVariableBecomes4() = [1, list[int] L1: [*int L2, int N], 5] := [1,[2,3,4],5] && L1 == [2,3,4] && L2==[2,3] && N ==4;
test bool matchTypedVariableBecomes5() = [1, list[int] L1: [*int L2, int N], L1] := [1,[2,3,4],[2,3,4]] && L1 == [2,3,4] && L2==[2,3] && N ==4;
  	
//	matchVariableBecomes

test bool matchVariableBecomes1() = N : 3 := 3 && N == 3;
test bool matchVariableBecomes2() = L1 : [int N, *int L2, int M] := [1,2,3] && L1 == [1,2,3] && N == 1 && L2 == [2] && M == 3;
test bool matchVariableBecomes3() = [1, L: [int N], 2] := [1,[2],2] && L == [2];
test bool matchVariableBecomes4() = [1, L1: [*int L2, int N], 5] := [1,[2,3,4],5] && L1 == [2,3,4] && L2==[2,3] && N ==4;
test bool matchVariableBecomes5() = [1, L1: [*int L2, int N], L1] := [1,[2,3,4],[2,3,4]] && L1 == [2,3,4] && L2==[2,3] && N ==4;
  
// variableBecomesEquality

@IgnoreCompiler{TODO: fails, reason unknown}        
test bool matchVariableBecomesEquality1() {int N = 5; return N : 3 !:= 3 && N != 3;}

test bool matchVariableBecomesEquality2() {int N = 3; return N : 3 := 3 && N == 3;}
  		
@ignoreCompiler{FIX:Typechecker canot determine pattern type}
test bool doubleVariableBecomes1() = !(([N : 3, N : 4] := [3,4]) && N == 3);

@ignoreCompiler{FIX: Typechecker canot determine pattern type}
test bool doubleVariableBecomes2() = [N : 3, N : 3] := [3,3] && N == 3;
  	
// antiPattern

test bool antiPattern1() = !4 := 3;
test bool antiPattern2() = (!(!3 := 3));	
test bool antiPattern3() = ![1,2,3] := [1,2,4];
test bool antiPattern4() = !(![1,2,3] := [1,2,3]);
  	

// Match in loops

test bool matchInLoop1(){
	lst = [1, 2, 3];
	cnt = 0;
	for(int x <- lst){
		switch(x){
			case n: cnt += n;
		}
	}
	return cnt == (0 | it + x | x <- lst);
}

test bool matchInLoop2(){
	lst = [1, 2, 3];
	cnt = 0;
	i = 0;
	while(i < size(lst)){
		switch(lst[i]){
			case n: cnt += n;
		}
		i += 1;
	}
	return cnt == (0 | it + x | x <- lst);
}

// listCount1
 
   test bool listCount1(list[int] L){
	   int cnt(list[int] L){
	    int count = 0;
	    while ([int N, *int Ns] := L) { 
	           count = count + 1;
	           L = tail(L);
	    }
	    return count;
	  }
	  return cnt(L) == size(L);
  }
  
 // listCount2
 
 test bool listCount2(list[int] L){
	  int cnt(list[int] L){
	    int count = 0;
	    while ([int N, *int _] := L) {
	           count = count + 1;
	           L = tail(L);
	    }
	    return count;
	  }
 	  return  cnt(L) == size(L);
}

// listCount3
  
  test bool listCount3(list[int] L){  	
  
      int cnt(list[int] L){
       int count = 0;
        while ([_, *int _] := L) {
               count = count + 1;
               L = tail(L);
        }
        return count;
      }

	return cnt(L) == size(L);
  	}
  	
 
  data F = f(int N) | f(int N, int M) | f(int N, value f, bool B) | g(str S);
  data F1 = f1(int N, int M = 10, bool B = false) | f1(str S);
  data PAIR = a1() | b1() | c1() | d1() | pair(PAIR q1, PAIR q2) | s1(set[PAIR] S) | l1(list[PAIR] L);
  data Bool = btrue() | bfalse() | band(Bool left, Bool right) | bor(Bool left, Bool right);
  
  public bool hasOrderedElement(list[int] L)
  {
     switch(L){
     
     case [*int L1, int I, *int L2, int J, *int L3]: {
          if(I > J){
          	return true;
          } else {
          	fail;
          }
          }
     }
     return false;
  }
  
  
  public bool hasDuplicateElement(list[int] L)
  {
  	switch(L){
  	
  	case [*int L1, int I, *int L2, int J, *int L3]:
  		if(I == J){
  			return true;
  		} else {
  			fail;
  		}
  	default:
  		return false;
      }
  }
  
  public bool isDuo1(list[int] L)
  {
  	switch(L){
  	case [*int L1, *int L2]:
  		if(L1 == L2){
  			return true;
  		} else {
  			fail;
  		}
  	default:
  		return false;
      }
  }
  
  public bool isDuo2(list[int] L)
  {
  	switch(L){
  	case [*int L1, *L1]:
  			return true;
  	default:
  		return false;
      }
  }
  
  public bool isDuo3(list[int] L)
  {
      return [*int L1, *L1] := L;
  }
  
  public bool isTrio1(list[int] L)
  {
  	switch(L){
  	case [*int L1, *int L2, *int L3]:
  		if((L1 == L2) && (L2 == L3)){
  			return true;
  		} else {
  			fail;
  		}
  	default:
  		return false;
      }
  }
  
  public bool isTrio2(list[int] L)
  {
  	switch(L){
  	case [*int L1, *L1, *L1]:
  		return true;
  	default:
  		return false;
      }
  }
  
  public bool isTrio3(list[int] L)
  {
      return [*int L1, *L1, *L1] := L;
  }