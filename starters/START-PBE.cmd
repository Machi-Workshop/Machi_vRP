@echo off
title AURA SERVER - PBE RUNNER
cd ../
powershell "%~dp0..\core\FXServer +set citizen_dir %~dp0..\core\citizen\ %* +exec ./configs/server-pbe.cfg +set onesync on +set onesync_forceMigration true +set onesync_population false +set sv_enforceGameBuild 2372