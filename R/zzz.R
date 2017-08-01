# package initialization
#
# Author: bhoff
###############################################################################

.onLoad <- function(libname, pkgname) { 
	.addPythonAndFoldersToSysPath(system.file(package="synapser"))
	
	.defineRPackageFunctions()
	
	pyImport("synapseclient")
	pyExec("syn=synapseclient.Synapse()")
}

.defineFunction<-function(synName, pyName) {
	force(synName)
	force(pyName)
	assign(sprintf(".%s", synName), function(...) {
				syn<-pyGet("syn", simplify=FALSE)
				values<-list(...)
				valuenames<-names(values)
				n<-length(values)
				args<-list(syn, pyName)
				kwargs<-list()
				if (n>0) {
					positionalArgument<-TRUE
					for (i in 1:n) {
						if (is.null(valuenames) || length(valuenames[[i]])==0 || nchar(valuenames[[i]])==0) {
							# it's a positional argument
							if (!positionalArgument) {
								stop("positional argument follows keyword argument")
							}
							args[[length(args)+1]]<-values[[i]]
						} else {
							# It's a keyword argument.  All subsequent arguments must also be keyword arg's
							positionalArgument<-FALSE
							# a repeated value will overwite an earlier one
							kwargs[[valuenames[[i]]]]<-values[[i]]
						}
					}
				}
				pyCall("gateway.invoke", args=args, kwargs=kwargs, simplify=F)
			})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), args=list(...))
			}
	)
}

.defineConstructor<-function(synName, pyName) {
	force(synName)
	force(pyName)
	assign(sprintf(".%s", synName), function(...) {
				synapseClientModule<-pyGet("synapseclient")
				pyCall("gateway.invoke", args=list(synapseClientModule, pyName, ...), simplify=F)
			})
	setGeneric(
			name=synName,
			def = function(...) {
				do.call(sprintf(".%s", synName), args=list(...))
			}
	)
}

.defineRPackageFunctions<-function() {
	functionInfo<-.getSynapseFunctionInfo(system.file(package="synapser"))
	for (f in functionInfo) {
		.defineFunction(f$synName, f$name)
	}
	classInfo<-.getSynapseClassInfo(system.file(package="synapser"))
	for (c in classInfo) {
		.defineConstructor(c$name, c$name)
	}
}

.onAttach <- function(libname, pkgname) {
	tou <- "\nTERMS OF USE NOTICE:
	When using Synapse, remember that the terms and conditions of use require that you:
	1) Attribute data contributors when discussing these data or results from these data.
	2) Not discriminate, identify, or recontact individuals or groups represented by the data.
	3) Use and contribute only data de-identified to HIPAA standards.
	4) Redistribute data only under these same terms of use.\n"
	
	packageStartupMessage(tou)
}



