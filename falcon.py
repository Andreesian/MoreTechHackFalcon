from hugchat import hugchat
from hugchat.login import Login

import configparser

config = configparser.ConfigParser()
config.read('config.ini')

email = config.get('auth', 'HUG_EMAIL')
password = config.get('auth', 'HUG_PASSWORD')

# Log in to huggingface and grant authorization to huggingchat
sign = Login("andresiandd@gmail.com", "333221333221wW!")
cookies = sign.login()

# Save cookies to the local directory
cookie_path_dir = "./cookies_snapshot"
sign.saveCookiesToDir(cookie_path_dir)

chatbot = hugchat.ChatBot(cookies=cookies.get_dict())  # or cookie_path="usercookies/<email>.json"

# non stream response
# query_result = chatbot.query("Hi!")
# print(query_result) # or query_result.text or query_result["text"]

from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/')
def hello():
    return "Hello, World!"

@app.route('/ask', methods=['POST'])
def add_numbers():
    data = request.get_json()
    text = data['text']
    result = chatbot.query(text)
    print(result)
    return jsonify({'result': result.text})

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True)
