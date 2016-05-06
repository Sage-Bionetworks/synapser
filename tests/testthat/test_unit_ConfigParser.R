## Unit test for Config.R
## 
## Author: Joseph Wu <joseph.wu@sagebase.org>
###############################################################################

.setUp <- function() {}

.tearDown <- function() {
    synapseClient:::.unmockAll()
}

unitTest_ConfigParser <- function() {
    # Replace the config file with a list of strings
    permissive_section <- "Anything sh0uld be f!ne in-the s3ction as 1ong @s no brackets are_used. Even = should work"
    permissive_key <- "0n1y da e#uals-$ign & c01On *s ^no% @()owed!"
    permissive_value <- "Same here`~!@#$%^&*()_-+[]\\{}|;':\",./<>?"
    spaced_key <- "arbitrary"
    spaced_value <- "spacing"
    empty_section <- "This should have an empty list"
    repeated_section <- "Same section = same list"
    overwritten_value <- "rubber ducks!"
    synapseClient:::.mock(".checkAndReadFile", 
        function(...) {
            return(c(
                sprintf("[%s]", permissive_section), 
                sprintf("%s = %s", permissive_key, permissive_value), 
                sprintf("        %s                      =   %s   ", spaced_key, spaced_value), 
                sprintf("[%s]", empty_section), 
                sprintf("[%s]", repeated_section), 
                "a = a", 
                "b:b", 
                sprintf("[%s]", repeated_section), 
                "c=c", 
                "d : d", 
                "to be = OVERWRITTEN", 
                sprintf("to be = %s", overwritten_value)))
        }
    )
    
    messy <- synapseClient:::ConfigParser()
    
    # Hopefully, the one-liners (hasOption, getOption, and hasSection) are correct
    checkTrue(synapseClient:::Config.hasOption(messy, permissive_section, permissive_key))
    checkTrue(synapseClient:::Config.hasOption(messy, permissive_section, spaced_key))
    checkTrue(synapseClient:::Config.getOption(messy, permissive_section, permissive_key) == permissive_value)
    checkTrue(synapseClient:::Config.getOption(messy, permissive_section, spaced_key) == spaced_value)
    checkTrue(synapseClient:::Config.hasSection(messy, empty_section))
    checkTrue(synapseClient:::Config.hasOption(messy, repeated_section, "a"))
    checkTrue(synapseClient:::Config.hasOption(messy, repeated_section, "b"))
    checkTrue(synapseClient:::Config.hasOption(messy, repeated_section, "c"))
    checkTrue(synapseClient:::Config.hasOption(messy, repeated_section, "d"))
    checkTrue(synapseClient:::Config.hasOption(messy, repeated_section, "to be"))
    checkTrue(synapseClient:::Config.getOption(messy, repeated_section, "a") == "a")
    checkTrue(synapseClient:::Config.getOption(messy, repeated_section, "b") == "b")
    checkTrue(synapseClient:::Config.getOption(messy, repeated_section, "c") == "c")
    checkTrue(synapseClient:::Config.getOption(messy, repeated_section, "d") == "d")
    checkTrue(synapseClient:::Config.getOption(messy, repeated_section, "to be") == overwritten_value)
    
    checkTrue(!synapseClient:::Config.hasOption(messy, permissive_section, "a"))
    checkTrue(!synapseClient:::Config.hasOption(messy, permissive_section, "b"))
    checkTrue(!synapseClient:::Config.hasOption(messy, permissive_section, "c"))
    checkTrue(!synapseClient:::Config.hasOption(messy, permissive_section, "d"))
    checkTrue(!synapseClient:::Config.hasOption(messy, permissive_section, "to be"))
    checkTrue(!synapseClient:::Config.hasOption(messy, repeated_section, permissive_key))
    checkTrue(!synapseClient:::Config.hasOption(messy, repeated_section, spaced_key))
    checkTrue(length(messy@data[[empty_section]]) == 0)
}