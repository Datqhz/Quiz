#See https://aka.ms/customizecontainer to learn how to customize your debug container and how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:7.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ["nuget.config", "."]
COPY ["packages/Quiz.Common.1.0.9.nupkg", "packages/"]
COPY ["packages/Quiz.MyUser.Contracts.1.0.0.nupkg", "packages/"]

# Copy csproj and restore as distinct layers
COPY ["Quiz.MyUser/src/Quiz.MyUser.Service/Quiz.MyUser.Service.csproj", "Quiz.MyUser/src/Quiz.MyUser.Service/"]
COPY ["Quiz.MyUser/src/Quiz.MyUser.Contracts/Quiz.MyUser.Contracts.csproj", "Quiz.MyUser/src/Quiz.MyUser.Contracts/"]
# RUN dotnet restore "Quiz.MyUser/src/Quiz.MyUser.Service/Quiz.MyUser.Service.csproj" --source ./packages
RUN dotnet restore "Quiz.MyUser/src/Quiz.MyUser.Service/Quiz.MyUser.Service.csproj"

# Copy the remaining files and build the project
COPY . .
WORKDIR "/src/Quiz.MyUser/src/Quiz.MyUser.Service"

RUN dotnet tool install --global dotnet-ef --version 7.0.16
ENV PATH="$PATH:/root/.dotnet/tools"


RUN dotnet build "Quiz.MyUser.Service.csproj" -c Release -o /app/build


FROM build AS publish
RUN dotnet publish "Quiz.MyUser.Service.csproj" -c Release -o /app/publish /p:UseAppHost=false

# RUN dotnet tool install --global dotnet-ef --version 7.0.16
# ENV PATH="$PATH:/root/.dotnet/tools"
# WORKDIR "/src/Quiz.MyUser/src/Quiz.MyUser.Service"
# RUN dotnet ef migrations add InitialCreate
# RUN dotnet ef database update

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "Quiz.MyUser.Service.dll"]