FROM microsoft/dotnet:2.2-sdk AS build-env
WORKDIR /app
 
# Copy and restore
COPY *.csproj ./
RUN dotnet restore 
 
# Build application
COPY . ./
RUN dotnet publish -c Release -o out
 
# Build image
FROM microsoft/dotnet:2.2-aspnetcore-runtime
WORKDIR /app
COPY --from=build-env /app/out ./
ENTRYPOINT ["dotnet", "AspNetCoreOnDocker.dll"]