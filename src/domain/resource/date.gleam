import birl.{type Day, get_day, now}

pub opaque type DateStamp(which) {
  DateStamp(Day)
}

pub type CreatedAt

pub type UpdatedAt

pub fn new_created_at(date: Day) -> DateStamp(CreatedAt) {
  DateStamp(date)
}

pub fn new_updated_at(date: Day) -> DateStamp(UpdatedAt) {
  DateStamp(date)
}

pub fn today() -> Day {
  now()
  |> get_day
}

pub fn to_day(t: DateStamp(which)) -> Day {
  case t {
    DateStamp(day) -> day
  }
}
