@echo off
REM Voice Recognition System - Simple Interactive Demo
REM Pure batch script - No external dependencies needed

setlocal enabledelayedexpansion

:menu
cls
echo.
echo ============================================================
echo    VOICE RECOGNITION SYSTEM - IA MARKS ENTRY DEMO
echo ============================================================
echo.
echo This demo simulates voice input detection and processes
echo Internal Assessment marks using voice commands.
echo.
echo Example commands to try:
echo   Roll number 25 Subject Operating Systems marks 18
echo   Roll 42 Subject Database Management 15
echo   Roll 101 Subject Algorithms 19
echo.
echo Type 'quit' to exit
echo.
echo ============================================================
echo.
set /p input="Enter voice command: "

if /i "%input%"=="quit" (
    echo.
    echo Thank you for using Voice Recognition System!
    timeout /t 2 >nul
    exit /b 0
)

if "%input%"=="" (
    echo.
    echo ERROR: Please enter a valid command
    timeout /t 2 >nul
    goto start
)

cls
echo.
echo ============================================================
echo PROCESSING VOICE INPUT...
echo ============================================================
echo.

REM STEP 1: Voice Detection
echo [STEP 1] Voice Input Detected:
echo.
echo         Input: '%input%'
echo         Status: ✓ Audio captured and converted to text
echo.
timeout /t 1 >nul

REM STEP 2: Parse the input
echo [STEP 2] Parsing Voice Command:
echo.

REM Simple parsing (check for key numbers and subjects)
set roll_found=0
set subject_found=
set marks_found=0

REM Check for roll number pattern
for /f "tokens=*" %%a in ('powershell -Command "if ('%input%' -match '(?:roll\s*(?:number)?|r\.?n\.?)\s+(\d{1,4})') { [regex]::Matches('%input%', '(?:roll\s*(?:number)?|r\.?n\.?)\s+(\d{1,4})')[0].Groups[1].Value }"') do (
    if not "%%a"=="" (
        set roll=%%a
        set roll_found=1
    )
)

REM Check for subject
if "%input%" I "Operating Systems" set subject_found=Operating Systems
if "%input%" I "Database" set subject_found=Database Management Systems
if "%input%" I "Algorithms" set subject_found=Algorithms
if "%input%" I "Data Structures" set subject_found=Data Structures
if "%input%" I "Java" set subject_found=Java Programming
if "%input%" I "Python" set subject_found=Python Programming

REM Check for marks
for /f "tokens=*" %%a in ('powershell -Command "if ('%input%' -match '(?:marks?|internal|ia)\s+(\d{1,2})') { [regex]::Matches('%input%', '(?:marks?|internal|ia)\s+(\d{1,2})')[0].Groups[1].Value }"') do (
    if not "%%a"=="" (
        set marks=%%a
        set marks_found=1
    )
)

REM Display extracted data
echo         Extracted Data:
if %roll_found%==1 (
    echo         • Roll Number:  !roll!
) else (
    echo         • Roll Number:  [NOT RECOGNIZED]
)

if not "%subject_found%"=="" (
    echo         • Subject:      %subject_found%
) else (
    echo         • Subject:      [NOT RECOGNIZED]
)

if %marks_found%==1 (
    echo         • Marks:        !marks!
) else (
    echo         • Marks:        [NOT RECOGNIZED]
)

echo.
timeout /t 1 >nul

REM STEP 3: Validate
echo [STEP 3] Validating Data:
echo.

set valid=1
set errors=

if %roll_found%==0 (
    echo         ✗ Roll number not recognized
    set valid=0
) else if !roll! gtr 9999 (
    echo         ✗ Roll number must be between 1 and 9999
    set valid=0
) else if !roll! lss 1 (
    echo         ✗ Roll number must be between 1 and 9999
    set valid=0
) else (
    echo         ✓ Roll number valid (1-9999)
)

if "%subject_found%"=="" (
    echo         ✗ Subject not recognized
    set valid=0
) else (
    echo         ✓ Subject recognized: %subject_found%
)

if %marks_found%==0 (
    echo         ✗ Marks not recognized
    set valid=0
) else if !marks! gtr 20 (
    echo         ✗ Marks must be between 0 and 20
    set valid=0
) else (
    echo         ✓ Marks valid (0-20)
)

echo.
timeout /t 1 >nul

REM STEP 4: Show confirmation
echo [STEP 4] Confirmation Screen:
echo.
echo ┌────────────────────────────────────────────────────────┐
echo │       INTERNAL ASSESSMENT MARKS ENTRY FORM            │
echo ├────────────────────────────────────────────────────────┤

if %roll_found%==1 (
    echo │ Roll Number:     !roll!
) else (
    echo │ Roll Number:     [NOT RECOGNIZED]
)

if not "%subject_found%"=="" (
    echo │ Subject:         %subject_found%
) else (
    echo │ Subject:         [NOT RECOGNIZED]
)

if %marks_found%==1 (
    echo │ IA Marks:        !marks!
) else (
    echo │ IA Marks:        [NOT RECOGNIZED]
)

echo │                                                        │
echo ├────────────────────────────────────────────────────────┤

if %valid%==1 (
    echo │ Status:          ✓ READY TO SAVE                    │
    echo └────────────────────────────────────────────────────┘
    echo.
    timeout /t 1 >nul
    
    REM STEP 5: Save
    echo [STEP 5] Saving to Database:
    echo.
    echo         Connecting to database...
    timeout /t 500 >nul
    echo         ✓ Database connection established
    echo         Saving record...
    timeout /t 500 >nul
    echo         ✓ Record saved successfully!
    echo.
    echo ============================================================
    echo ✓ SUCCESS - IA MARKS RECORDED
    echo ============================================================
    echo.
    if %roll_found%==1 (
        echo Saved Record:
        echo   Roll Number: !roll!
        echo   Subject:     %subject_found%
        echo   Marks:       !marks!
        echo   Timestamp:   %date% %time%
        echo   Status:      Saved to Database
        echo.
    )
) else (
    echo │ Status:          ✗ VALIDATION FAILED                 │
    echo └────────────────────────────────────────────────────────┘
    echo.
    echo ✗ VALIDATION ERRORS FOUND
    echo Please correct the errors and try again.
    echo.
)

pause
goto start
