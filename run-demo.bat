@echo off
REM Voice Recognition Demo - Direct Java Compilation and Execution
REM This script compiles and runs the demo without Maven

echo.
echo ============================================================
echo    VOICE RECOGNITION SYSTEM - IA MARKS DEMO
echo ============================================================
echo.

REM Check if Java is installed
java -version >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install JDK 11+ from https://www.oracle.com/java/
    pause
    exit /b 1
)

echo [1/3] Compiling source code...
echo.

REM Create output directories
if not exist "target\classes" mkdir "target\classes"

REM Compile all source files
javac -d target\classes -encoding UTF-8 ^
    src\main\java\com\voicerecognition\model\VoiceCommand.java ^
    src\main\java\com\voicerecognition\model\IAMarks.java ^
    src\main\java\com\voicerecognition\validation\ValidationResult.java ^
    src\main\java\com\voicerecognition\validation\ValidationManager.java ^
    src\main\java\com\voicerecognition\demo\VoiceRecognitionDemo.java

if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Compilation failed
    pause
    exit /b 1
)

echo [2/3] Compilation successful!
echo.
echo [3/3] Running Voice Recognition Demo...
echo.
echo ============================================================
echo.

REM Run the demo
java -cp target\classes com.voicerecognition.demo.VoiceRecognitionDemo

pause
