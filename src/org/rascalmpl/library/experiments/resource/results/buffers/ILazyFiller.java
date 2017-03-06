/*******************************************************************************
 * Copyright (c) 2009-2013 CWI
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
*******************************************************************************/
package org.rascalmpl.library.experiments.resource.results.buffers;

import io.usethesource.vallang.IValue;

public interface ILazyFiller {

	public IValue[] refill(int pageSize);
	
	public ILazyFiller getBufferedFiller();	
}
