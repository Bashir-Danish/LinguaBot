import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:linguabot/services/api_services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:linguabot/utils/constants.dart';

class TranslatePage extends StatefulWidget {
  @override
  _TranslatePageState createState() => _TranslatePageState();
}

class _TranslatePageState extends State<TranslatePage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();
  String _language1 = 'English';
  String _language2 = 'Persian';
  bool _loading = false;

  Future<void> translate() async {
    String inputText = _inputController.text;
    setState(() {
    _loading = true;
   _outputController.clear();
  });
    try {
      String translatedText = await ApiService.translateText(
          'Translate this text from $_language1 to $_language2 :$inputText');
      setState(() {
        _outputController.text = translatedText;
      });
    } catch (e) {
      print("error 1: $e");
    }finally{
      setState(() {
      _loading = false;
    });
    }
  }

  void _switchLanguages() {
    setState(() {
      String temp = _language1;
      _language1 = _language2;
      _language2 = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(_language1),
              TextButton(
                onPressed: _switchLanguages,
                child: const Icon(Icons.swap_horiz),
              ),
              Text(_language2),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _inputController,
                decoration: const InputDecoration(
                  labelText: 'Input',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                expands: true,
                textDirection: _language1 == 'Persian'
                    ? TextDirection.rtl
                    : TextDirection.ltr,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: translate,
            style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(kPrimaryColor), 
              ),
            child: const Text('Translate'),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  TextField(
                    controller: _outputController,
                    decoration: const InputDecoration(
                      // labelText: 'Output',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                    expands: true,
                    readOnly: true,
                  ),
                  if (_loading)
                    const Center(
                      child: SpinKitFadingCircle(
                        color: kPrimaryColor,
                        size: 50.0,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
