import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:developer' as developer;

import 'package:gui_builder_test/config/secret_config.dart';

class AiDesigner extends StatefulWidget {
  const AiDesigner({super.key});

  @override
  State<AiDesigner> createState() => _AiDesignerState();
}

class _AiDesignerState extends State<AiDesigner> {
  GenerativeModel? model;
  String aiOutput = 'Initializing...';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initGemini();
  }

  Future<void> _initGemini() async {
    try {
      // Try loading from both possible locations for safety
      final apiKey = SecretConfig.geminiApiKey;

      if (apiKey.isEmpty) {
        setState(() {
          aiOutput = 'API key missing in SecretConfig.';
        });
        return;
      }

      setState(() {
        model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: "apiKey");
        aiOutput = 'Press "Generate" to get ideas.';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        aiOutput = 'Failed to initialize: $e';
        isLoading = false;
      });
    }
  }

  Future<void> _generateDesign() async {
    if (model == null) {
      setState(() {
        aiOutput = '⚠️ Model not initialized yet.';
      });
      return;
    }

    setState(() {
      aiOutput = '🤖 Thinking...';
    });

    try {
      final response = await model!.generateContent([
        Content.text(
          'Suggest a simple Flutter widget layout with a title and a button. '
          'Keep it in plain text, short and simple.',
        ),
      ]);

      final textResponse =
          response.text ??
          (response.candidates.isNotEmpty
              ? response.candidates.first.content.parts
                    .map((e) => (e as dynamic).text ?? e.toString())
                    .join(' ')
              : 'No result.');

      setState(() {
        aiOutput = textResponse.isEmpty ? 'Empty response.' : textResponse;
      });
      developer.log('AI output: $aiOutput');
    } catch (e) {
      setState(() {
        aiOutput = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.purpleAccent)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      aiOutput,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _generateDesign,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                    ),
                    child: const Text('Generate'),
                  ),
                ],
              ),
      ),
    );
  }
}

@Preview(name: 'AI Designer')
Widget aiDesignerPreview() => const AiDesigner();
