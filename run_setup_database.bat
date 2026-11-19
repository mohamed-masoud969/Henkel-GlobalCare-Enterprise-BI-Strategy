@echo off
chcp 65001 >nul
color 0A
title GlobalCare Industries - SQL Server Database Setup

echo ===============================================================================
echo        GlobalCare Industries (Henkel Case Study) - Database Installer
echo ===============================================================================
echo.
echo  This script will automatically create the database [GlobalCareDB]
echo  and insert all 14 tables (52,495+ records) into your Microsoft SQL Server.
echo.
echo ===============================================================================
echo  Select your SQL Server Instance:
echo.
echo    [1] Default Instance (.) / localhost  - (MSSQLSERVER is RUNNING)
echo    [2] Named Instance  (.\SQLEXPRESS)    - (SQLEXPRESS is RUNNING)
echo    [3] Enter custom Server / Instance Name
echo.
echo ===============================================================================

set /p choice="Enter choice [1, 2, or 3] (Default is 1): "

if "%choice%"=="" set choice=1
if "%choice%"=="1" set SERVER_NAME=.
if "%choice%"=="2" set SERVER_NAME=.\SQLEXPRESS
if "%choice%"=="3" (
    set /p SERVER_NAME="Enter SQL Server Name (e.g. localhost or DESKTOP-XXX): "
)

echo.
echo -------------------------------------------------------------------------------
echo  Connecting to server: %SERVER_NAME%
echo  Running script: GlobalCare_FullDatabase.sql ...
echo  Please wait, this will take about 20-40 seconds...
echo -------------------------------------------------------------------------------
echo.

set SCRIPT_PATH=%~dp0GlobalCare_FullDatabase.sql

sqlcmd -S "%SERVER_NAME%" -E -i "%SCRIPT_PATH%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ===============================================================================
    echo  SUCCESS! Database [GlobalCareDB] and all 14 tables created successfully!
    echo ===============================================================================
    echo.
    echo  You can now open SQL Server Management Studio (SSMS), connect to:
    echo  Server: %SERVER_NAME%
    echo  And explore the database [GlobalCareDB].
    echo.
) else (
    echo.
    echo ===============================================================================
    echo  [ERROR] Execution failed with error code %ERRORLEVEL%.
    echo  Please check if SQL Server is running or if the instance name is correct.
    echo ===============================================================================
    echo.
)

pause
