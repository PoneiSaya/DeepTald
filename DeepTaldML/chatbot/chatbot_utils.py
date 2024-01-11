from pydub import AudioSegment
import os

def convert_audio_file():
    print("sono in convert")
    sound = AudioSegment.from_file("./audio.mp3")
    sound.export("audio.flac", format = "flac")
    os.remove("./audio.mp3")