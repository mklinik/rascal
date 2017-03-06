/*******************************************************************************
 * Copyright (c) 2009-2013 CWI
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
*******************************************************************************/
package org.rascalmpl.library.analysis.linearprogramming;

//This code was generated by Rascal API gen
import java.util.ArrayList;

import org.apache.commons.math.optimization.GoalType;
import org.apache.commons.math.optimization.RealPointValuePair;
import org.apache.commons.math.optimization.linear.LinearConstraint;
import org.apache.commons.math.optimization.linear.LinearObjectiveFunction;
import org.apache.commons.math.optimization.linear.Relationship;
import org.apache.commons.math.optimization.linear.SimplexSolver;

import io.usethesource.vallang.IBool;
import io.usethesource.vallang.IConstructor;
import io.usethesource.vallang.IInteger;
import io.usethesource.vallang.IList;
import io.usethesource.vallang.IListWriter;
import io.usethesource.vallang.INumber;
import io.usethesource.vallang.IReal;
import io.usethesource.vallang.ISet;
import io.usethesource.vallang.IValue;
import io.usethesource.vallang.IValueFactory;
import io.usethesource.vallang.type.Type;
import io.usethesource.vallang.type.TypeFactory;
import io.usethesource.vallang.type.TypeStore;

public class LinearProgramming {
	
	private final IValueFactory values;

	public LinearProgramming(IValueFactory values) {
		super();
		this.values = values;
	}

	public static final TypeStore typestore = new TypeStore();

	private static final TypeFactory tf = TypeFactory.getInstance();

	public static final Type LLVariableVals = tf.listType(tf.numberType());

	public static final Type LLSolution = tf.abstractDataType(typestore,
			"LLSolution");

	public static final Type LLSolution_llSolution = tf.constructor(typestore,
			LLSolution, "llSolution", LLVariableVals, "varVals",
			tf.numberType(), "funVal");


	public static final Type TP = tf.parameterType("T");

	public static final Type Maybe = tf.abstractDataType(typestore, "Maybe", TP);
	
	public static final Type Maybe_just = tf.constructor(typestore, Maybe, "just", TP, "val");
	
	public static final Type Maybe_nothing = tf.constructor(typestore, Maybe, "nothing");
	
	public static final Type ConstraintType = tf.abstractDataType(typestore,
			"ConstraintType");

	public static final Type ConstraintType_leq = tf.constructor(typestore,
			ConstraintType, "leq");
	public static final Type ConstraintType_eq = tf.constructor(typestore,
			ConstraintType, "eq");
	public static final Type ConstraintType_geq = tf.constructor(typestore,
			ConstraintType, "geq");

	public static final Type LLCoefficients = LLVariableVals;

	public static final Type LLConstraint = tf.abstractDataType(typestore,
			"LLConstraint");

	public static final Type LLConstraint_llConstraint = tf.constructor(
			typestore, LLConstraint, "llConstraint", LLCoefficients,
			"coefficients", ConstraintType, "ctype", tf.numberType(), "const");

	public static final Type LLLinearExpr = tf.abstractDataType(typestore,
			"LLLinearExpr");

	public static final Type LLLinearExpr_llLinearExp = tf.constructor(
			typestore, LLLinearExpr, "llLinearExp", LLCoefficients,
			"coefficients", tf.numberType(), "const");

	public static IValue LLSolution_llSolution_varVals(IConstructor c) {
		return (IValue) c.get(0);
	}

	public static double LLSolution_llSolution_funVal(IConstructor c) {
		return c.get(1) instanceof IInteger ? (double) ((IInteger) c.get(1))
				.intValue() : ((IReal) c.get(1)).doubleValue();
	}

	public static IList LLConstraint_llConstraint_coefficients(IConstructor c) {
		return (IList) c.get(0);
	}

	public static IConstructor LLConstraint_llConstraint_ctype(IConstructor c) {
		return (IConstructor) c.get(1);
	}

	public static double LLConstraint_llConstraint_const(IConstructor c) {
		return c.get(2) instanceof IInteger ? (double) ((IInteger) c.get(2))
				.intValue() : ((IReal) c.get(2)).doubleValue();
	}

	public static IList LLObjectiveFun_llObjFun_coefficients(IConstructor c) {
		return (IList) c.get(0);
	}

	public static double LLObjectiveFun_llObjFun_const(IConstructor c) {
		return c.get(1) instanceof IInteger ? (double) ((IInteger) c.get(1))
				.intValue() : ((IReal) c.get(1)).doubleValue();
	}

	// begin handwritten code

	private double[] convertRealList(IList l) {
		double[] elems = new double[l.length()];
		for (int i = 0; i < l.length(); i++) {
			elems[i] = ((INumber) l.get(i)).toReal(values.getPrecision()).doubleValue();
		}
		return elems;
	}

	private static IList convertToRealList(double[] l, IValueFactory vf) {
		IListWriter writer = vf.listWriter();
		for (int i = 0; i < l.length; i++) {
			writer.append(vf.real(l[i]));
		}
		return writer.done();
	}

	private LinearObjectiveFunction 
		convertLinObjFun(IConstructor c) {
		double[] coefficients =  convertRealList(LLObjectiveFun_llObjFun_coefficients(c));
		double constant =  LLObjectiveFun_llObjFun_const(c);
		return new LinearObjectiveFunction(coefficients, constant);
	}

	private static Relationship convertConstraintType(IConstructor c){
		if(c.getConstructorType() == ConstraintType_leq){
			return Relationship.LEQ;
		} else if(c.getConstructorType() == ConstraintType_eq){
			return Relationship.EQ;
		} else {
			return Relationship.GEQ;
		}
	}

	private LinearConstraint convertConstraint(IConstructor c) {
		double[] coeffients = convertRealList(LLConstraint_llConstraint_coefficients(c));
		double constant = LLConstraint_llConstraint_const(c);
		Relationship r = convertConstraintType(LLConstraint_llConstraint_ctype(c));
		return new LinearConstraint(coeffients, r, constant);
	}

	public IValue llOptimize(IBool minimize, IBool nonNegative, ISet constraints, IConstructor f) {
		SimplexSolver solver = new SimplexSolver();
		ArrayList<LinearConstraint> constraintsJ =
				new ArrayList<LinearConstraint>(constraints.size());
		for(IValue v : constraints ){
			constraintsJ.add(convertConstraint((IConstructor)v));
		}
		LinearObjectiveFunction fJ = convertLinObjFun(f);
		GoalType goal = minimize.getValue() ? 
						GoalType.MINIMIZE : GoalType.MAXIMIZE;
		IValueFactory vf = values;
		boolean nonNegativeJ =  nonNegative.getValue();
		try {
			RealPointValuePair res = 
					solver.optimize(fJ, constraintsJ, goal,nonNegativeJ);
			return vf.constructor(Maybe_just, 
					vf.constructor(
							LLSolution_llSolution, convertToRealList(res.getPoint(), vf), 
							vf.real(res.getValue()) )
					);
		} catch (Exception e) {
			return  vf.constructor(Maybe_nothing); 
		}

	}
}
