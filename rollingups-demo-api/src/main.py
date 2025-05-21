from flask import Flask, jsonify
from datetime import datetime

app = Flask(__name__)

# Home endpoint
@app.get('/')
def home():
    return jsonify(message="Welcome to the Flask app!"), 200

# Health endpoint
@app.get('/health')
def health():
    return jsonify(
        message="healthy",
        timestamp=datetime.now().isoformat()
    ), 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)
