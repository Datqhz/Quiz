#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
# Copy nuget.config and .nupkg files for local packages
COPY ["nuget.config", "."]
COPY ["packages/Quiz.Common.1.0.9.nupkg", "packages/"]
COPY ["packages/Quiz.MyUser.Contracts.1.0.0.nupkg", "packages/"]

COPY ["Quiz.Task/src/Quiz.Task.Service/Quiz.Task.Service.csproj", "Quiz.Task/src/Quiz.Task.Service/"]
RUN dotnet restore "Quiz.Task/src/Quiz.Task.Service/Quiz.Task.Service.csproj"

COPY . .
WORKDIR "/src/Quiz.Task/src/Quiz.Task.Service"

RUN dotnet tool install --global dotnet-ef --version 7.0.16
ENV PATH="$PATH:/root/.dotnet/tools"


RUN dotnet build "Quiz.Task.Service.csproj" -c Release -o /app/build

# RUN dotnet ef migrations add InitialCreate
# RUN dotnet ef database update

FROM build AS publish
RUN dotnet publish "Quiz.Task.Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

# RUN dotnet tool install --global dotnet-ef --version 7.0.16
# ENV PATH="$PATH:/root/.dotnet/tools"
# RUN dotnet ef migrations add InitialCreate
# RUN dotnet ef database update

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Quiz.Task.Service.dll"]