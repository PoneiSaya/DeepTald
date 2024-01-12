import flask
from flask import request, jsonify
from flask import Response
import speech_recognition as sr
from pydub import AudioSegment
import os
import chatbot_utils as utils
import chatgpt as bot

app = flask.Flask(__name__)

r = sr.Recognizer()




@app.route("/make_message", methods=["POST"])
def make_message():
    print("SONO NEL PYTONE 2")

    
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
        print("testo = " + text)
        print("ora sta chiamando llama")
        return bot.creaDomandaConContesto(text)
    return "Problemi"


@app.route("/start_conversation", methods=["POST"])
def start_conversation():
    print("SONO NEL PYTONE 2")
    return bot.creaDomanda()



if __name__ == "__main__":
    
    app.run(host='192.168.1.131', port = 9099, debug=True)