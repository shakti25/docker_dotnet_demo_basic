using Api.Helpers;

namespace Demo.Docker.Api.Tests;

public class HelperMethodsTests
{
    [Fact]
    public void Greet_Rajiv_Success()
    {
        // Arrange
        var name = "Rajiv";
        var expectedGreeting = "hello Rajiv";

        // Act
        var greetMessage = HelperMethods.Greet(name);

        // Assert
        Assert.Equal(expectedGreeting, greetMessage);
    }
}