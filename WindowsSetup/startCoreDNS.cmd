@echo off

if not exist Corefile.txt (
goto Corefile_Creation
)
:Corefile_Completed

if "%COREDNS_DEFAULT_DNS%" == "" (
goto Default_DNS_Setter
)
:DNS_Completed

if "%MINECRAFT_SERVER%" == "" (
goto Minecraft_Server_Setter
)
:Minecraft_Server_Completed

coredns -conf Corefile.txt -dns.port=53
goto end


:Corefile_Creation
echo Please select from the following options to select a server to overwrite
echo 1 - The Hive
echo 2 - Lifeboat
echo 3 - cubecraft
echo 4 - mineville
echo 5 - Galaxite

set /p input=Server Choice: 

echo .:53 {>Corefile.txt
echo    hosts {>>Corefile.txt

if %input%==1 (
echo The Hive selected
echo       {$MINECRAFT_SERVER} geo.hivebedrock.network # The Hive>>Corefile.txt
) else if %input%==2 (
echo Lifeboat selected
echo       {$MINECRAFT_SERVER} mco.lbsg.net # Lifeboat>>Corefile.txt
) else if %input%==3 (
echo cubecraft selected
echo       {$MINECRAFT_SERVER} mco.cubecraft.net # cubecraft>>Corefile.txt
)else if %input%==4 (
echo mineville selected
echo       {$MINECRAFT_SERVER} play.inpvp.net # mineville>>Corefile.txt
) else if %input%==5 (
echo Galaxite selected
echo       {$MINECRAFT_SERVER} play.galaxite.net # Galaxite>>Corefile.txt
) else (
echo       {$MINECRAFT_SERVER} mco.lbsg.net # Lifeboat>>Corefile.txt
echo Input not recognized, defaulting to lifeboat
)

echo       fallthrough>>Corefile.txt
echo    }>>Corefile.txt
echo    forward . {$COREDNS_DEFAULT_DNS}:53>>Corefile.txt
echo }>>Corefile.txt
goto Corefile_Completed


:Default_DNS_Setter
echo Please enter a default DNS provider
echo 8.8.8.8 for Google
echo 1.1.1.1 for Cloudflare
set /p COREDNS_DEFAULT_DNS=""
setx COREDNS_DEFAULT_DNS "%COREDNS_DEFAULT_DNS%"
goto DNS_Completed


:Minecraft_Server_Setter
echo Please enter the domain name or IP address of your server
set /p MINECRAFT_SERVER=
setx MINECRAFT_SERVER "%MINECRAFT_SERVER%"
goto Minecraft_Server_Completed


:end
pause
