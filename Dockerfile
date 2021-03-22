FROM mcr.microsoft.com/dotnet/sdk:3.1 as build

WORKDIR /src

COPY DioDockerTutorial.csproj .

RUN dotnet restore DioDockerTutorial.csproj

COPY ./ ./

RUN dotnet publish -c Release -o /app

FROM mcr.microsoft.com/dotnet/aspnet:3.1 as final

WORKDIR /app

COPY --from=build /app ./

ENTRYPOINT [ "dotnet", "DioDockerTutorial.dll" ]