##################################################################################
# -*- coding: utf-8 -*-
#"""
#Created on Wed Nov 12 13:39:10 2018
#@author: chinmay deval
#
# Downloads streamflow data hosted on the DataOne portal
#"""
##################################################################################


###############################clear environment and console######################

library(dataone)
library(datapack)
library(RCurl)

#### base dir. outputs will be stored in sub dirs listed in dir.create func 
wDir<- ("C:/Chinmay/Github/Fetch_LTER/")


### create dir and cwd to tht 
dir.create(file.path(wDir, "data", "HJ_Andrews", "streamflow"))
setwd(file.path(wDir, "data", "HJ_Andrews", "streamflow"))
    

### def the data node
d1c <- D1Client("PROD", "urn:node:LTER")

#### Get the identifier link from for the files you want to download
### This can be found on the DataOne data search portal
### e.g. The package doi is located just above the download all option
### check this link for an example https://search.dataone.org/view/https://pasta.lternet.edu/package/metadata/eml/knb-lter-and/4021/21
### and see if you can locate "package doi" link above the download all option
### Thats the string you need

streamflow_pid<- "doi:10.6073/pasta/ce70a42e1f637cd430d7b0fb64faefb4"

### Get the datapacakge information
streamflow_pkg<- getDataPackage(d1c, streamflow_pid)

### find urls to the data
streamflow_urls<- names(getValue(streamflow_pkg, name="sysmeta@formatId"))

### specify the links to be downloaded
streamflow_urls<- streamflow_urls[1:4]

### Specify output filenames
streamflow_dest<- c("CF00201.csv","CF00204.csv","CF00203.csv","CF00202.csv","CF00206.csv")


#### download streamflow data

for (i in seq_along(streamflow_urls)){
    download.file(url = streamflow_urls[i], destfile = streamflow_dest[i], method = "libcurl")
}

####

print("All Done!!!")