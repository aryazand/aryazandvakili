library(dplyr)
library(purrr)
library(rorcid)
library(rcrossref)

myorcid <- rorcid::works("0000-0001-8031-8067")

dois <- myorcid |> 
  pluck("external-ids.external-id") |> 
  map(filter, `external-id-type` == "doi") |> 
  bind_rows() |> 
  pluck("external-id-value")

biblio <- map(dois, rcrossref::cr_cn, format = "text", style = "apa")

saveRDS(biblio, "publications/biblio.rds")
