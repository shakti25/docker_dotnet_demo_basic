using Demo.Docker.Entities;

namespace Demo.Docker.Service;

public class PersonService : IPersonService
{
    public List<PersonListViewModel> GetPeople()
    {
        return new List<PersonListViewModel>{
            new PersonListViewModel { FirstName = "Rajiv", LastName = "Toora" },
            new PersonListViewModel { FirstName = "Shirley", LastName = "Hidalgo" },
            new PersonListViewModel { FirstName = "Pepe", LastName = "Perez" }
        };
    }
}
