package org.rascalmpl.test.parser;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.Reader;

import org.eclipse.imp.pdb.facts.IConstructor;
import org.eclipse.imp.pdb.facts.IValue;
import org.rascalmpl.parser.sgll.SGLL;
import org.rascalmpl.parser.sgll.stack.AbstractStackNode;
import org.rascalmpl.parser.sgll.stack.LiteralStackNode;
import org.rascalmpl.parser.sgll.stack.NonTerminalStackNode;
import org.rascalmpl.values.uptr.Factory;

/*
S ::= AA
A ::= BB
B ::= bb | b
*/
public class Ambiguous4 extends SGLL{
	private final static IConstructor SYMBOL_START_S = vf.constructor(Factory.Symbol_Sort, vf.string("S"));
	private final static IConstructor SYMBOL_A = vf.constructor(Factory.Symbol_Sort, vf.string("A"));
	private final static IConstructor SYMBOL_B = vf.constructor(Factory.Symbol_Sort, vf.string("B"));
	private final static IConstructor SYMBOL_b = vf.constructor(Factory.Symbol_Lit, vf.string("b"));
	private final static IConstructor SYMBOL_bb = vf.constructor(Factory.Symbol_Lit, vf.string("bb"));
	private final static IConstructor SYMBOL_char_b = vf.constructor(Factory.Symbol_CharClass, vf.list(vf.constructor(Factory.CharRange_Single, vf.integer(98))));
	
	private final static IConstructor PROD_S_AA = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_A, SYMBOL_A), SYMBOL_START_S, vf.list(Factory.Attributes));
	private final static IConstructor PROD_A_BB = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_B, SYMBOL_B), SYMBOL_A, vf.list(Factory.Attributes));
	private final static IConstructor PROD_B_b = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_b), SYMBOL_B, vf.list(Factory.Attributes));
	private final static IConstructor PROD_B_bb = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_bb), SYMBOL_B, vf.list(Factory.Attributes));
	private final static IConstructor PROD_b_b = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_char_b), SYMBOL_b, vf.list(Factory.Attributes));
	private final static IConstructor PROD_bb_bb = vf.constructor(Factory.Production_Default, vf.list(SYMBOL_char_b, SYMBOL_char_b), SYMBOL_bb, vf.list(Factory.Attributes));
	
	private final static AbstractStackNode NONTERMINAL_START_S = new NonTerminalStackNode(START_SYMBOL_ID, "S");
	private final static AbstractStackNode NONTERMINAL_A0 = new NonTerminalStackNode(0, "A");
	private final static AbstractStackNode NONTERMINAL_A1 = new NonTerminalStackNode(1, "A");
	private final static AbstractStackNode NONTERMINAL_B2 = new NonTerminalStackNode(2, "B");
	private final static AbstractStackNode NONTERMINAL_B3 = new NonTerminalStackNode(3, "B");
	private final static AbstractStackNode LITERAL_b4 = new LiteralStackNode(4, PROD_b_b, new char[]{'b'});
	private final static AbstractStackNode LITERAL_bb5 = new LiteralStackNode(5, PROD_bb_bb, new char[]{'b','b'});
	
	public Ambiguous4(){
		super();
	}
	
	public void S(){
		expect(PROD_S_AA, NONTERMINAL_A0, NONTERMINAL_A1);
	}
	
	public void A(){
		expect(PROD_A_BB, NONTERMINAL_B2, NONTERMINAL_B3);
	}
	
	public void B(){
		expect(PROD_B_b, LITERAL_b4);
		
		expect(PROD_B_bb, LITERAL_bb5);
	}
	
	public IValue parse(IConstructor start, char[] input){
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, File inputFile) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, InputStream in) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, Reader in) throws IOException{
		throw new UnsupportedOperationException();
	}
	
	public IValue parse(IConstructor start, String input){
		throw new UnsupportedOperationException();
	}
	
	public static void main(String[] args){
		Ambiguous4 a4 = new Ambiguous4();
		IValue result = a4.parse(NONTERMINAL_START_S, "bbbbbb".toCharArray());
		System.out.println(result);
		
		System.out.println("[S(A(B(bb),B(bb)),A(B(b),B(b))),S(A(B(b),B(b)),A(B(bb),B(bb))),S([A(B(b),B(bb)),A(B(bb),B(b))],[A(B(b),B(bb)),A(B(bb),B(b))])] <- good");
	}
}
