import math



def total_pause_time(duration,result):

  last_end_time = None
  total_pause_time = 0

  for segment in result['segments']:
      for word in segment['words']:
          start_time = word['start']
          end_time = word['end']

          if last_end_time is not None:
              pause_time = start_time - last_end_time
              if pause_time > 0:
                  total_pause_time += pause_time
          
          last_end_time = end_time


  score_pause = total_pause_time / duration

  print(f"Total pause time: {round(total_pause_time, 2)} s")

  print('Score pause', score_pause)

  return score_pause



def calculate_speaking_time(result,first_speaker):

    total_speaking_time_speaker1 = 0

    if first_speaker == "SPEAKER 2":
        medico = first_speaker
        paziente = "SPEAKER 1"
    else:
        medico = "SPEAKER 1"
        paziente = first_speaker

    for i, current_segment in enumerate(result['segments']):
        if current_segment['speaker'] == paziente:
            start_time = current_segment['words'][0]['start']

            if i < len(result['segments']) - 1:
                next_segment = result['segments'][i + 1]
                end_time = next_segment['words'][0]['start']
            else:
                end_time = current_segment['words'][-1]['end']

            speaking_time = end_time - start_time
            total_speaking_time_speaker1 += speaking_time

    #print('Tempo totale in cui parla lo Speaker 2:', total_speaking_time_speaker2)

    return total_speaking_time_speaker1



def pause_time_between_words(result,first_speaker):

    last_end_time_speaker1 = None
    total_pause_time_speaker1 = 0
    

    if first_speaker == "SPEAKER 2":
        medico = first_speaker
        paziente = "SPEAKER 1"
    else:
        medico = "SPEAKER 1"
        paziente = first_speaker

    for segment in result['segments']:
        speaker = segment['speaker']
        
        if speaker == paziente:
            for word in segment['words']:
                start_time = word['start']
                end_time = word['end']

                if last_end_time_speaker1 is not None:
                    pause_time = start_time - last_end_time_speaker1
                    if pause_time > 0:
                        total_pause_time_speaker1 += pause_time
                
                last_end_time_speaker1 = end_time

    #print('Pause between words', total_pause_time_speaker2)
    
    return total_pause_time_speaker1


# Calcolo del WPM (Word Per Minutes) per ogni speaker

def word_per_minute(word_count,duration):

  total_words = sum(word_count.values())  # Calcola il numero totale di parole in tutti i segmenti
  duration_minutes = duration / 60  # Durata in minuti

  for speaker in word_count:
      words_spoken = word_count[speaker]
      wpm = round(words_spoken / duration_minutes)
      print(f"{speaker} spoke at a rate of {wpm} WPM")

'''
for speaker in word_count:
  words_spoken = word_count[speaker]
  duration = (segments[-1]['end'] - segments[0]['start']) - total_pause_time

  duration_timedelta = timedelta(seconds=duration)

  wpm = round(words_spoken / (duration_timedelta.total_seconds() / 60))

  print(f"{speaker} spoke at a rate of {wpm} WPM")
'''

#Calcolo della frequenza di interruzioni

def counter_interruption(segments, first_speaker):

  interruption_count = 0
  question_count = 0

  if first_speaker == "SPEAKER 2":
        medico = first_speaker
        paziente = "SPEAKER 1"
  else:
        medico = "SPEAKER 1"
        paziente = first_speaker

  for i in range(len(segments) - 1):
      current_segment = segments[i]
      next_segment = segments[i + 1]

      current_speaker = current_segment['speaker']
      next_speaker = next_segment['speaker']

      if current_speaker == medico and next_speaker == paziente:
          question_count += 1

          if current_segment['end'] >= (next_segment['start'] - 0.20):
              interruption_count += 1

  # Aggiungi il controllo per l'ultimo segmento se necessario
  if segments and segments[-1]['speaker'] == medico:
        question_count += 1
  
  #print('Numero di domande effettuate dal medico: ', question_count)

  #print('Numero di interruzioni verificatesi durante l\'intervista: ', interruption_count)

  interruption_score = interruption_count / question_count

  #print('Numero di domande:', question_count)
  #print('Numero di interruzioni:', interruption_count)

  return interruption_score, question_count, interruption_count

#Patient-doctor ratio, si tiene conto della lunghezza totale della conversazione e fornisce un rapporto che indica la proporzione delle parole pronunciate dal paziente rispetto al numero totale di parole pronunciate da entrambi i partecipanti alla conversazione
'''
def patient_doctor_ratio(word_count):

  patient_words = word_count['SPEAKER 2']
  doctor_words = word_count['SPEAKER 1']

  total_words = sum(word_count.values())

  if total_words == 0:
      patient_doctor_ratio = 0  # La conversazione non contiene parole
  else:
      patient_doctor_ratio = patient_words / total_words

  print(f"Patient-Doctor Ratio: {patient_doctor_ratio}")

  return patient_doctor_ratio
'''

#Computo della lunghezza media delle risposte del paziente

def avg_response_length(word_count,segments,first_speaker):
    patient_responses = 0
    segments_length = len(segments)
    
    if first_speaker == "SPEAKER 2":
        medico = first_speaker
        paziente = "SPEAKER 1"
    else:
        medico = "SPEAKER 1"
        paziente = first_speaker


    for i in range(segments_length):
        current_segment = segments[i]

        if current_segment['speaker'] == paziente:
            if i == segments_length - 1 or segments[i+1]['speaker'] != paziente:
                patient_responses += 1

    total_words = word_count[paziente]
   

    average_response_length = total_words / patient_responses

    print(f"Patient Average Response Length: {average_response_length}")

    return average_response_length / 10


#Tempo di risposta del paziente (Pensiero rallentato)

def response_time(segments,first_speaker):
   
  speaker1_responses = []
  speaker2_questions = []
  total_response_time = 0

  if first_speaker == "SPEAKER 2":
        medico = first_speaker
        paziente = "SPEAKER 1"
  else:
        medico = "SPEAKER 1"
        paziente = first_speaker

  for i in range(len(segments) - 1):
      current_segment = segments[i]
      next_segment = segments[i+1]

      if current_segment['speaker'] == medico:
          speaker2_questions.append(current_segment['text'])
          
          if next_segment['speaker'] == paziente:
              response_time = next_segment['start'] - current_segment['end']
              if response_time < 0:
                  response_time = 0
              speaker1_responses.append(response_time)
              total_response_time += response_time

  #Secondi totali di tempi di risposta / numero di risposte !!!!!!!! modificare qui forse, non fare questa divisione ma sommare solo i tempi di risposta
  average_response_time = sum(speaker1_responses) / len(speaker1_responses)

  print(speaker1_responses)

  print("Tempo di risposta totale", total_response_time)

  #print(f"SPEAKER 2 Total Response Time: {total_response_time} seconds")

  return average_response_time



def compute_final_score_item_logorrea(segments,word_count,interruptions_weight,response_length_weight,first_speaker,result, max_value_avg_response_length, min_value_avg_response_length):
   

   #print(word_count)

   #max_value_avg_response_length = 80
   #min_value_avg_response_length = 0    
   
   normalize_interruption_score, question_count, interruption_count = counter_interruption(segments,first_speaker)

   speaking_time_patient = calculate_speaking_time(result,first_speaker)

   print('Interruption score', normalize_interruption_score)
   
   avg_respons_length = avg_response_length(word_count,segments,first_speaker)

   #print('Avg respons length', avg_respons_length)

   normalize_avg_respons_length = (avg_respons_length - min_value_avg_response_length) / (max_value_avg_response_length - min_value_avg_response_length)

   
   #interruptions_weight = 0.5
   #response_length_weight = 0.5

   #final_score = (interruptions_weight * interruption_score) + (response_length_weight * avg_respons_length)

   final_score = (interruptions_weight * normalize_interruption_score) + (response_length_weight * normalize_avg_respons_length)


   final_score_normalized = final_score * 4

   #print(f"Final score not normalized: {final_score_normalized}")

  #In questo caso la ragazza mi esce come grado 2

   if final_score_normalized > 4:
      
      final_score_approximate = 4
   
   else:

      if final_score_normalized - math.floor(final_score_normalized) >= 0.5:

          final_score_approximate = math.ceil(final_score_normalized)  

      else:
        
          final_score_approximate = round(final_score_normalized)

   #print(f"Final score LOGORREA: {final_score_approximate}")


   return final_score_approximate, question_count, interruption_count, avg_respons_length, speaking_time_patient
   



def compute_final_score_item_pensiero_rallentato(result,segments,pause_time_weight,response_time_weight, first_speaker, max_value_response_time, min_value_response_time):
   
   final_score_approximate = 0

   #max_value_response_time = 2
   #min_value_response_time = 0

   interruption_score, question_count, interruption_count = counter_interruption(segments,first_speaker)
   
   pause_between_words = pause_time_between_words(result,first_speaker)
   #word_per_minute()
   time_response = response_time(segments,first_speaker)

   speaking_time_patient = calculate_speaking_time(result,first_speaker)


   print('Pause between words', pause_between_words)

   print('Speaking time patient', speaking_time_patient)

   print('Response time', time_response)

  #Percentuale di pause nei segmenti di parlato rispetto al discorso totale del paziente
   normmalized_score_pause = pause_between_words / speaking_time_patient

   print('Score pause', normmalized_score_pause)
   
   print(pause_time_weight)
   print(response_time_weight)

   print(pause_time_weight * normmalized_score_pause)
   print(response_time_weight * time_response)

   normalized_time_response = (time_response - min_value_response_time) / (max_value_response_time - min_value_response_time)


   #final_score = (pause_time_weight * (score_pause/10)) + (response_time_weight * time_response)
   final_score = (pause_time_weight * normmalized_score_pause) + (response_time_weight * normalized_time_response)

   print('Final score not normalized', final_score)

   final_score_normalized = final_score * 4

   #print(f"Score pensiero rallentato: {final_score_normalized}")


   if final_score_normalized > 4:
      
      final_score_approximate = 4
   
   else:

      if final_score_normalized - math.floor(final_score_normalized) >= 0.5:

          final_score_approximate = math.ceil(final_score_normalized)  

      else:
        
          final_score_approximate = round(final_score_normalized)
   

   #print(f"Final score PENSIERO RALLENTATO normalized: {final_score_approximate}")

   return final_score_approximate, question_count, pause_between_words, time_response, speaking_time_patient
   
