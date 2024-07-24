using Demo.Docker.Entities;

namespace Demo.Docker.Service;

public interface IPersonService
{
    List<PersonListViewModel> GetPeople();
}
