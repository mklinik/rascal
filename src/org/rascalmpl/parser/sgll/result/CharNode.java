package org.rascalmpl.parser.sgll.result;

import org.eclipse.imp.pdb.facts.IConstructor;

public class CharNode implements INode{
	private final IConstructor production;
	private final char character;
	
	public CharNode(IConstructor production, char character){
		super();
		
		this.production = production;
		this.character = character;
	}
	
	public void addAlternative(INode[] children){
		throw new UnsupportedOperationException();
	}
	
	public boolean isEpsilon(){
		return false;
	}
	
	public String toString(){
		StringBuilder sb = new StringBuilder();
		
		sb.append("appl(prod(");
		sb.append(production);
		sb.append(')');
		sb.append(',');
		sb.append('[');
		sb.append("char(");
		sb.append(character);
		sb.append(')');
		sb.append(']');
		sb.append(')');
		
		return sb.toString();
	}
}
