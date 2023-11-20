from sklearn.metrics.pairwise import cosine_similarity
from sentence_transformers import SentenceTransformer
import torch
from torch import nn
from transformers import AutoTokenizer, AutoModelForSequenceClassification
import math


'''
corpus = [
    MEDICO 
    A cosa pensi di solito durante la giornata?,
    PAZIENTE 
    Penso spesso alla mia malattia e a quanto mi faccia stare male, 
    PAZIENTE
    Quasi ogni giorno mi sveglio ed ho paura di ammalarmi ancora di più, 
    MEDICO 
    Hai qualche ricordo in particolare della tua infanzia?, 
    PAZIENTE 
    Quando ero piccolo ricordo i pomeriggi passati a casa di mia nonna, 
    MEDICO 
    Un ricordo in particolare?, 
    PAZIENTE 
    Sento che la malattia cresce di giorno in giorno e questo non mi fa vivere bene,
    PAZIENTE 
    Non riesco a stare bene, passo le mie giornate pensando solo a questo,
    MEDICO 
    Hai qualche passione?,
    PAZIENTE 
    Una mia grande passione è la lettura,
    PAZIENTE 
    Anche se nell'ultimo periodo anche se provo a distrarmi, la malattia mi fa sentire sempre debole 
]
'''



def ruminazione(corpus):

    corpus_cleaned = [sentence.replace("CLINICIAN: ", "").replace("PATIENT: ", "").strip() for sentence in corpus]


    #metodo per la verifica del sentiment del paziente
    def verifyNegativity(sentence):
    
        
        tokenizer = AutoTokenizer.from_pretrained("neuraly/bert-base-italian-cased-sentiment")
     
        model = AutoModelForSequenceClassification.from_pretrained("neuraly/bert-base-italian-cased-sentiment")
        
      
        input_ids = tokenizer.encode(sentence, add_special_tokens=True)
     
        tensor = torch.tensor(input_ids).long()
    
        tensor = tensor.unsqueeze(0)
        
        logits = model(tensor).logits

        
        proba = nn.functional.softmax(logits, dim=1)
            
        
        negative, neutral, positive = proba[0]

        max_value_sentiment = max(negative.item(),neutral.item(),positive.item())

        if max_value_sentiment == negative.item():
                result = "Negative"
                #counter_negative_sentence += 1
        elif max_value_sentiment == neutral.item():
                result = "Neutral"
        else:
                result = "Positive"

        return result
    

    model = SentenceTransformer('efederici/sentence-BERTino')
    sentence_embeddings = model.encode(corpus_cleaned)


    # creazione della matrice di similarità
    #similarity_matrix = cosine_similarity(sentence_embeddings)



    # impostazione di una soglia per la similarità
    threshold = 0.3

    # inizializzazione delle variabili per il conteggio degli argomenti
    counter = 0
    topics_dict = {}
    counter_question = 0
    score_rumination = 0
    #previous_counter_value = 0
    sentiment_dict = {}


    topics_dict = {corpus_cleaned[0]: [corpus_cleaned[0]]}

    sentiment_first_phrase = verifyNegativity(corpus_cleaned[0])
    sentiment_dict[corpus_cleaned[0]] = sentiment_first_phrase
    
    # ricerca delle coppie di frasi simili
    for i in range(len(corpus_cleaned) - 1):
        # confronto la frase corrente con la successiva

        sentiment_1 = verifyNegativity(corpus_cleaned[i+1])
        sentiment_dict[corpus_cleaned[i+1]] = sentiment_1

        if corpus[i].startswith('CLINICIAN: '):
            counter_question += 1

        similarity = cosine_similarity([sentence_embeddings[i]], [sentence_embeddings[i+1]])[0][0]
        #print('1:',corpus_cleaned[i],'2:',corpus_cleaned[i+1],'Simil: ',similarity)

        last_topic = list(topics_dict.keys())[-1]
        #last_topic_sentences = topics_dict[last_topic]

        sentence_embedding_current = model.encode([corpus_cleaned[i+1]])

        similarity_1 = cosine_similarity(sentence_embedding_current, model.encode([last_topic]))[0][0]

        #print('1*:',corpus_cleaned[i+1],'2*:',last_topic,'Simil*: ',similarity_1)
    

        if similarity >= threshold or similarity_1 >= threshold: 
            # se la similarità supera la soglia, aggiungo la frase corrente alla lista del topic corrispondente
            new_sentence_embedding = model.encode([corpus_cleaned[i+1]])
            keys_list = list(topics_dict.keys())
            for key in keys_list:
                similarity = cosine_similarity(new_sentence_embedding, model.encode([key]))[0][0]

                if similarity >= threshold:
                    topics_dict[key].append(corpus_cleaned[i+1])
            #Se ho identificato una frase che incrementa il counter e la frase subito successiva a sua volta somiglia a quella precedente, allora incremento nuovamente il counter direttamente qui        
            
            ''' if (previous_counter_value == counter - 1) and (corpus[i].startswith("PAZIENTE: ") and corpus[i+1].startswith("PAZIENTE: ")):

                print("Incremento il counter qui")
                counter = counter + 1

                corpus_cleaned[i+1] += ' -> +1'
            #current_topic = list(topics_dict.keys())[-1]
            #print(corpus[i+1])
            #topics_dict[current_topic].append(corpus[i+1])
        '''
        else:
            # se la similarità è inferiore alla soglia, cerco prima se la frase corrente appartiene ad un topic esistente
            new_sentence_embedding = model.encode([corpus_cleaned[i+1]])
            #print('Sono nell\'else', corpus[i+1])
            keys_list = list(topics_dict.keys())

            #keys_to_compare = keys_list[:-1]
            #print(keys_list)

            sentiment = verifyNegativity(corpus_cleaned[i+1])
            #print('Frase ' + corpus_cleaned[i+1], 'Sentiment ' + sentiment)

            #topics_dict_copy = topics_dict.copy()

            for key in keys_list:
                topic_sentence = topics_dict[key][0] # Prima frase associata alla chiave
                topic_sentence_embedding = model.encode([topic_sentence])
                
                similarity_with_key = cosine_similarity(new_sentence_embedding, model.encode([key]))[0][0]
                similarity_with_topic_sentence = cosine_similarity(new_sentence_embedding, topic_sentence_embedding)[0][0]
        
                #similarity_1 = cosine_similarity(new_sentence_embedding, model.encode([first_value]))[0][0]
                #print("Frase 1:",corpus_cleaned[i+1]," Frase 2:",key," Similarity:",similarity)
                #print("Frase 1:",corpus_cleaned[i+1]," Prima frase associata alla key: ",topic_sentence, "Similarity: ", similarity_with_topic_sentence)



                if (similarity_with_key >= threshold and sentiment == 'Negative') or (similarity_with_topic_sentence >= threshold and sentiment == 'Negative'):
                    #print("Sono qui")
                    # se la frase corrente appartiene ad un topic esistente, la aggiungo alla lista del topic ed incremento il counter per indicare che c'è stata perseveranza (ritorno ad un argomento trattato in precedenza)
                    topics_dict[key].append(corpus_cleaned[i+1] + ' ->  +1')
                    #print('Sono nell\'if dentro l\'else', corpus[i+1])
                    if corpus[i+1].startswith("CLINICIAN: "): 
                        # se la frase corrente è una domanda dello SPEAKER 1 (medico), non la considero come ritorno al vecchio argomento
                        pass
                    else:
                        #print('Questa è la frase che incrementa il counter:', corpus_cleaned[i+1])
                        #previous_counter_value = counter
                        counter = counter + 1
                        #print(counter)
                        break

                else:
                    
                    # se la frase corrente non appartiene ad alcun topic esistente, creo un nuovo topic con la frase come chiave
                    if key == keys_list[-1]:
                        new_topic = corpus_cleaned[i+1]
                        topics_dict[new_topic] = [corpus_cleaned[i+1]]
                        #print("New topic")
                        #print('Sono nell\'else dentro l\'if', corpus[i+1])
                    else:
                        continue
                    

    '''                   
    # Stampa dei risultati
    for topic, sentences in topics_dict.items():
        print(f"{topic}:")
        for sentence in sentences:
            if sentence != topic:
                print(f"- {sentence}")
        print()
    '''


    #print('Il numero totale di domande fatte è:', counter_question)
    #print("Il numero di volte che si è ritornati all'argomento precedente durante la conversazione è:", counter)

    def finalScore():

        if (counter_question - 1)==0:

            return 'La conversazione è troppo breve per essere valutata'
        
        else:
            
            score = (counter) / (counter_question - 1)
            normalized_score = score * 4
            #print(normalized_score)

            if normalized_score > 4:
            
                normalized_score = math.floor(normalized_score)
        
            else:

                if normalized_score - math.floor(normalized_score) >= 0.5:

                    final_score_approximate = math.ceil(normalized_score)  

                else:
                
                    final_score_approximate = round(normalized_score)
        
        
        
            return final_score_approximate

    score_rumination = finalScore()

    return score_rumination, counter_question, counter, topics_dict, sentiment_dict
