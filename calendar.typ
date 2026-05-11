#let calendar(year: datetime.today().year(), weekstart_is_monday: true, body) = {
  assert(type(year) == int, message: "Year must be an integer")
  set document(title: str(year) + " calendar")
  let weekstart = if weekstart_is_monday { "monday" } else { "sunday" }
  let weekday_headers = ([Monday], [Tuesday], [Wednesday], [Thursday], [Friday], [Saturday], [Sunday])
  if not weekstart_is_monday { weekday_headers.insert(0, weekday_headers.pop()) }

  for month in range(1, 13) [

    #let month_date = datetime(
      year: year,
      month: month,
      day: 1,
    )

    #let monthly_days = ()

    #for day in range(0, 31) [
      #let month_accumulator = (month_date + duration(days: day))
      #if month_accumulator.month() != month {
        break
      }
      #monthly_days.push(month_accumulator)
    ]

    #align(left)[
      #heading(level: 1)[
        #text(size: 27pt)[#month_date.display("[month repr:long]") #year
        ]
      ]
    ]

    #let first_weekstart = {
      int(monthly_days.first().display("[weekday repr:" + weekstart + "]"))
    }

    #show table.cell.where(y: 0): strong
    #pad(
      y: 5%,
      table(
        columns: (1fr,) * 7,
        rows: (0.4fr,) + 5 * (1fr,),
        inset: 0.8em,
        table.header(..weekday_headers),
        ..range(1, first_weekstart).map(empty_day => []),
        ..monthly_days.map(day => [#day.display("[day padding:none]")]),
        stroke: (x, y) => if y != 0 {
          (thickness: 1.5pt)
        },
      ),
    )

    #pagebreak(weak: true)
  ]
}
