from pydub import AudioSegment
import os

def convert_audio_file(path: str):
    print("sono in convert")
    sound = AudioSegment.from_file(path)
    sound.export("audio.flac", format = "flac")
    

def unisci_mp3(file1, file2):
    audio1 = AudioSegment.from_mp3(file1)
    audio2 = AudioSegment.from_mp3(file2)

    # Unisci i due file
    audio_completo = audio1 + audio2

    # Salva il file risultante
    audio_completo.export(file1, format="mp3")
