##############################################################
## Akhila Devi D
## Lab - 2(Part 1) (Data Intensive Computing)
## 50288354
##############################################################
rm(list = ls())
#library(devtools)
library("nytimes")
library("jsonlite")
library("dplyr")
library("tidyr")
library("ggplot2")
library("stringr")



#http://www.storybench.org/working-with-the-new-york-times-api-in-r/
apikey <- paste0("NYTIMES_KEY=", "Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW")
Sys.setenv(NYTIMES_KEY="Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW")

## make path to .Renviron
file <- file.path(path.expand("~"), ".Renviron")

## save environment variable
cat(apikey, file = file, append = TRUE, fill = TRUE)

x <- fromJSON("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=mueller&api-key=Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", flatten = TRUE) %>% data.frame()
## get http response objects for search about mueller
term <- "mueller" # Need to use + to string together separate words
###########################################################################
## March(1-22)
###########################################################################
begin_date_mar <- "20190301"
end_date_mar <- "20190322"

baseurl_mar <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date_mar,"&end_date=",end_date_mar,
                  "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_mar <- fromJSON(baseurl_mar)
## Very important to include maximum number of pages to query
maxPages_mar <- round((initialQuery_mar$response$meta$hits[1] / 10)-1) 
pages_mar <- list()
for(i in 0:maxPages_mar){
  nytSearch <- fromJSON(paste0(baseurl_mar, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_mar[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_03 <- rbind_pages(pages_mar) #100*32
## Export just the URL's
write.csv(allNYTSearch_03$response.docs.web_url, "Mar0122_URL.csv")

# Visualize coverage by section
allNYTSearch %>% 
  group_by(response.docs.type_of_material) %>%
  summarize(count=n()) %>%
  mutate(percent = (count / sum(count))*100) %>%
  ggplot() +
  geom_bar(aes(y=percent, x=response.docs.type_of_material, fill=response.docs.type_of_material), stat = "identity") + coord_flip()

###########################################################################
## March(24-28)
###########################################################################
begin_date_march <- "20190323"
end_date_march <- "20190328"

baseurl_march <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                      "&begin_date=",begin_date_march,"&end_date=",end_date_march,
                      "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_march <- fromJSON(baseurl_march)
## Very important to include maximum number of pages to query
maxPages_march <- round((initialQuery_march$response$meta$hits[1] / 10)-1) 
pages_march <- list()
for(i in 0:maxPages_march){
  nytSearch <- fromJSON(paste0(baseurl_march, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_march[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_01 <- rbind_pages(pages_march) #90*32
## Export just the URL's
write.csv(allNYTSearch_01$response.docs.web_url, "Mar2428_URL.csv")


###########################################################################
## February
###########################################################################
begin_date_feb <- "20190201"
end_date_feb <- "20190215"

baseurl_feb <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                  "&begin_date=",begin_date_feb,"&end_date=",end_date_feb,
                  "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_feb <- fromJSON(baseurl_feb)
## Very important to include maximum number of pages to query
maxPages_feb <- round((initialQuery_feb$response$meta$hits[1] / 10)-1) 
pages_feb <- list()
for(i in 0:maxPages_feb){
  nytSearch <- fromJSON(paste0(baseurl_feb, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_feb[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_02 <- rbind_pages(pages_feb) #50*32
## Export just the URL's
write.csv(allNYTSearch_02$response.docs.web_url, "Feb0115_URL.csv")

###########################################################################
## February(16-28)
###########################################################################
begin_date_febr <- "20190216"
end_date_febr <- "20190228"

baseurl_febr <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                      "&begin_date=",begin_date_febr,"&end_date=",end_date_febr,
                      "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_febr <- fromJSON(baseurl_febr)
## Very important to include maximum number of pages to query
maxPages_febr <- round((initialQuery_febr$response$meta$hits[1] / 10)-1) 
pages_febr <- list()
for(i in 0:maxPages_febr){
  nytSearch <- fromJSON(paste0(baseurl_febr, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_febr[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_06 <- rbind_pages(pages_febr) #65*32
## Export just the URL's
write.csv(allNYTSearch_06$response.docs.web_url, "Feb1628_URL.csv")

###########################################################################
## January
###########################################################################
begin_date_jan <- "20190101"
end_date_jan <- "20190121"

baseurl_jan <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                      "&begin_date=",begin_date_jan,"&end_date=",end_date_jan,
                      "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_jan <- fromJSON(baseurl_jan)
## Very important to include maximum number of pages to query
maxPages_jan <- round((initialQuery_jan$response$meta$hits[1] / 10)-1) 
pages_jan <- list()
for(i in 0:maxPages_jan){
  nytSearch <- fromJSON(paste0(baseurl_jan, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_jan[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_04 <- rbind_pages(pages_jan) #97*32
## Export just the URL's
write.csv(allNYTSearch_04$response.docs.web_url, "Jan0121_URL.csv")

###########################################################################
## January (22-31)
###########################################################################

begin_date_janu <- "20190122"
end_date_janu <- "20190131"

baseurl_janu <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                      "&begin_date=",begin_date_janu,"&end_date=",end_date_janu,
                      "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_janu <- fromJSON(baseurl_janu)
## Very important to include maximum number of pages to query
maxPages_janu <- round((initialQuery_janu$response$meta$hits[1] / 10)-1) 
pages_janu <- list()
for(i in 0:maxPages_janu){
  nytSearch <- fromJSON(paste0(baseurl_janu, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_janu[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_05 <- rbind_pages(pages_janu) #50*32
## Export just the URL's
write.csv(allNYTSearch_05$response.docs.web_url, "Jan2231_URL.csv")

###########################################################################
## December (2018)
###########################################################################

begin_date_dec <- "20181201"
end_date_dec <- "20181231"

baseurl_dec <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                       "&begin_date=",begin_date_dec,"&end_date=",end_date_dec,
                       "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_dec <- fromJSON(baseurl_dec)
## Very important to include maximum number of pages to query
maxPages_dec <- round((initialQuery_dec$response$meta$hits[1] / 10)-1) 
pages_dec <- list()
for(i in 0:maxPages_dec){
  nytSearch <- fromJSON(paste0(baseurl_dec, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_dec[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_07 <- rbind_pages(pages_dec) #100*32

## Export just the URL's
write.csv(allNYTSearch_07$response.docs.web_url, "Decembe18_URL.csv")

###########################################################################
## March28 - April 3
###########################################################################
begin_date_marap <- "20190328"
end_date_marap <- "20190403"

baseurl_marap <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                        "&begin_date=",begin_date_marap,"&end_date=",end_date_marap,
                        "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_marap <- fromJSON(baseurl_marap)
## Very important to include maximum number of pages to query
maxPages_marap <- round((initialQuery_marap$response$meta$hits[1] / 10)-1) 
pages_marap <- list()
for(i in 0:maxPages_marap){
  nytSearch <- fromJSON(paste0(baseurl_marap, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_marap[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_08 <- rbind_pages(pages_marap) #100*32

## Export just the URL's
write.csv(allNYTSearch_08$response.docs.web_url, "Mar23Apr3_URL.csv")

###########################################################################
## April 4 - April 14
###########################################################################
begin_date_ap2 <- "20190404"
end_date_ap2 <- "20190414"

baseurl_ap2 <- paste0("http://api.nytimes.com/svc/search/v2/articlesearch.json?q=",term,
                        "&begin_date=",begin_date_ap2,"&end_date=",end_date_ap2,
                        "&facet_filter=true&api-key=","Wx23grgK4rxOOzXYG37DaSqF9o7YbPmW", sep="")

initialQuery_ap2 <- fromJSON(baseurl_ap2)
## Very important to include maximum number of pages to query
maxPages_ap2 <- round((initialQuery_ap2$response$meta$hits[1] / 10)-1) 
pages_ap2 <- list()
for(i in 0:maxPages_ap2){
  nytSearch <- fromJSON(paste0(baseurl_ap2, "&page=", i), flatten = TRUE) %>% data.frame() 
  message("Retrieving page ", i)
  pages_ap2[[i+1]] <- nytSearch 
  Sys.sleep(1) 
}
allNYTSearch_09 <- rbind_pages(pages_ap2) #90*32

## Export just the URL's
write.csv(allNYTSearch_09$response.docs.web_url, "Apr0414_URL.csv")



