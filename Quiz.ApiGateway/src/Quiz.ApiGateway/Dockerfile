#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["nuget.config", "."]
COPY ["packages/Quiz.Common.1.0.9.nupkg", "packages/"]

COPY ["Quiz.ApiGateway/src/Quiz.ApiGateway/Quiz.ApiGateway.csproj", "Quiz.ApiGateway/src/Quiz.ApiGateway/"]
RUN dotnet restore "Quiz.ApiGateway/src/Quiz.ApiGateway/Quiz.ApiGateway.csproj"
COPY . .
WORKDIR "/src/Quiz.ApiGateway/src/Quiz.ApiGateway"
RUN dotnet build "Quiz.ApiGateway.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "Quiz.ApiGateway.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Quiz.ApiGateway.dll"]