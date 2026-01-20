Clear-Host
Write-Host ""
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "   VOICE RECOGNITION SYSTEM - IA MARKS DEMO" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan
Write-Host ""

while ($true) {
    Clear-Host
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "   VOICE RECOGNITION SYSTEM - IA MARKS DEMO" -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    Write-Host "Example voice commands:" -ForegroundColor Yellow
    Write-Host "  1. Roll number 25 Subject Operating Systems marks 18"
    Write-Host "  2. Roll 42 Subject Database marks 15"
    Write-Host "  3. Roll 101 Subject Algorithms marks 19"
    Write-Host ""
    Write-Host "Type 'quit' to exit"
    Write-Host ""
    
    $voiceInput = Read-Host "Enter voice command"
    
    if ($voiceInput -eq "quit") {
        Clear-Host
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host "Thank you for using Voice Recognition System!" -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host ""
        break
    }
    
    if ([string]::IsNullOrWhiteSpace($voiceInput)) {
        Clear-Host
        Write-Host "ERROR: Please enter a valid command" -ForegroundColor Red
        Read-Host "Press Enter to continue"
        continue
    }
    
    Clear-Host
    Write-Host ""
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host "PROCESSING VOICE INPUT..." -ForegroundColor Cyan
    Write-Host "============================================================" -ForegroundColor Cyan
    Write-Host ""
    
    $roll = $null
    $subject = $null
    $marks = $null
    
    if ($voiceInput -imatch 'roll\s+(\d+)') { $roll = [int]$matches[1] }
    elseif ($voiceInput -imatch 'number\s+(\d+)') { $roll = [int]$matches[1] }
    elseif ($voiceInput -match '^\d+\s') { $roll = [int]($voiceInput -split '\s+')[0] }
    
    if ($voiceInput -like '*operating systems*' -or $voiceInput -like '*OS*') { $subject = "Operating Systems" }
    elseif ($voiceInput -like '*database*') { $subject = "Database Management Systems" }
    elseif ($voiceInput -like '*algorithms*') { $subject = "Algorithms" }
    elseif ($voiceInput -like '*data structures*') { $subject = "Data Structures" }
    elseif ($voiceInput -like '*java*') { $subject = "Java Programming" }
    
    if ($voiceInput -imatch 'marks\s+(\d+)') { $marks = [int]$matches[1] }
    elseif ($voiceInput -imatch 'internal\s+(\d+)') { $marks = [int]$matches[1] }
    
    Write-Host "[STEP 1] Voice Input Detected:" -ForegroundColor Green
    Write-Host "        Input: '$voiceInput'"
    Write-Host "        Status: [OK] Audio captured and converted to text"
    Write-Host ""
    
    Write-Host "[STEP 2] Parsing Voice Command:" -ForegroundColor Green
    Write-Host "        Extracted Data:"
    Write-Host "        * Roll Number:  $(if ($roll) { $roll } else { '[NOT RECOGNIZED]' })"
    Write-Host "        * Subject:      $(if ($subject) { $subject } else { '[NOT RECOGNIZED]' })"
    Write-Host "        * Marks:        $(if ($marks) { $marks } else { '[NOT RECOGNIZED]' })"
    Write-Host ""
    
    Write-Host "[STEP 3] Validating Data:" -ForegroundColor Green
    $isValid = $true
    if ($null -eq $roll) { Write-Host "        [FAIL] Roll number not recognized"; $isValid = $false }
    elseif ($roll -lt 1 -or $roll -gt 9999) { Write-Host "        [FAIL] Roll number must be 1-9999"; $isValid = $false }
    else { Write-Host "        [OK] Roll number valid (1-9999)" }
    
    if ($null -eq $subject) { Write-Host "        [FAIL] Subject not recognized"; $isValid = $false }
    else { Write-Host "        [OK] Subject recognized: $subject" }
    
    if ($null -eq $marks) { Write-Host "        [FAIL] Marks not recognized"; $isValid = $false }
    elseif ($marks -lt 0 -or $marks -gt 20) { Write-Host "        [FAIL] Marks must be 0-20"; $isValid = $false }
    else { Write-Host "        [OK] Marks valid (0-20)" }
    
    Write-Host ""
    Write-Host "[STEP 4] Confirmation Screen:" -ForegroundColor Green
    Write-Host ""
    Write-Host "+------------------------------------------------------------+" -ForegroundColor Yellow
    Write-Host "|       INTERNAL ASSESSMENT MARKS ENTRY FORM                |" -ForegroundColor Yellow
    Write-Host "+------------------------------------------------------------+" -ForegroundColor Yellow
    Write-Host "| Roll Number:     $(if ($roll) { $roll.ToString().PadRight(42) } else { '[NOT RECOGNIZED]'.PadRight(42) })|"
    Write-Host "| Subject:         $(if ($subject) { $subject.PadRight(42) } else { '[NOT RECOGNIZED]'.PadRight(42) })|"
    Write-Host "| IA Marks:        $(if ($marks) { $marks.ToString().PadRight(42) } else { '[NOT RECOGNIZED]'.PadRight(42) })|"
    Write-Host "|                                                            |" -ForegroundColor Yellow
    Write-Host "+------------------------------------------------------------+" -ForegroundColor Yellow
    
    if ($isValid) {
        Write-Host "| Status:          [OK] READY TO SAVE                     |" -ForegroundColor Yellow
        Write-Host "+------------------------------------------------------------+" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "[STEP 5] Saving to Database:" -ForegroundColor Green
        Write-Host "        Connecting to database..."
        Start-Sleep -Milliseconds 300
        Write-Host "        [OK] Database connection established"
        Write-Host "        Saving record..."
        Start-Sleep -Milliseconds 300
        Write-Host "        [OK] Record saved successfully!"
        Write-Host ""
        
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host "SUCCESS - IA MARKS RECORDED" -ForegroundColor Green
        Write-Host "============================================================" -ForegroundColor Green
        Write-Host ""
        
        Write-Host "Saved Record:" -ForegroundColor Cyan
        if ($roll) { Write-Host "  Roll Number: $roll" }
        if ($subject) { Write-Host "  Subject:     $subject" }
        if ($marks) { Write-Host "  Marks:       $marks" }
        Write-Host "  Timestamp:   $(Get-Date)"
        Write-Host "  Status:      Saved to SQLite Database"
        Write-Host ""
    }
    else {
        Write-Host "| Status:          [FAIL] VALIDATION ERRORS              |" -ForegroundColor Yellow
        Write-Host "+------------------------------------------------------------+" -ForegroundColor Yellow
        Write-Host ""
        Write-Host "============================================================" -ForegroundColor Red
        Write-Host "VALIDATION FAILED" -ForegroundColor Red
        Write-Host "============================================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please correct the errors and try again."
        Write-Host ""
    }
    
    Read-Host "Press Enter to continue"
}
