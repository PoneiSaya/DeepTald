from flask import Flask, request, jsonify, send_file
from flask_cors import CORS
import os
from audio_transcript import transcribe_audio
from perseveranza import perseveranza
from logorrea_pensiero_rallentato import compute_final_score_item_logorrea, compute_final_score_item_pensiero_rallentato
from ruminazione import ruminazione
import json
import textwrap
import matplotlib.pyplot as plt
import base64

app = Flask(__name__)

CORS(app)

segments = []
word_count = {}
duration = 0.0
result = []
n_words_doctor = 0
n_words_patient = 0
first_speaker = None


# Ottieni il percorso assoluto del file di script
script_path = os.path.abspath(__file__)

# Costruisci il percorso della cartella AudioTest relativo al file di script
project_path = os.path.dirname(script_path)
audio_folder = 'AudioTest'
upload_folder = os.path.join(project_path, audio_folder)

app.config['UPLOAD_FOLDER'] = upload_folder


@app.route("/upload", methods=["POST"])
def upload_file():
    if 'audio' not in request.files:
        return "Nessun file audio caricato"
    
    file = request.files['audio']
    
    # Verifica se il file è stato effettivamente caricato
    if file.filename == '':
        return "Nessun file selezionato"
    
    # Salva il file audio
    file.save(os.path.join(app.config['UPLOAD_FOLDER'], file.filename))
    
    return "File audio caricato con successo"

@app.route("/start_transcription", methods=["POST"])
def start_transcription():
    # Verifica se il parametro 'audioFileName' è presente nella richiesta
    if 'audioFileName' not in request.form:
        return "Nome del file audio mancante"
    
    # Recupera il nome del file audio dalla richiesta
    audio_file_name = request.form['audioFileName']
    path = './AudioTest/' + audio_file_name
    print(path)
    
    # Esegui la trascrizione dell'audio con il nome del file fornito
    
    global segments,word_count,duration,result, n_words_doctor, n_words_patient, first_speaker

    segments, duration, result, word_count, n_words_doctor, n_words_patient, first_speaker = transcribe_audio(path)

    #session['segments_transcribe'] = segments
    #session['word_count_transcribe'] = word_count

     # Recupera il percorso completo del file di trascrizionee
    transcription_file_path = 'AudioTest/transcript.txt'
    
    # Leggi il contenuto del file di trascrizione
    with open(transcription_file_path, 'r', encoding = 'utf-8') as file:
        transcription_result = file.read()
    
    print('Transcription result', transcription_result)


    # Restituisci il risultato della trascrizione al frontend
    return jsonify({'transcriptionResult': transcription_result})


@app.route("/compute_logorrea", methods=["POST"])
def compute_logorrea():

    with open('metric_value.json', 'r') as f:
        data = json.load(f)

    interruptions_weight = data['interruptions_weight']
    response_length_weight = data['response_length_weight']
    maxValue_response_length = data['max_value_avg_response_length']
    minValue_response_length = data['min_value_avg_response_length']

    score_logorrea, question_count, interruption_count, avg_respons_length, speaking_time_patient = compute_final_score_item_logorrea(
    segments,word_count, float(interruptions_weight),float(response_length_weight), first_speaker,result, 
    int(maxValue_response_length), int(minValue_response_length))

    speaking_time_doctor = duration - speaking_time_patient


    # Valori da visualizzare nel grafico
    labels = ['Duration', 'Speaking Time (Patient)', 'Speaking Time (Doctor)']
    values = [duration, speaking_time_patient, speaking_time_doctor]

    plt.figure(figsize=(8, 4))
    plt.barh(labels, values, color=['blue', 'green', 'orange'])

    plt.xlabel('Time (in sec)')
    plt.title('Interview time (in sec)')
    plt.tight_layout()

    image_path = 'AudioTest/speaking_time_analysis.png'

    # Salvataggio dell'immagine del grafico
    plt.savefig(image_path)


    avg_respons_length = round(avg_respons_length * 10, 1)

    
    return jsonify({'scoreLogorrea': 'Logorrhoea score is : ' + str(score_logorrea),
        'score_logorrea_report': score_logorrea, 'question_count': question_count, 'n_words_doctor': n_words_doctor, 
         'n_words_patient': n_words_patient, 'interruption_count': interruption_count, 'avg_respons_length': avg_respons_length, 
         'duration': duration, 'speaking_time_patient': speaking_time_patient, 'speaking_time_doctor': speaking_time_doctor})



@app.route("/compute_pensiero_rallentato", methods=["POST"])
def pensiero_rallentato():


    with open('metric_value.json', 'r') as f:
        data = json.load(f)

    pause_time_weight = data['pause_time_weight']
    response_time_weight = data['response_time_weight']
    max_value_response_time = data['max_value_avg_response_time']
    min_value_response_time = data['min_value_avg_response_time']

    score_pensiero_rallentato, question_count, pause_between_words, time_response, speaking_time_patient = compute_final_score_item_pensiero_rallentato(result,segments,float(pause_time_weight),float(response_time_weight), first_speaker, int(max_value_response_time), int(min_value_response_time))

    pause_between_words = round(pause_between_words,1)
    time_response = round(time_response,1)

    speaking_time_doctor = duration - speaking_time_patient


    # Valori da visualizzare nel grafico
    labels = ['Duration', 'Speaking Time (Patient)', 'Speaking Time (Doctor)']
    values = [duration, speaking_time_patient, speaking_time_doctor]

    plt.figure(figsize=(8, 4))
    plt.barh(labels, values, color=['blue', 'green', 'orange'])

    plt.xlabel('Time (in sec)')
    plt.title('Interview time (in sec)')
    plt.tight_layout()

    image_path = 'AudioTest/speaking_time_analysis.png'

    # Salvataggio dell'immagine del grafico
    plt.savefig(image_path)

    
    return jsonify({'scorePensieroRallentato': 'Slowed thinking score is : ' + str(score_pensiero_rallentato),
        'score_pensiero_rallentato': score_pensiero_rallentato, 'question_count': question_count, 'n_words_doctor': n_words_doctor, 'n_words_patient': n_words_patient,
        'pause_between_words': pause_between_words, 'time_response': time_response})


@app.route("/get_speaking_time_analysis_image", methods=["GET"])
def get_speaking_time_analysis_image():
    image_path = os.path.join(os.path.dirname(__file__), 'AudioTest', 'speaking_time_analysis.png')
    return send_file(image_path, mimetype='image/png')


@app.route("/compute_perseveranza", methods=["POST"])
def compute_perseveranza():

    if 'transcription' not in request.form:
        return 'Trascrizione mancante'
    
    transcription = request.form['transcription']
    
    corpus = json.loads(transcription)

    formatted_corpus = []
    for phrase in corpus:
        formatted_phrase = phrase.strip('"')
        formatted_phrase = formatted_phrase.replace("'", "\'").replace("’", "\'")
        formatted_corpus.append(formatted_phrase)

    formatted_text = '\n'.join(formatted_corpus)
    
    
    score_perseveranza, counter_question, topics_dict, counter = perseveranza(formatted_corpus)


    result_string = ""
    first_topic = True

    for topic, sentences in topics_dict.items():
        
        if first_topic:
            result_string += f"{topic.rstrip(',')}:\n"
        else:
            result_string += textwrap.indent(f"{topic.rstrip(',')}:\n","        ")
        
        for sentence in sentences:
            if sentence != topic:
                result_string += textwrap.indent(f"- {sentence.rstrip(',')}\n","       ")
        
        result_string += "\n"
        first_topic = False
    
    return jsonify({'scorePerseveranza': 'Perseverance score is : ' + str(score_perseveranza),
         'score_perseveranza': score_perseveranza, 'counter_question': counter_question, 'counter': counter, 'result_string': result_string})



@app.route("/compute_ruminazione", methods=["POST"])
def compute_ruminazione():

    if 'transcription' not in request.form:
        return 'Trascrizione mancante'
    
    transcription = request.form['transcription']
    
    corpus = json.loads(transcription)

    formatted_corpus = []
    for phrase in corpus:
        formatted_phrase = phrase.strip('"')
        formatted_phrase = formatted_phrase.replace("'", "\'").replace("’", "\'")
        formatted_corpus.append(formatted_phrase)


    score_ruminazione, counter_question, counter, topics_dict, sentiment_dict = ruminazione(formatted_corpus)


    result_string_sentiment = ""

    for sentence, sentiment in sentiment_dict.items():
        
        result_string_sentiment += textwrap.indent(f"{sentence.rstrip(',')} --> {sentiment}\n","       ")


    result_string_topic = ""
    first_topic = True

    for topic, sentences in topics_dict.items():
        
        if first_topic:
            result_string_topic += f"{topic.rstrip(',')}:\n"
        else:
            result_string_topic += textwrap.indent(f"{topic.rstrip(',')}:\n","        ")
        
        for sentence in sentences:
            if sentence != topic:
                result_string_topic += textwrap.indent(f"- {sentence.rstrip(',')}\n","       ")
        
        result_string_topic += "\n"
        first_topic = False


    return jsonify({'scoreRuminazione': 'Rumination score is : ' + str(score_ruminazione),
        'score_ruminazione': score_ruminazione, 'result_string_sentiment': result_string_sentiment, 'result_string_topic': result_string_topic, 'counter_question': counter_question, 'counter': counter})


@app.route("/fetch_parametri_logorrea", methods=["POST"])
def fetch_parametri_logorrea():


    with open('metric_value.json', 'r') as f:
        data = json.load(f)

        interruptions_weight = data['interruptions_weight']
        response_length_weight = data['response_length_weight']
        max_value_avg_response_length = data["max_value_avg_response_length"]


    return jsonify({'interruptions_weight': interruptions_weight, 'response_length_weight': response_length_weight,
                    'max_value_avg_response_length': max_value_avg_response_length})

@app.route("/fetch_parametri_pensiero_rallentato", methods=["POST"])
def fetch_parametri_pensiero_rallentato():

    with open('metric_value.json', 'r') as f:
        data = json.load(f)

        pause_time_weight = data['pause_time_weight']
        response_time_weight = data['response_time_weight']
        max_value_response_time = data['max_value_avg_response_time']

    return jsonify({'pause_time_weight': pause_time_weight, 'response_time_weight': response_time_weight, 'max_value_avg_response_time': max_value_response_time})

@app.route("/modifica_parametri_logorrea", methods=["POST"])
def modifica_parametri_logorrea():


    new_interruption_weights = request.form['new_interruptions_weight']
    new_responseLength_weight = request.form['new_responseLength_weight']
    new_maxValue_responseLength = request.form['new_maxValue_responseLength']

    

    with open('metric_value.json', 'r') as f:
        data = json.load(f)


        data['interruptions_weight'] =  new_interruption_weights
        data['response_length_weight'] = new_responseLength_weight
        data['max_value_avg_response_length'] = new_maxValue_responseLength
    

    with open('metric_value.json', 'w') as f:
        
        json.dump(data,f,indent=4)

    return jsonify({'message': 'Modifiche effettuate correttamente'}), 200

@app.route("/modifica_parametri_pensiero_rallentato", methods=["POST"])
def modifica_parametri_pensiero_rallentato():


    new_pause_time_weights = request.form['new_pause_time_weight']
    new_response_time_weight = request.form['new_response_time_weight']
    new_maxValue_responseTime = request.form['new_maxValue_response_time']

    

    with open('metric_value.json', 'r') as f:
        data = json.load(f)


        data['pause_time_weight'] =  new_pause_time_weights
        data['response_time_weight'] = new_response_time_weight
        data['max_value_avg_response_time'] = new_maxValue_responseTime

    

    with open('metric_value.json', 'w') as f:
        
        json.dump(data,f,indent=4)

    return jsonify({'message': 'Modifiche effettuate correttamente'}), 200

@app.route("/receive_report_feedback", methods=["POST"])
def receive_report_feedback():


    itemChecked = request.form['itemChecked']

    responseFirstQuestion = request.form['responseFirstQuestion']

    responseSecondQuestion = request.form['responseSecondQuestion']

    responseThirdQuestion = request.form['responseThirdQuestion']


    # Carica il file JSON
    with open('feedbackItem.json', 'r') as json_file:
        data = json.load(json_file)

    # Trova l'oggetto corrispondente all'itemChecked
    item = next((i for i in data['item'] if i['nome'] == itemChecked), None)

    if item:
        for domanda in item['domande']:
            risposta = None
            if domanda['testo'] == "Domanda 1":
                risposta = next((r for r in domanda['risposte'] if r['testo'] == responseFirstQuestion), None)
            elif domanda['testo'] == "Domanda 2":
                risposta = next((r for r in domanda['risposte'] if r['testo'] == responseSecondQuestion), None)
            elif domanda['testo'] == "Domanda 3":
                risposta = next((r for r in domanda['risposte'] if r['testo'] == responseThirdQuestion), None)

            if risposta:
                risposta['contatore'] += 1

    # Scrivi le modifiche nel file JSON
    with open('feedbackItem.json', 'w') as json_file:
        json.dump(data, json_file, indent=4)

    return jsonify({'message': 'Feedback aggiunto correttamente'}), 200
   


if __name__ == "__main__":
    app.run(port=5000, debug=True)