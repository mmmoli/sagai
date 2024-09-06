import domain/name.{TooShortError, new, new_with_default}
import gleeunit
import gleeunit/should

pub fn main() {
  gleeunit.main()
}

pub fn create_valid_resource_name_test() {
  // Test with a valid resource name
  let valid_name = "ValidName"
  let result = new(valid_name)
  should.be_ok(result)
}

pub fn too_short_resource_name_test() {
  // Test with a too short resource name
  let short_name = "x"
  let result = new(short_name)
  let too_short_error = Error(TooShortError(short_name))
  should.equal(too_short_error, result)
}

pub fn create_default_resource_name_test() {
  // Test creating the default resource name
  let result = new_with_default()
  should.be_ok(result)
}
