from flask import Flask, request, jsonify
from vertexai.language_models import TextGenerationModel
import vertexai

app = Flask(__name__)

# Initialize Vertex AI
vertexai.init(project="hack-team-grey-matter-gurus", location="us-central1")

# Parameters for text generation
parameters = {
    "max_output_tokens": 1024,
    "temperature": 0.9,
    "top_p": 1
}

# Load the TextGenerationModel
model = TextGenerationModel.from_pretrained("text-bison")

# Function to generate summary
def generate_summary(text):
    prompt = f"Summarize the following text:\n\n{text}"
    response = model.predict(prompt, **parameters)
    return response.text

# Flask route to handle summarization requests
@app.route('/summarize', methods=['POST'])
def summarize():
    data = request.get_json()
    text = data.get('text', '')

    if not text:
        return jsonify({"error": "Text is required"}), 400

    try:
        summary = generate_summary(text)
        return jsonify({"summary": summary})
    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(port=5000)
