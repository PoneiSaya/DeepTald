#path = "./AudioTest/DeFilippisTagliato_WNoise.wav"

num_speakers = 2 #@param {type:"integer"}

language = 'any' #@param ['any', 'English']

model_size = 'small' #@param ['tiny', 'base', 'small', 'medium', 'large']


model_name = model_size
if language == 'English' and model_size != 'large':
  model_name += '.en'



import whisper
import datetime
import pprint
import subprocess

import torch
from pyannote.audio.pipelines.speaker_verification import PretrainedSpeakerEmbedding
'''
embedding_model = PretrainedSpeakerEmbedding( 
    "speechbrain/spkrec-ecapa-voxceleb",
    device = torch.device('cpu')
)
'''
from pyannote.audio import Audio
from pyannote.core import Segment
from datetime import timedelta

import wave
import contextlib

from sklearn.cluster import KMeans
import numpy as np

#from sklearn.cluster import AgglomerativeClustering


#device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
#print(device)

#torch.cuda.empty_cache()

#Conversione del file audio nel caso in cui non sia in formato WAV


def transcribe_audio(path):

  print(torch.cuda.is_available())


  embedding_model = PretrainedSpeakerEmbedding( 
    "speechbrain/spkrec-ecapa-voxceleb",
    device = "cuda"
)
  

  if path[-3:] != 'wav':
    subprocess.call(['ffmpeg', '-i', path, 'audio.wav', '-y'])
    path = 'audio.wav'

  # Libera la memoria GPU prima di eseguire model.transcribe()
  torch.cuda.empty_cache()  

  #Carico il modello di speech recognition

  model = whisper.load_model(model_size, device = 'cuda')

  #Eseguo la trascrizione del file audio utilizzando il modello caricato

  result = model.transcribe(path, word_timestamps = 'true')
  #pprint.pprint(result)
  segments = result["segments"]

  with contextlib.closing(wave.open(path,'r')) as f:
    frames = f.getnframes()
    rate = f.getframerate()
    duration = frames / float(rate)

  audio = Audio()

  '''Questa funzione prende in input un segmento audio e restituisce l'embedding corrispondente
  utilizzando un modello di speaker embedding pre-allenato (ECAPA-TDNN). Gli embedding sono necessari per creare
  dei cluster in base allo speaker corrispondente
  '''

  def segment_embedding(segment):
    start = segment["start"]
    
    end = min(duration, segment["end"])
    clip = Segment(start, end)
    waveform, sample_rate = audio.crop(path, clip)
    #return embedding_model(waveform[None])
    return embedding_model(waveform.to('cuda')[None])

  embeddings = np.zeros(shape=(len(segments), 192))
  for i, segment in enumerate(segments):
    embeddings[i] = segment_embedding(segment)

  embeddings = np.nan_to_num(embeddings)



  #clustering = AgglomerativeClustering(num_speakers).fit(embeddings)
  #labels = clustering.labels_
  kmeans = KMeans(n_clusters=num_speakers, random_state=0).fit(embeddings)
  labels = kmeans.labels_
  for i in range(len(segments)):
    segments[i]["speaker"] = 'SPEAKER ' + str(labels[i] + 1)

  word_count = {}

  for (i, segment) in enumerate(segments):
    speaker = segment["speaker"]
    if speaker not in word_count:
      word_count[speaker] = 0
    words = segment["text"].split()
    #print(words)
    word_count[speaker] += len(words)

  n_words_doctor = 0
  n_words_patient = 0
  
  for speaker in word_count:
     if speaker == 'SPEAKER 1':
        n_words_patient = word_count[speaker]
     elif speaker == 'SPEAKER 2':
        n_words_doctor = word_count[speaker]   

  def time(secs):
    return datetime.timedelta(seconds=round(secs))

  f = open("AudioTest/transcript.txt", "w", encoding ='utf-8')

  '''speaker_mapping = {
        'SPEAKER 1': 'MEDICO',
        'SPEAKER 2': 'PAZIENTE'
  }


  for (i, segment) in enumerate(segments):
    if i == 0 or segments[i - 1]["speaker"] != segment["speaker"]:
      f.write("\n" + segment["speaker"] + ' ' + str(time(segment["start"]))  + ' ' + str(time(segment["end"])) + '\n')
    f.write(segment["text"][1:] + ' ')
  f.close()
'''


  def speaker_mapping(first_speaker):

    speaker_mapping = {}

    if first_speaker == "SPEAKER 1":
        
      speaker_mapping = {
        
          'SPEAKER 1': 'CLINICIAN',
          'SPEAKER 2': 'PATIENT'
      }

    else:

      speaker_mapping = {
        'SPEAKER 1': 'PATIENT',
        'SPEAKER 2': 'CLINICIAN'
      }
  
    return speaker_mapping

  first_speaker = None

  for (i, segment) in enumerate(segments):
    if i == 0:
      first_speaker = segment["speaker"]
    speakers_mapping = speaker_mapping(first_speaker)
    speaker = speakers_mapping.get(segment["speaker"], segment["speaker"])
    if i == 0 or segments[i - 1]["speaker"] != segment["speaker"]:
      f.write("\n" + speaker + ' ' + str(time(segment["start"])) + ' ' + str(time(segment["end"])) + '\n')
    f.write(segment["text"][1:] + ' ')
  f.close()




  return segments,duration,result,word_count,n_words_doctor,n_words_patient,first_speaker