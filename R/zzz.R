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
				print(sprintf("pyName: %s.  At the R level the arguments are:", pyName))
				if (missing(...)) {
					print("NONE")
				} else {
					print(list(...))
				}
				values<-list(...)
				valuenames<-names(values)
				n<-length(values)
				unnamedvalues<-list()
				namedvalues<-list()
				if (n>0) {
					for (i in 1:n) {
						if (nchar(valuenames[[i]])==0) {
							unnamedvalues[[length(unnamedvalues)+1]]<-values[[i]]
						} else {
							# TODO what if key already exists?
							namedvalues[[valuenames[[i]]]]<-values[[valuenames[[i]]]]
						}
					}
				}
				pyCall("gateway.invoke", args=list(syn, pyName, unnamedvalues, namedvalues))
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
				pyCall("gateway.invoke", args=list(synapseClientModule, pyName, ...))
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
	constructorInfo<-.getSynapseConstructorInfo(system.file(package="synapser"))
	for (f in constructorInfo) {
		.defineConstructor(f$synName, f$name)
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



