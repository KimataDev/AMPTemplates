@echo on

if "%~1" == "" (
    echo Missing settings parameter
    exit /b 1
)

cd AtlasTools\RedisDatabase
echo Starting Redis Server...
start /b redis-server.exe redis.conf

cd ..\..\
cd ShooterGame\Binaries\Win64
echo Starting ATLAS Dedicated Server...
start /b /wait /high ShooterGameServer.exe %*