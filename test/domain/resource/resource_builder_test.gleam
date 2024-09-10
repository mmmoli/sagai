import birl
import domain/resource/builder
import domain/resource/date
import domain/resource/name.{create}
import domain/resource/resource
import domain/resource/value
import gleam/option.{None, Some}
import gleam/result
import gleeunit/should

pub fn new_test() {
  let name_str = "Resource1"
  let name = Some(name_str)
  let day = birl.Day(2023, 10, 1)
  let created_at = Some(date.create_created_at(day))
  let updated_at = Some(date.create_updated_at(day))
  let value = Some(100.0)

  let b = builder.create(name, created_at, updated_at, value)
  let assert Ok(r) = builder.build(b)

  let assert Ok(expected_name) = create(name_str)
  let assert Some(expected_value) = value

  should.equal(expected_name, r.name)
  should.equal(day, date.to_day(r.created_at))
  should.equal(day, date.to_day(r.updated_at))
  should.equal(expected_value, value.to_float(r.value))
}

pub fn new_with_defaults_test() {
  let name = None
  let created_at = None
  let updated_at = None
  let value = Some(100.0)

  let builder = builder.create(name, created_at, updated_at, value)

  should.be_ok(builder.name)
  should.be_ok(builder.created_at)
  should.be_ok(builder.updated_at)
  should.be_ok(builder.value)
}

pub fn with_name_str_test() {
  let b = builder.create(None, None, None, Some(100.0))
  let updated_builder = builder.with_name_str(b, "Resource1")

  should.be_ok(updated_builder.name)
}

pub fn with_name_test() {
  let builder = builder.create(None, None, None, Some(100.0))

  let name_result =
    create("Resource1")
    |> result.map_error(fn(reason) { builder.ResourceNameNotSetError(reason) })

  case name_result {
    Error(_) -> should.fail()
    Ok(name) -> {
      let updated_builder = builder.with_name(builder, name)
      should.equal(updated_builder.name, Ok(name))
    }
  }
}

pub fn with_created_at_test() {
  let builder = builder.create(None, None, None, Some(100.0))
  let when = birl.Day(2023, 10, 1)
  let created_at = date.create_created_at(when)
  let updated_builder = builder.with_created_at(builder, created_at)

  should.equal(updated_builder.created_at, Ok(created_at))
}

pub fn with_updated_at_test() {
  let builder = builder.create(None, None, None, Some(100.0))
  let when = birl.Day(2023, 10, 1)
  let updated_at = date.create_updated_at(when)
  let updated_builder = builder.with_updated_at(builder, updated_at)

  should.equal(updated_builder.updated_at, Ok(updated_at))
}

pub fn build_test() {
  let name = "Resource1"
  let created_at = date.create_created_at(birl.Day(2023, 10, 1))
  let updated_at = date.create_updated_at(birl.Day(2023, 10, 2))
  let v = 100.0

  let builder =
    builder.create(Some(name), Some(created_at), Some(updated_at), Some(v))
  let result = builder.build(builder)

  let assert Ok(expected_name_result) = create(name)
  let assert Ok(expected_value) = value.create(v)

  let expected_resource =
    resource.Resource(
      name: expected_name_result,
      created_at: created_at,
      updated_at: updated_at,
      value: expected_value,
    )

  should.equal(result, Ok(expected_resource))
}

pub fn build_with_empty_params_test() {
  let builder = builder.create(None, None, None, None)
  let result = builder.build(builder)
  should.be_ok(result)
}
