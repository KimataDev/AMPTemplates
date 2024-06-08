@echo off

if "%~1" == "" (
    echo Missing settings parameter
    exit /b 1
)

echo Starting Server...

cd AtlasTools\RedisDatabase
start /b redis-server.exe redis.conf

cd ..\..\
cd ShooterGame\Binaries\Win64
start /b /wait /high ShooterGameServer.exe %*

:inputLoop
set /p input=

if /i "%input%"=="stop" (
    echo Stopping Server...
	taskkill /f /im redis-server.exe
    taskkill /f /im ShooterGameServer.exe
    exit /b
    exit /b
) else (
    echo Undefined command: %input%
)

goto inputLoop