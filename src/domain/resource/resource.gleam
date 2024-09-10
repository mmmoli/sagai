import domain/resource/date
import domain/resource/name.{type ResourceName}
import domain/resource/value.{type ResourceValue}

pub type Resource {
  Resource(
    name: ResourceName,
    created_at: date.DateStamp(date.CreatedAt),
    updated_at: date.DateStamp(date.UpdatedAt),
    value: ResourceValue,
  )
}
