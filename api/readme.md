# Notes on configuration

- [Docs on CookieSecurePolicy](https://learn.microsoft.com/en-us/dotnet/api/microsoft.aspnetcore.http.cookiesecurepolicy?view=aspnetcore-8.0)
- We're overriding `web.config` to re-enable logging to stdout. 
    - [Serilog](https://github.com/serilog/serilog/wiki/Configuration-Basics) is configured to only log Errors and more serious issues to logs/app.txt (see Program.cs)
    - TODO: add configuration options to log to the Docker host in production too.
