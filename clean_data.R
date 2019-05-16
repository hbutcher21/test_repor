library(pdftools)
library(dplyr)
library(data.table)
library(tidyr)

outdoor_mens_data <- pdf_text('data/Outdoor-Men-2019.pdf') %>% strsplit(split = "\n")
outdoor_mens_data <- unlist(outdoor_mens_data)
dt_mens <- as.data.table(outdoor_mens_data)
is_it_a_record <- lapply(dt_mens, function(x) grepl("[0-9]{2}/[0-9]{2}/[0-9]{2}", x))
dt_mens <- cbind(dt_mens, is_it_a_record[[1]])

event_title_rows <- c(which(dt_mens$V2 == FALSE), nrow(dt_mens))
event_title_groups <- event_title_rows - lag(event_title_rows, 1) - 1
event_titles <- dt_mens[event_title_rows, outdoor_mens_data]

new <- NULL
for (i in 2:length(event_titles)){
  rep_events <- rep(event_titles[i], event_title_groups[i + 1])
  new <- c(new, rep_events)
  
}

dt_mens <- dt_mens[dt_mens$V2, -'V2']
# dt_mens <- lapply(dt_mens, function(x) gsub(" ", "_", x))
dt_mens2 <- dt_mens %>% separate(col = 'outdoor_mens_data', into = c("gender", "age", "record", "athlete_first_name", "athlete_surname", "country", "age_repeat", "record_date", "record_city", "record_country"), sep = "[ ]")
test <- dt_mens2[1]

