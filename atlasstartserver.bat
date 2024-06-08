@echo off
setlocal enabledelayedexpansion

if "%~1" == "" (
    echo Missing settings parameter
    exit /b 1
)

echo Starting Server...

cd AtlasTools\RedisDatabase
start /b redis-server.exe redis.conf
for /f "tokens=2 delims=," %%I in ('tasklist /fi "imagename eq redis-server.exe" /fo csv /nh') do (
    set redis_pid=%%I
    set redis_pid=!redis_pid:"=!
)

cd ..\..\
cd ShooterGame\Binaries\Win64
start /high ShooterGameServer.exe %*
for /f "tokens=2 delims=," %%I in ('tasklist /fi "imagename eq ShooterGameServer.exe" /fo csv /nh') do (
    set shooter_pid=%%I
    set shooter_pid=!shooter_pid:"=!
)

set /p input=

if /i "%input%"=="stop" (
    goto stopServer
)

goto mainLoop

:stopServer
echo Stopping Server...
taskkill /f /pid %redis_pid%
taskkill /f /pid %shooter_pid%
exit /b