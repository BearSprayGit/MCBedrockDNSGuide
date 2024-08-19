@echo off
echo Please enter a default DNS provider
echo 8.8.8.8 for Google
echo 1.1.1.1 for Cloudflare
set /p COREDNS_DEFAULT_DNS=
echo Please enter the domain name or IP address of your server
set /p MINECRAFT_SERVER=
coredns -conf Corefile.txt -dns.port=53
pause
