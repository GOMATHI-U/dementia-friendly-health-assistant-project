
class ChatbotService {
  Future<String> getResponse(String message) async {
    String lowerMessage = message.toLowerCase();

    if (lowerMessage.contains("what is dementia")) {
      return "🧠 Dementia is a decline in cognitive abilities like memory and reasoning. It is often caused by diseases like Alzheimer's.";
    } else if (lowerMessage.contains("how to care for a dementia patient")) {
      return "💙 Caring for a dementia patient requires patience, routine, and a calm environment. Encourage engagement in familiar activities.";
    } else if (lowerMessage.contains("suggest food recipes for dementia patients")) {
      return "🥗 **Dementia-Friendly Recipes**:\n"
             "1️⃣ **Berry & Nut Smoothie** - Great for brain health.\n"
             "2️⃣ **Grilled Salmon & Avocado** - Rich in Omega-3.\n"
             "3️⃣ **Broccoli & Spinach Soup** - Full of antioxidants.\n"
             "4️⃣ **Brown Rice & Lentil Bowl** - Provides steady energy.";
    } else {
      return "🤖 I can answer dementia-related questions! Try:\n"
             "- 'What is dementia?'\n"
             "- 'How to care for a dementia patient?'\n"
             "- 'Suggest food recipes for dementia patients?'\n";
    }
  }
}
