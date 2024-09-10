import birl.{type Day, get_day, now}

pub opaque type DateStamp(kind) {
  DateStamp(Day)
}

pub type CreatedAt

pub type UpdatedAt

pub fn create_created_at(date: Day) -> DateStamp(CreatedAt) {
  DateStamp(date)
}

pub fn create_updated_at(date: Day) -> DateStamp(UpdatedAt) {
  DateStamp(date)
}

pub fn today() -> Day {
  now()
  |> get_day
}

pub fn to_day(t: DateStamp(kind)) -> Day {
  case t {
    DateStamp(day) -> day
  }
}
