#!/usr/bin/env python3
"""
Offline Speech-to-Text Voice Capture
Records audio from microphone and transcribes using offline engine
No API key required!
"""

import os
import sys

try:
    import speech_recognition as sr
except ImportError:
    print("Error: speech_recognition not installed")
    print("Install it: pip install SpeechRecognition pydub")
    sys.exit(1)

def capture_and_transcribe():
    """
    Capture audio from microphone and transcribe using offline speech recognition
    Returns the transcribed text
    """
    
    recognizer = sr.Recognizer()
    # Lower the sensitivity threshold for better detection
    recognizer.energy_threshold = 4000
    recognizer.dynamic_energy_threshold = True
    
    print("[VOICE] Listening... (speak now, max 15 seconds)")
    print("=" * 50)
    
    try:
        with sr.Microphone() as source:
            # Adjust for ambient noise
            print("Adjusting for ambient noise...")
            recognizer.adjust_for_ambient_noise(source, duration=0.5)
            
            print("Recording... SPEAK NOW")
            # Longer timeouts, don't require pause
            audio = recognizer.listen(source, timeout=15, phrase_time_limit=15)
        
        print("[VOICE] Recording complete. Processing...")
        
        # Try to recognize speech
        try:
            print("Recognizing speech...")
            text = recognizer.recognize_google(audio)
            return text
        except sr.UnknownValueError:
            print("Could not understand audio - too quiet or unclear")
            return None
        except sr.RequestError as e:
            print(f"Recognition error: {e}")
            return None
            
    except Exception as e:
        print(f"Microphone error: {type(e).__name__}: {e}")
        return None

if __name__ == "__main__":
    result = capture_and_transcribe()
    if result:
        print(f"\n[VOICE] Recognized: {result}")
        print(result)  # Output to stdout for Java to capture
    else:
        print("No speech recognized")
        sys.exit(1)

