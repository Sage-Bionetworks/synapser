# R script to install pip
# 
# Author: bhoff
###############################################################################

# python get-pip.py --user
library(rWithPython)
python.exec("inst/python/sget-pip.py --user")
# To call pip from python: http://stackoverflow.com/questions/12332975/installing-python-module-within-code#15950647
python.exec("import pip")
python.exec("pip.main(['install', 'urllib3', '--target', 'inst/python', '--upgrade'])")
python.exec("pip.main(['install', 'synapseclient', '--target', 'inst/python', '--upgrade'])")
