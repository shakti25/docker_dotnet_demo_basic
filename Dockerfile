# manually published app within a Docker container
# FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
# WORKDIR /app
# COPY published/ ./
# ENTRYPOINT [ "dotnet", "Demo.Docker.Api.dll" ]

# === Multi Stage ===

# # build Stage
# FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# WORKDIR /source

# # copy sln and csproj's to later restore as distinct layers
# COPY . .
# RUN dotnet restore
# RUN dotnet publish -c Release -o /published --no-restore

# # final stage/image
# FROM mcr.microsoft.com/dotnet/aspnet:8.0
# EXPOSE 8080
# WORKDIR /app
# COPY --from=build /published ./
# ENTRYPOINT [ "dotnet", "Demo.Docker.Api.dll" ]

# === Multi Stage v2 ===
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 8080
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /source
COPY ["src/Api/Demo.Docker.Api.csproj", "src/Api/"]
COPY ["src/Entities/Demo.Docker.Entities.csproj", "src/Entities/"]
COPY ["src/Services/Demo.Docker.Service.csproj", "src/Services/"]
RUN dotnet restore "src/Api/Demo.Docker.Api.csproj"

WORKDIR /source
COPY . .
RUN dotnet build "src/Api/Demo.Docker.Api.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "src/Api/Demo.Docker.Api.csproj" -c $BUILD_CONFIGURATION -o /app/publish --no-restore

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT [ "dotnet", "Demo.Docker.Api.dll" ]