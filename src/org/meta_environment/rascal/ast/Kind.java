package org.meta_environment.rascal.ast; 
import org.eclipse.imp.pdb.facts.INode; 
public abstract class Kind extends AbstractAST { 
  public boolean isModule() { return false; }
static public class Module extends Kind {
/* "module" -> Kind {cons("Module")} */
	private Module() { }
	/*package*/ Module(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindModule(this);
	}

	public boolean isModule() { return true; }	
}
static public class Ambiguity extends Kind {
  private final java.util.List<org.meta_environment.rascal.ast.Kind> alternatives;
  public Ambiguity(INode node, java.util.List<org.meta_environment.rascal.ast.Kind> alternatives) {
	this.alternatives = java.util.Collections.unmodifiableList(alternatives);
         this.node = node;
  }
  public java.util.List<org.meta_environment.rascal.ast.Kind> getAlternatives() {
	return alternatives;
  }
  
  public <T> T accept(IASTVisitor<T> v) {
     return v.visitKindAmbiguity(this);
  }
} 
public boolean isFunction() { return false; }
static public class Function extends Kind {
/* "function" -> Kind {cons("Function")} */
	private Function() { }
	/*package*/ Function(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindFunction(this);
	}

	public boolean isFunction() { return true; }	
} public abstract <T> T accept(IASTVisitor<T> visitor); public boolean isVariable() { return false; }
static public class Variable extends Kind {
/* "variable" -> Kind {cons("Variable")} */
	private Variable() { }
	/*package*/ Variable(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindVariable(this);
	}

	public boolean isVariable() { return true; }	
} 
public boolean isData() { return false; }
static public class Data extends Kind {
/* "data" -> Kind {cons("Data")} */
	private Data() { }
	/*package*/ Data(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindData(this);
	}

	public boolean isData() { return true; }	
} 
public boolean isView() { return false; }
static public class View extends Kind {
/* "view" -> Kind {cons("View")} */
	private View() { }
	/*package*/ View(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindView(this);
	}

	public boolean isView() { return true; }	
} 
public boolean isAlias() { return false; }
static public class Alias extends Kind {
/* "alias" -> Kind {cons("Alias")} */
	private Alias() { }
	/*package*/ Alias(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindAlias(this);
	}

	public boolean isAlias() { return true; }	
} 
public boolean isAnno() { return false; }
static public class Anno extends Kind {
/* "anno" -> Kind {cons("Anno")} */
	private Anno() { }
	/*package*/ Anno(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindAnno(this);
	}

	public boolean isAnno() { return true; }	
} 
public boolean isTag() { return false; }
static public class Tag extends Kind {
/* "tag" -> Kind {cons("Tag")} */
	private Tag() { }
	/*package*/ Tag(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindTag(this);
	}

	public boolean isTag() { return true; }	
} 
public boolean isAll() { return false; }
static public class All extends Kind {
/* "all" -> Kind {cons("All")} */
	private All() { }
	/*package*/ All(INode node) {
		this.node = node;
	}
	public <T> T accept(IASTVisitor<T> visitor) {
		return visitor.visitKindAll(this);
	}

	public boolean isAll() { return true; }	
}
}