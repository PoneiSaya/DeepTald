import json
import requests

# Sostituisci "YOUR_OPENAI_API_KEY" con il tuo effettivo chiave API di OpenAI
openai_api_key = "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"


url = "https://api.openai.com/v1/chat/completions"
headers = {
    "Content-Type": "application/json",
    "Authorization": f"Bearer {openai_api_key}"
}


def creaDomandaConContesto(contesto: str):
    
    data = {
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "Ciao, dato questa riposta: " + contesto + ". rispondi in qualche modo e mantiene la conversazione viva, puoi anche fare domande"}],
        "temperature": 0.7
    }
    
    response_json = requests.post(url, headers=headers, json=data).json()
    # Carica il JSON


    # Estrai il campo 'message'
    message_content = response_json['choices'][0]['message']['content']
    return message_content

def creaDomanda():
    
    data = {
        "model": "gpt-3.5-turbo",
        "messages": [{"role": "user", "content": "Scrivi qualcosa per iniziare una conversazione, come una domanda, può essere su qualsiasi cosa."}],
        "temperature": 0.7
    }
    
    response_json = requests.post(url, headers=headers, json=data).json()
    # Carica il JSON


    # Estrai il campo 'message'
    message_content = response_json['choices'][0]['message']['content']
    return message_content