import domain/resource/builder
import domain/resource/repo
import domain/resource/resource
import gleam/option.{None, Some}
import gleeunit/should

fn generate_resources() -> List(resource.Resource) {
  let b = builder.create(Some("res1"), None, None, None)
  let assert Ok(r1) = builder.build(b)

  builder.with_name_str(b, "res2")
  let assert Ok(r2) = builder.build(b)

  builder.with_name_str(b, "res3")
  let assert Ok(r3) = builder.build(b)

  [r1, r2, r3]
}

fn create() -> repo.ResourceRepo {
  let list = generate_resources()
  let list_all = fn() { Ok(list) }
  let save = fn(_: resource.Resource) { Ok(Nil) }
  let delete = fn(_: resource.Resource) { Ok(Nil) }

  repo.ResourceRepo(list_all, save, delete)
}

pub fn list_all_test() {
  let repo = create()
  let expected = generate_resources()
  let assert Ok(result) = repo.list_all()
  should.equal(expected, result)
}
