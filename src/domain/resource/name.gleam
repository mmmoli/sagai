import gleam/string

pub opaque type ResourceName {
  ResourceName(value: String)
}

pub type ResourceNameError {
  TooShortError(value: String)
}

pub const min_value_length = 3

pub fn create(value: String) -> Result(ResourceName, ResourceNameError) {
  let too_short = string.length(value) < min_value_length

  case too_short {
    True -> Error(TooShortError(value))
    _ -> Ok(ResourceName(value))
  }
}

pub const default_resource_name = "My New Resource"

pub fn create_with_default() -> Result(ResourceName, ResourceNameError) {
  default_resource_name
  |> create()
}

pub fn to_string(resource_name: ResourceName) -> String {
  resource_name.value
}
