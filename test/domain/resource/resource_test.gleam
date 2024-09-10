import domain/resource/builder
import domain/resource/resource
import gleam/float
import gleam/option.{None, Some}
import gleeunit/should

pub fn to_debug_test() {
  let name_str = "Dog Resouce"
  let value = 100.0
  let b = builder.create(Some(name_str), None, None, Some(value))
  let assert Ok(r) = builder.build(b)
  let expected_str = name_str <> ": " <> float.to_string(value)
  let str = resource.debug(r)
  should.equal(expected_str, str)
}

pub fn to_string_test() {
  let expected_str = "Dog Resouce"
  let b = builder.create(Some(expected_str), None, None, Some(100.0))
  let assert Ok(r) = builder.build(b)
  let str = resource.to_string(r)
  should.equal(expected_str, str)
}
