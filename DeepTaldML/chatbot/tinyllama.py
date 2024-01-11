import torch
from transformers import pipeline

pipe = pipeline("text-generation", model="TinyLlama/TinyLlama-1.1B-Chat-v1.0", torch_dtype=torch.bfloat16)


def creaDomanda():
    testo = " write something to keep the conversation going, like a question"
    messages = [
        {"role": "user", "content": testo}
    ]
    print("sto generando una domanda")
    
    prompt = pipe.tokenizer.apply_chat_template(messages, tokenize=False, add_generation_prompt=True)
    outputs = pipe(prompt, max_new_tokens=256, do_sample=True, temperature=0.7, top_k=50, top_p=0.95)
    print(outputs[0]["generated_text"])

    return outputs[0]["generated_text"]

