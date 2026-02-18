set_min_sleep <- function(sessions, min_sleep) {
  sessions <- sessions[sessions['sleep_period'] >= min_sleep * 60 * 60, ]
  return(sessions)
}