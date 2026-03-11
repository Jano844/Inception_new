from flask import Flask, request, jsonify
from flask_cors import CORS
import json
import os
from datetime import datetime

app = Flask(__name__)
CORS(app)

DATA_FILE = '/data/guestbook.json'

def load_entries():
    if not os.path.exists(DATA_FILE):
        return []
    with open(DATA_FILE, 'r') as f:
        return json.load(f)

def save_entries(entries):
    os.makedirs(os.path.dirname(DATA_FILE), exist_ok=True)
    with open(DATA_FILE, 'w') as f:
        json.dump(entries, f)

@app.route('/entries', methods=['GET'])
def get_entries():
    entries = load_entries()
    return jsonify(entries)

@app.route('/entries', methods=['POST'])
def add_entry():
    data = request.get_json()
    if not data or not data.get('name') or not data.get('message'):
        return jsonify({'error': 'Name and message required'}), 400

    entries = load_entries()
    entry = {
        'id': len(entries) + 1,
        'name': data['name'],
        'message': data['message'],
        'date': datetime.now().strftime('%Y-%m-%d %H:%M')
    }
    entries.append(entry)
    save_entries(entries)
    return jsonify(entry), 201

@app.route('/ping', methods=['GET'])
def ping():
    return jsonify({'message': 'pong'})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)