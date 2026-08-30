@echo off
echo ========================================
echo   Premium Gym Website - Deployment Script
echo ========================================
echo.

echo Step 1: Checking if WAR file exists...
if exist "target\gym-website.war" (
    echo [SUCCESS] WAR file found: target\gym-website.war
) else (
    echo [ERROR] WAR file not found. Please run 'mvn package' first.
    pause
    exit /b 1
)

echo.
echo Step 2: Checking for Tomcat installation...
set TOMCAT_FOUND=0

REM Check common Tomcat locations
if exist "C:\Program Files\Apache Software Foundation\Tomcat" (
    set TOMCAT_PATH=C:\Program Files\Apache Software Foundation\Tomcat
    set TOMCAT_FOUND=1
)

if exist "C:\Program Files\Tomcat" (
    set TOMCAT_PATH=C:\Program Files\Tomcat
    set TOMCAT_FOUND=1
)

if exist "C:\tomcat" (
    set TOMCAT_PATH=C:\tomcat
    set TOMCAT_FOUND=1
)

if %TOMCAT_FOUND%==1 (
    echo [SUCCESS] Tomcat found at: %TOMCAT_PATH%
) else (
    echo [WARNING] Tomcat not found in standard locations.
    echo Please install Apache Tomcat or specify the path manually.
    echo.
    echo Download Tomcat from: https://tomcat.apache.org/download-90.cgi
    echo.
    echo After installation, you can deploy the WAR file by:
    echo 1. Copy target\gym-website.war to %TOMCAT_PATH%\webapps\
    echo 2. Start Tomcat using: %TOMCAT_PATH%\bin\startup.bat
    echo 3. Access the application at: http://localhost:8080/gym-website/
    pause
    exit /b 0
)

echo.
echo Step 3: Deploying WAR file...
copy "target\gym-website.war" "%TOMCAT_PATH%\webapps\"

if %errorlevel%==0 (
    echo [SUCCESS] WAR file deployed successfully!
) else (
    echo [ERROR] Failed to deploy WAR file.
    pause
    exit /b 1
)

echo.
echo Step 4: Starting Tomcat...
echo Starting Tomcat server...
start "" "%TOMCAT_PATH%\bin\startup.bat"

echo.
echo ========================================
echo   DEPLOYMENT COMPLETE!
echo ========================================
echo.
echo Please wait a few moments for Tomcat to start...
echo Then access the application at: http://localhost:8080/gym-website/
echo.
echo To stop Tomcat, run: %TOMCAT_PATH%\bin\shutdown.bat
echo.
echo Press any key to open the application in your browser...
pause > nul

echo Opening browser...
start http://localhost:8080/gym-website/

pause
