import domain/date
import domain/name.{type ResourceName, type ResourceNameError}
import domain/value.{type ResourceValue}
import gleam/option.{type Option, None, Some}
import gleam/result.{try}

pub type Resource {
  Resource(
    name: ResourceName,
    created_at: date.DateStamp(date.CreatedAt),
    updated_at: date.DateStamp(date.UpdatedAt),
    value: ResourceValue,
  )
}

pub type ResourceBuilderError {
  ResourceNameNotSetError(ResourceNameError)
  CreatedAtNotSetError
  UpdatedAtNotSetError
  ValueNotSetError
}

pub type ResourceBuilder {
  ResourceBuilder(
    name: Result(ResourceName, ResourceBuilderError),
    value: Result(ResourceValue, ResourceBuilderError),
    created_at: Result(date.DateStamp(date.CreatedAt), ResourceBuilderError),
    updated_at: Result(date.DateStamp(date.UpdatedAt), ResourceBuilderError),
  )
}

pub fn new(
  name: Option(String),
  created_at: Option(date.DateStamp(date.CreatedAt)),
  updated_at: Option(date.DateStamp(date.UpdatedAt)),
  value: Option(Float),
) -> ResourceBuilder {
  let now = date.today()

  let name_result =
    case name {
      Some(str) -> name.new(str)
      None -> name.new_with_default()
    }
    |> result.map_error(fn(reason) { ResourceNameNotSetError(reason) })

  let value_result =
    value
    |> option.unwrap(1.0)
    |> value.new()
    |> result.map_error(fn(_) { ValueNotSetError })

  let created_at_result =
    created_at
    |> option.unwrap(date.new_created_at(now))
    |> Ok
    |> result.map_error(fn(_) { CreatedAtNotSetError })

  let updated_at_result =
    updated_at
    |> option.unwrap(date.new_updated_at(now))
    |> Ok
    |> result.map_error(fn(_) { UpdatedAtNotSetError })

  ResourceBuilder(
    name: name_result,
    value: value_result,
    created_at: created_at_result,
    updated_at: updated_at_result,
  )
}

pub fn with_name_str(builder: ResourceBuilder, name: String) -> ResourceBuilder {
  ResourceBuilder(
    ..builder,
    name: name
      |> name.new()
      |> result.map_error(fn(reason) { ResourceNameNotSetError(reason) }),
  )
}

pub fn with_name(
  builder: ResourceBuilder,
  name: ResourceName,
) -> ResourceBuilder {
  ResourceBuilder(..builder, name: Ok(name))
}

pub fn with_created_at(
  builder: ResourceBuilder,
  created_at: date.DateStamp(date.CreatedAt),
) -> ResourceBuilder {
  ResourceBuilder(..builder, created_at: Ok(created_at))
}

pub fn with_updated_at(
  builder: ResourceBuilder,
  updated_at: date.DateStamp(date.UpdatedAt),
) -> ResourceBuilder {
  ResourceBuilder(..builder, updated_at: Ok(updated_at))
}

pub fn with_value(builder: ResourceBuilder, value: Float) -> ResourceBuilder {
  ResourceBuilder(
    ..builder,
    value: value
      |> value.new()
      |> result.map_error(fn(_) { ValueNotSetError }),
  )
}

pub fn build(builder: ResourceBuilder) -> Result(Resource, ResourceBuilderError) {
  use name <- try(builder.name)
  use created_at <- try(builder.created_at)
  use updated_at <- try(builder.updated_at)
  use value <- try(builder.value)

  Ok(Resource(
    name: name,
    created_at: created_at,
    updated_at: updated_at,
    value: value,
  ))
}
