import domain/resource/resource

pub type ResourceRepoError {
  SaveError
  DeleteError
}

pub type ResourceRepo {
  ResourceRepo(
    list_all: fn() -> Result(List(resource.Resource), Nil),
    save: fn(resource.Resource) -> Result(Nil, ResourceRepoError),
    delete: fn(resource.Resource) -> Result(Nil, ResourceRepoError),
  )
}
