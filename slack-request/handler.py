import json

def handle(req):
    data = {
        "text": "Serverless Message",
        "attachments": [{
            "title": "The Awesome world of Cloud Computing! CSEN 241",
            "fields": [{
                "title": "Amazing Level",
                "value": "100",
                "short": True
            }],
            "author_name": "Shuaiyu Wang",
            "author_icon": "https://avatars.githubusercontent.com/u/31996250",
            "image_url": "https://avatars.githubusercontent.com/u/31996250"
        },
        {
            "title": "About CSEN 241",
            "text": "CSEN 241 is the most awesome class ever!."
        },
        {
            "fallback": "Would you recommend CSEN 241 to your friends?",
            "title": "Would you recommend CSEN 241 to your friends?",
            "callback_id": "response123",
            "color": "#3AA3E3",
            "attachment_type": "default",
            "actions": [
                {
                    "name": "recommend",
                    "text": "Of Course!",
                    "type": "button",
                    "value": "recommend"
                },
                {
                    "name": "definitely",
                    "text": "Most Definitely!",
                    "type": "button",
                    "value": "definitely"
                }
            ]
        }]
    }
    return json.dumps(data)
