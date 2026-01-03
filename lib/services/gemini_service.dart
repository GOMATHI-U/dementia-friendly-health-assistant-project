import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  static const String _apiKey = "AIzaSyB4sijzTx6nwC2lwEIELrT4rnknO7_5HaA";

  static const String _url =
      "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$_apiKey";

  Future<String> getReply(String message) async {
    final response = await http.post(
      Uri.parse(_url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "contents": [
          {
            "parts": [
              {
                "text":
                    "You are a calm, friendly dementia-care assistant. "
                    "Speak simply and kindly.\nUser: $message"
              }
            ]
          }
        ]
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data["candidates"][0]["content"]["parts"][0]["text"];
    } else {
      return "Sorry, I couldn't understand that.";
    }
  }
}
