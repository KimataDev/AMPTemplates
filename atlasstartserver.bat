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