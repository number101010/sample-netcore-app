FROM mcr.microsoft.com/dotnet/core/sdk:2.2 as build

COPY . /src
RUN dotnet publish /src/sample-netcore-app.csproj --configuration release --output /publish
    
FROM mcr.microsoft.com/dotnet/core/aspnet:2.2.5

WORKDIR /app
COPY --from=build /publish /app

ENV ASPNETCORE_URLS http://+:8080
CMD ["dotnet", "/app/sample-netcore-app.dll"]
EXPOSE 8080
