import flask
from flask import redirect, request, jsonify
from flask import Response
import requests
import speech_recognition as sr
from pydub import AudioSegment
import os
import chatbot_utils as utils
import chatgpt as bot
from gtts import gTTS
from pydub.generators import Sine

app = flask.Flask(__name__)

r = sr.Recognizer()

@app.route("/make_message", methods=["POST"])
def make_message():
    ##todo ID UTENTE
    file = request.files['audio']
    codiceFiscale = request.form.get('codiceFiscale')
    counter = request.form.get('counter')

    # Verifica se il file è stato effettivamente caricato
    if file.filename == '':
        return "Nessun file selezionato"

    counter_int = int(counter)
    #file.save(f'./audio/{codiceFiscale}/risposta_{counter_int-1}.mp3') #salviamo l'audio 
    file.save("audio.mp3")

    # Carica il file audio
    audio = AudioSegment.from_file("audio.mp3")

    # Imposta il formato di output come MP3
    output_format = "mp3"

    # Esporta l'oggetto AudioSegment nel formato MP3
    audio.export(f'./audio/{codiceFiscale}/risposta_{counter_int-1}.mp3', format=output_format)

    utils.convert_audio_file(f'./audio/{codiceFiscale}/risposta_{counter_int-1}.mp3')
    msg = sr.AudioFile("./audio.flac")


    with msg as source:
        audio = r.record(source)
        text = r.recognize_google(audio_data = audio, language = "it-IT")
        print("testo = " + text)
        print("ora sta chiamando il chatbot")
        domanda = bot.creaDomandaConContesto(text)

        tts = gTTS(domanda, lang='it')
        tts.save(f'./audio/{codiceFiscale}/domanda_{counter}.mp3')
    
        return domanda
    return "Problemi"


@app.route("/start_conversation", methods=["POST"])
def start_conversation():
    print(request)
    codiceFiscale = request.form.get('codiceFiscale')

    print(f"ID = {codiceFiscale}\n\n\n")
    domanda = bot.creaDomanda()
    tts = gTTS(domanda, lang='it')
    if not os.path.isdir(f"./audio/{codiceFiscale}") :
        os.mkdir(f"./audio/{codiceFiscale}")

    tts.save(f'./audio/{codiceFiscale}/domanda_0.mp3')

    return domanda


@app.route("/terminate_conversation", methods=["POST"])
def terminate_conversation():
    codiceFiscale = request.form.get('codiceFiscale')
    
    if not os.path.isdir(f"./audio/{codiceFiscale}") :
        raise "ERRORE"

    counter = 0
    path = f"./audio/{codiceFiscale}/"

    output_file = path + "risultato.mp3"
    empty_audio = Sine(0).to_audio_segment(duration=1 * 1000)
    empty_audio.export(output_file, format="mp3")


    while(True):
        print("SONO NEL WHILE")
        if os.path.isfile(path+f"domanda_{counter}.mp3") and os.path.isfile(path+f"risposta_{counter}.mp3"):
            utils.unisci_mp3(output_file, path+f"domanda_{counter}.mp3")
            utils.unisci_mp3(output_file, path+f"risposta_{counter}.mp3")
            os.remove(path+f"domanda_{counter}.mp3")
            os.remove(path+f"risposta_{counter}.mp3")
            counter += 1
        else:
            break
            
    #chiamare modello  
    
    

    return "FATTO"




if __name__ == "__main__":
    app.run(host='172.19.139.25', port = 9099, debug=True)