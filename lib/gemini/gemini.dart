// import 'dart:io';
//
// import 'package:google_generative_ai/google_generative_ai.dart';
//
// void main() async {
//   final apiKey = Platform.environment['GEMINI_API_KEY'];
//   if (apiKey == null) {
//     stderr.writeln(r'No $GEMINI_API_KEY environment variable');
//     exit(1);
//   }
//
//   final model = GenerativeModel(
//     model: 'gemini-1.5-pro',
//     apiKey: apiKey,
//
//     generationConfig: GenerationConfig(
//       temperature: 1,
//       topK: 64,
//       topP: 0.95,
//       maxOutputTokens: 8192,
//       responseMimeType: 'text/plain',
//     ),
//   );
//
//   final chat = model.startChat(history: [
//     Content.multi([
//       // FilePart(uri: TODO),
//       TextPart('what is Google’s data center guiding principle?'),
//     ]),
//     Content.model([
//       TextPart('Google\'s data center guiding principle is: \n\n**"Keep digital infrastructure secure and sustainable while driving local economic development, fostering thriving communities, and spurring environmental stewardship."** \n'),
//     ]),
//   ]);
//   final message = 'INSERT_INPUT_HERE';
//   final content = Content.text(message);
//
//   final response = await chat.sendMessage(content);
//   print(response.text);
// }