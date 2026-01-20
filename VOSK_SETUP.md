# Vosk Speech Recognition Setup

This document guides you through enabling **real speech-to-text** microphone capture for the Voice Recognition System.

## Quick Start: 5 Minutes

### 1. Download Vosk Model (Choose One)

**Option A: Small Model (Recommended - Fast)**
- Download: https://alphacephei.com/vosk/models/vosk-model-small-en-us-0.15.zip
- Size: ~90 MB
- Speed: Very fast

**Option B: Larger Model (More Accurate)**
- Download: https://alphacephei.com/vosk/models/vosk-model-en-us-0.22-lgraph.zip
- Size: ~150 MB
- Speed: Slower but better accuracy

### 2. Extract and Place Model

1. Extract the ZIP file (you'll see a folder like `vosk-model-small-en-us-0.15` or `vosk-model-en-us-0.22-lgraph`)
2. Create a folder structure in the project:
   ```
   voice-recognition-system/
   └── models/
       └── vosk-model/     ← Renamed folder goes here
   ```

3. Rename the extracted folder to `vosk-model` and place it inside `models/` directory

**Windows PowerShell example:**
```powershell
# Navigate to project
cd "C:\Users\ranji\OneDrive\Desktop\voice based\voice-recognition-system"

# Create models folder if it doesn't exist
if (!(Test-Path "models")) { mkdir "models" }

# Extract and rename (adjust paths to your download location)
Expand-Archive "C:\Users\ranji\Downloads\vosk-model-small-en-us-0.15.zip" "models\"
Rename-Item "models\vosk-model-small-en-us-0.15" "models\vosk-model"
```

### 3. Verify Setup

```bash
# From project root
mvn clean compile
```

Look for output:
```
Vosk model loaded from: ./models/vosk-model
```

If you see this, **you're done!** Vosk is ready.

### 4. Run Demo with Real Voice Input

```powershell
cd "C:\Users\ranji\OneDrive\Desktop\voice based\voice-recognition-system"
.\run-demo.bat
```

When prompted, **speak clearly**:
> "Roll number 25 Subject Operating Systems marks 18"

The system will:
1. **Capture audio** from your microphone
2. **Convert speech to text** using Vosk (offline)
3. **Parse** roll number, subject, marks
4. **Validate** the input
5. **Save** to database

---

## How It Works

### Audio Flow
```
Microphone
    ↓
AudioRecorder (16kHz PCM)
    ↓
SpeechRecognitionEngine
    ↓
Vosk Recognizer (offline)
    ↓
Text Output ("Roll number 25...")
    ↓
ValidationManager (parse & validate)
    ↓
Database Save
```

### Why Vosk?
- ✅ **Offline**: No internet required, privacy-safe
- ✅ **Fast**: Lightweight model runs on CPU
- ✅ **Accurate**: Good for command-style speech
- ✅ **Free**: Open-source, no API keys needed

---

## Troubleshooting

### Error: "Vosk model not loaded"

**Cause:** Model folder not found or incorrect path

**Solution:**
1. Verify folder structure:
   ```
   voice-recognition-system/
   └── models/
       └── vosk-model/     ← Must exist with this exact name
   ```

2. Check file permissions (Windows):
   - Right-click `models/vosk-model` → Properties → Unblock (if it exists)

3. Re-extract model (sometimes ZIP extraction fails):
   - Delete `models/vosk-model`
   - Download and extract fresh

### Error: "UnsatisfiedLinkError" or native library issues

**Cause:** Vosk needs native libraries; Maven should download them automatically

**Solution:**
1. Clean and re-download Maven dependencies:
   ```bash
   mvn clean dependency:download-sources
   ```

2. Ensure you have JDK 11+ with C++ runtime (Windows):
   - Download: https://support.microsoft.com/en-us/help/2977003
   - Run installer

### Microphone not working in demo

**Solution:**
1. Check microphone is connected and enabled:
   - Windows: Settings → Sound → Input devices
   
2. Run demo and grant microphone permission:
   - Windows may prompt "Allow this app to access microphone?"
   - Click **Yes**

3. Test microphone independently:
   ```powershell
   # Windows voice recorder
   Start-Process ms-windows-store://pdp/?productid=9NBLGGH4NNS1
   ```

---

## Testing Commands

Once Vosk is setup, try these voice commands:

### ✅ Valid Commands (will save)
- "Roll number 25 Subject Operating Systems marks 18"
- "Roll 42 Subject Database marks 15"
- "Roll 101 Subject Algorithms marks 19"

### ❌ Invalid Commands (will show errors)
- "Roll number 10000 Subject OS marks 18" (roll # too high)
- "Roll 25 Subject OS marks 25" (marks too high)
- "Just random text" (no structured data)

---

## Advanced: Use a Larger Model

For **better accuracy** with complex subject names or accents:

1. Download the large model:
   https://alphacephei.com/vosk/models/vosk-model-en-us-0.22-lgraph.zip

2. Extract to `models/vosk-model`

3. Recompile:
   ```bash
   mvn clean compile
   ```

**Trade-off:** Larger model = slower recognition (~1–2 sec per utterance)

---

## Next Steps

After Vosk is working:
1. Run the GUI:
   ```bash
   mvn exec:java -Dexec.mainClass="com.voicerecognition.ui.VoiceRecognitionApp"
   ```

2. Test with real faculty workflows
3. Customize validation rules in `ValidationManager.java`

---

**Questions?** Check the main [TRAINING_GUIDE.md](TRAINING_GUIDE.md) or run `mvn help` for Maven troubleshooting.
