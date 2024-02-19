import json
import requests
from datetime import datetime
import random

def handle(req):
    req_data = json.loads(req)
    user_question = req_data.get("question", "").lower()
    
        
    if "name" in user_question:
        responses = ["My name is Chatbot.","I'm known as Chatbot.","You can call me Chatbot."]
        return json.dumps({"text": random.choice(responses)})
       
    elif "date" in user_question or "time" in user_question:
        now = datetime.now()
        responses = [now.strftime('%H:%M:%S'), now.strftime('%I:%M %p'), now.strftime('%Y-%m-%d %H:%M:%S')]
        return json.dumps({"text": random.choice(responses)})
    
    elif "figlet" in user_question:
        figlet_text = user_question.replace("figlet", "").strip()
        gateway_invoke_url = 'http://127.0.0.1:8080/function/figlet'
	response = requests.post(gateway_invoke_url, data=figlet_text)
	if response.status_code==200:
            return response
        else:
            return "Error, received error code."
    
    else:
        return json.dumps({"text": "Sorry, I didn't understant that. Can you ask something else?"})

    
    
