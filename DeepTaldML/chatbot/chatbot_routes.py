import flask
from flask import request, jsonify
from flask import Response
import speech_recognition as sr
from pydub import AudioSegment
import os
import chatbot_utils as utils
import tinyllama as lama

app = flask.Flask(__name__)

r = sr.Recognizer()

@app.route("/transcribe_audio", methods=["POST"])
def transcribe_audio():
    print("SONO NEL PYTONE 2")
    if 'audio' not in request.files:
        print(request.files)
        return "Nessun file audio caricato"
    
    file = request.files['audio']

    # Verifica se il file è stato effettivamente caricato
    if file.filename == '':
        return "Nessun file selezionato"

    file.save("audio.mp3")

    utils.convert_audio_file()

    
    msg = sr.AudioFile("./audio.flac")
    with msg as source:
        audio = r.record(source)
        text = r.recognize_google(audio_data = audio, language = "it-IT")
        return lama.creaDomanda()
    

    return "Problemi"


if __name__ == "__main__":
    app.run(host="172.19.190.93" , port=9000, debug=True)