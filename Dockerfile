FROM microsoft/dotnet:2.2-sdk-alpine

LABEL "com.github.actions.name"=".NET Core Test Runner"
LABEL "com.github.actions.description"="Builds a repository and runs tests for .NET Core"
LABEL "com.github.actions.icon"="terminal"
LABEL "com.github.actions.color"="purple"

LABEL "repository"="https://github.com/yaakov-h/github-action-dotnet-test"
LABEL "homepage"="https://github.com/yaakov-h/github-action-dotnet-test"
LABEL "maintainer"="Yaakov <git@yaakov.online>"

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
