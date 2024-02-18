# syntax=docker/dockerfile:1
# Based on Debian 10 / buster
# https://learn.microsoft.com/en-us/dotnet/core/docker/build-container?tabs=windows&pivots=dotnet-8-0#publish-net-app

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
ADD https://github.com/reallyreadit/api.git#feat/alt-instance-config /App
WORKDIR /App
# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:3.1
# Install runtime dependency
RUN apt update && apt install fonts-noto-color-emoji
WORKDIR /App
COPY --from=build /App/out .
# Create logs dir
RUN mkdir logs
ENTRYPOINT ["dotnet", "api.dll"]