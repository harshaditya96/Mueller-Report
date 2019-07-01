############################################################################################
##
## CSE587 - Lab 2 - Data Collection
##
## Author: Paul M Girdler
## Created: March 17, 2019
##
############################################################################################

# Clear the memory
rm(list = ls())

#install.packages("rtweet")
#install.packages("devtools")
#devtools::install_github("mkearney/nytimes")
#install.packages("jsonlite")

library("rtweet")

CONSUMERKEY    = "EpXe5jDFDDWBJ1w4WDhNRSqeX"
CONSUMERSECRET = "JauM7sUy32vf3U336ghagoMQgw0BZ8kEHVZlARIpWSQgIeStha"
ACCESSTOKEN    = "162230210-2XOTpnzlswUEHeRv4zZ24QhvyoBLdtqXWhtCztYZ"
ACCESSSECRET   = "op3ZBntgaUFQtp1G2lRSxKUXJSVg7VacGOQH1NPHKu8Yz"


env_var <- create_token(app = "UB-Lab2", CONSUMERKEY, CONSUMERSECRET, ACCESSTOKEN, ACCESSSECRET)

# max_id value should just be the last status ID returned by the previous search.

# max_id = last_status_id
last_status_id <-  rtweet_mueller_search$status_id[nrow(rtweet_mueller_search)]
rtweet_mueller_search <- search_tweets("mueller",lang = "en", include_rts = FALSE, geocode = lookup_coords("usa"), n=18000, retryonratelimit = TRUE )

rtweet_mueller <- rbind(rtweet_mueller, rtweet_mueller_search)
min(rtweet_mueller$created_at)

x <- 1
repeat {
  print(x)
  x = x+1
  p1 <- Sys.time()
  rtweet_mueller_search <- search_tweets("mueller",lang = "en", include_rts = FALSE, geocode = lookup_coords("usa"), n=18000, retryonratelimit = TRUE, , max_id = last_status_id)
  Sys.sleep(940)
  rtweet_mueller <- rbind(rtweet_mueller, rtweet_mueller_search)
  Sys.sleep(60)
  last_status_id <-  rtweet_mueller_search$status_id[nrow(rtweet_mueller_search)]
  Sys.sleep(10)
  print(min(rtweet_mueller$created_at))
  Sys.sleep(10)
  if (x == 3){
    break
  }
}

write_as_csv(rtweet_mueller, file_name = "rtweet_mueller.csv")