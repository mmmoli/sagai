pub opaque type ResourceValue {
  ResourceValue(value: Float)
}

pub type ResourceValueError {
  ZeroValueError
}

pub fn create(value: Float) -> Result(ResourceValue, ResourceValueError) {
  let is_zero = value == 0.0

  case is_zero {
    True -> Error(ZeroValueError)
    _ -> Ok(ResourceValue(value))
  }
}

pub fn to_float(v: ResourceValue) -> Float {
  case v {
    ResourceValue(value) -> value
  }
}
