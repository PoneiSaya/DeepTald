from sklearn.metrics.pairwise import cosine_similarity
from sentence_transformers import SentenceTransformer
import math


#SPEAKER 1 = MEDICO
#SPEAKER 2 = PAZIENTE

'''
corpus = [
    "SPEAKER 1: Quale pizza mangi di solito?",
    "SPEAKER 2: Di solito mangio la margherita, mi piace il sapore che ha",
    "SPEAKER 2: Anche quella con le patatine è buona e la mangio ogni tanto",
    "SPEAKER 1: Qual è il tuo sport preferito?",
    "SPEAKER 2: Anche se pensandoci anche la diavola è una pizza che mangio spesso",
    "SPEAKER 1: Tifi qualche squadra di calcio?",
    "SPEAKER 2: La diavola è una pizza particolare perchè ha il salame piccante sopra che è molto buono",
    "SPEAKER 1: Potresti dirmi per favore se segui qualche squadra di calcio?",
    "SPEAKER 2: Vado sempre ad una pizzeria che si trova giù da me, lì la fanno molto buona",
    "SPEAKER 2: Una pizzeria che è aperta da quando sono piccolo",
    "SPEAKER 1: Hai animali in casa?",
    "SPEAKER 2: Si ho un cane ed un gatto",
    "SPEAKER 2: Il cane si chiama Pablo, il gatto Leo",
    "SPEAKER 2: Anche a loro piace mangiare la pizza, spesso quando la compro gliene do sempre un pezzo",
    "SPEAKER 1: So che è sposato, mi racconta del suo matrimonio?",
    "SPEAKER 2: Il mio matrimonio è stato un bel momento, c'era la musica e tante persone che ballavano e cantavano",
    "SPEAKER 2: C'era anche il buffet, c'era anche tanta pizza da mangiare"
]
'''


'''
corpus = [

    "SPEAKER 1: Qual è stato un momento che ricorda meglio del suo matrimonio?", 
    "SPEAKER 2: In generale tutto il mio matrimonio è un momento che ricordo con piacere, è stato in piena estate, ad agosto mi sembra",
    "SPEAKER 2: C'erano tante persone, i parenti e gli amici",
    "SPEAKER 2: Eravamo in una grande villa piena di fiori e con i tavoli all'esterno per gli invitati",
    "SPEAKER 1: Ricorda qualche episodio in particolare del suo matrimonio?",
    "SPEAKER 2: Ricordo quando tagliammo la torta a fine serata, lì fu molto bello",
    "SPEAKER 1: Cosa le piaceva fare da bambino?",
    "SPEAKER 2: Da piccolo mi piaceva giocare con i miei cugini in cortile, giocavamo con il pallone",
    "SPEAKER 2: C'era anche la band musicale al mio matrimonio, abbiamo cantato e ballato per tutta la giornata",
    "SPEAKER 1: Giocava solo con i suoi cugini o aveva anche altri amici?",
    "SPEAKER 2: No giocavamo solo tra i cugini perchè abitavamo nello stesso cortile",
    "SPEAKER 2: A volte passavamo il pomeriggio tutti insieme a casa di mia zia, la mamma di mio cugino",
    "SPEAKER 1: Oltre al calcio facevate qualche altro gioco tutti insieme?",
    "SPEAKER 2: Si spesso giocavamo anche a nascondino fino a sera",
    "SPEAKER 2: E ricordo anche che mangiammo tante case buone al matrimonio, c'era tanta roba da mangiare quel giorno",
    "SPEAKER 1: Oggi segue qualche sport?",
    "SPEAKER 2: Si oggi mi piace seguire molto il calcio e le macchine...la formula 1",
    "SPEAKER 2: Anche al mio matrimonio ricordo che dopo il pranzo giocammo tutti nel giardino della villa con la palla"

]
'''

def perseveranza(corpus):

    corpus_cleaned = [sentence.replace("CLINICIAN: ", "").replace("PATIENT: ", "").strip() for sentence in corpus]

    #print(corpus_cleaned)


    model = SentenceTransformer('efederici/sentence-BERTino')
    sentence_embeddings = model.encode(corpus_cleaned)


    # creazione della matrice di similarità
    #similarity_matrix = cosine_similarity(sentence_embeddings)



    # imposto una soglia per la similarità
    threshold = 0.3

    # inizializzazione delle variabili per il conteggio degli argomenti
    counter = 0
    topics_dict = {}
    counter_question = 0
    score_perseverance = 0


    topics_dict = {corpus_cleaned[0]: [corpus_cleaned[0]]}
    
    # ricerca delle coppie di frasi simili
    for i in range(len(corpus_cleaned) - 1):
        #print(corpus[i] + '-' + corpus[i+1])
        # confronto la frase corrente con la successiva

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

        else:
            # se la similarità è inferiore alla soglia, cerco prima se la frase corrente appartiene ad un topic esistente
            new_sentence_embedding = model.encode([corpus_cleaned[i+1]])
            #print('Sono nell\'else', corpus[i+1])
            keys_list = list(topics_dict.keys())
            for key in keys_list:
                
                similarity = cosine_similarity(new_sentence_embedding, model.encode([key]))[0][0]
                #print("Frase 1:",corpus_cleaned[i+1]," Frase 2:",key," Similarity:",similarity)


                if similarity >= threshold:
                    # se la frase corrente appartiene ad un topic esistente, la aggiungo alla lista del topic ed incremento il counter per indicare che c'è stata perseveranza (ritorno ad un argomento trattato in precedenza)
                    
                    #print("Faccio l'append della frase", corpus[i+1])
                    topics_dict[key].append(corpus_cleaned[i+1] + ' ->  +1')
                    #print('Sono nell\'if dentro l\'else', corpus[i+1])
                    if corpus[i+1].startswith("CLINICIAN: "): 
                        # se la frase corrente è una domanda, non la considero come ritorno al vecchio argomento
                        pass
                    else:
                        #print('Questa è la frase che incrementa il counter:', corpus_cleaned[i+1])
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

    score_perseverance = finalScore()

    #print('Score perseverance: ', score_perseverance)

    return score_perseverance, counter_question, topics_dict, counter

