# synapser
An R package providing programmatic access to Synapse
To install and run the production version:
```
install.packages("synapser", repos=c("https://sage-bionetworks.github.io/ran", "https://cran.cnr.berkeley.edu/")) 
library(synapser)
synLogin()
browseVignettes("synapser")
```

If you have been asked to validate a release candidate, please replace the URL `https://sage-bionetworks.github.io/ran` with `https://sage-bionetworks.github.io/staging-ran`, that is:
```
install.packages("synapser", repos=c("https://sage-bionetworks.github.io/staging-ran", "https://cran.cnr.berkeley.edu/")) 
```


