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

pub fn to_string(resource: Resource) -> String {
  resource.name
  |> name.to_string()
}

pub fn debug(resource: Resource) -> String {
  let name =
    resource
    |> to_string

  let value =
    resource.value
    |> value.to_string()

  name <> ": " <> value
}
