#import "../calendar.typ": calendar

#set page(
  "a4",
  flipped: true,
  margin: 8%,
)
#set text(size: 14pt)

#show: calendar.with(
  year: 2000,
  weekstart_is_monday: true,
)
