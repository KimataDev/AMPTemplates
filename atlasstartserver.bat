@echo on
cd AtlasTools\RedisDatabase
start /b redis-server.exe redis.conf

cd ..\..\
cd ShooterGame\Binaries\Win64
start /b /wait /high ShooterGameServer.exe Ocean?ServerX=0?ServerY=0?AltSaveDirectoryName=00?ServerAdminPassword=123?MaxPlayers=30?ReservedPlayerSlots=25?QueryPort=27015?Port=7778?SeamlessIP=0.0.0.0 -log -server -NoBattlEye