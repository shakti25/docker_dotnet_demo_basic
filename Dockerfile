# manually published app within a Docker container
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
# WORKDIR /app
# COPY published/ ./
# ENTRYPOINT [ "dotnet", "Demo.Docker.Api.dll" ]

# === Multi Stage ===

# build Stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /source

# copy sln and csproj's to later restore as distinct layers
COPY . .
RUN dotnet restore
RUN dotnet publish -c Release -o /published --no-restore

# final stage/image
FROM mcr.microsoft.com/dotnet/aspnet:8.0
EXPOSE 8080
WORKDIR /app
COPY --from=build /published ./
ENTRYPOINT [ "dotnet", "Demo.Docker.Api.dll" ]