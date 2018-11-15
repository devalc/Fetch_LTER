##################################################################################
# -*- coding: utf-8 -*-
#"""
#Created on Wed Nov 14 16:39:10 2018
#@author: chinmay deval
#
# Downloads streamchemistry data hosted on the DataOne portal
#"""
##################################################################################

library(dataone)
library(datapack)
library(RCurl)

#### base dir. outputs will be stored in sub dirs listed in dir.create func 
wDir<- ("C:/Chinmay/Github/Fetch_LTER/")


### create dir and cwd to tht 
dir.create(file.path(wDir, "data", "HJ_Andrews", "streamchem"))
setwd(file.path(wDir, "data", "HJ_Andrews", "streamchem"))

### def the data node
d1c <- D1Client("PROD", "urn:node:LTER")

#### Get the identifier link from for the files you want to download
### This can be found on the DataOne data search portal
### e.g. The package doi is located just above the download all option
### check this link for an example https://search.dataone.org/view/https://pasta.lternet.edu/package/metadata/eml/knb-lter-and/4021/21
### and see if you can locate "package doi" link above the download all option
### Thats the string you need

chem_pid <- "doi:10.6073/pasta/22cd44c4d8f970fd290371b0604d3d16"


### Get the datapacakge information
chem_pkg <- getDataPackage(d1c, chem_pid)

### find urls to the data
chem_urls<- names(getValue(chem_pkg, name="sysmeta@formatId"))

### specify the links to be downloaded
chem_urls <- chem_urls[1:5]


### Specify output filenames

chem_dest<- c("HF00406_v6.csv","HF00404_v6.csv","HF00402_v6.csv","HF00403_v6.csv")

# ###download stream chemistry data
for (i in seq_along(chem_urls)){
    download.file(url = chem_urls[i], destfile = chem_dest[i], method = "libcurl")
}

###
print("All Done!!!")