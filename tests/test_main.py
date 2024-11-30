import unittest
from main import app
from unittest.mock import patch


class TestFlaskApp(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    @patch("main.sentiment_analyzer")
    def test_analyze_sentiment(self, mock_analyzer):
        mock_analyzer.return_value = [{"label": "POSITIVE", "score": 0.99}]
        response = self.app.get("/", query_string={"question": "I love programming"})
        self.assertEqual(response.status_code, 200)
        self.assertIn("POSITIVE", response.data.decode("utf-8"))
        self.assertIn("I love programming", response.data.decode("utf-8"))


if __name__ == "__main__":
    unittest.main()
