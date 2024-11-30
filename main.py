from flask import Flask, request, jsonify
from transformers import pipeline
import logging

app = Flask("individual3")

# Configure logging
logging.basicConfig(level=logging.DEBUG)

# Pre-load the model globally
# sentiment_analyzer = pipeline("sentiment-analysis", model="nlptown/bert-base-multilingual-uncased-sentiment", device=-1)
sentiment_analyzer = pipeline(
    "sentiment-analysis",
    model="nlptown/bert-base-multilingual-uncased-sentiment",
    framework="pt",
    device=-1,
)


@app.route("/", methods=["GET"])
def analyze_sentiment():
    question = request.args.get("question", "")
    app.logger.debug(f"Received question: {question}")
    try:
        # Use pre-loaded model
        result = sentiment_analyzer(question)
        return jsonify({"input": question, "sentiment": result[0]})
    except Exception as e:
        return jsonify({"error": str(e)}), 500


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
