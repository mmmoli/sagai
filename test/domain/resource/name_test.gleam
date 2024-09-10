import domain/resource/name.{TooShortError, create, create_with_default}
import gleeunit/should

pub fn create_valid_resource_name_test() {
  // Test with a valid resource name
  let valid_name = "ValidName"
  let result = create(valid_name)
  should.be_ok(result)
}

pub fn too_short_resource_name_test() {
  // Test with a too short resource name
  let short_name = "x"
  let result = create(short_name)
  let too_short_error = Error(TooShortError(short_name))
  should.equal(too_short_error, result)
}

pub fn create_default_resource_name_test() {
  // Test creating the default resource name
  let result = create_with_default()
  should.be_ok(result)
}
