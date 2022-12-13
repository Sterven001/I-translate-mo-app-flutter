import 'package:app_proposal/auth/read%20data/get_user_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Translator App",
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String dropdownFrom = "English";
  String dropdownTo = "Tagalog";
  String userinput = "";
  String result = "";
  String resultImage = "";

  List <String> availableLang =  <String>['English', 'Tagalog', 'Cebuano', 'Ilocano'];
  List <String> languageCode =  <String>['en', 'tl', 'ceb', 'ilo'];
   List <String> imageList = <String>['','','',''];

  //Translate
  resultTranslate() async {
    result = '';
    resultImage = '';
    final translator = GoogleTranslator();

    String from = languageCode[availableLang.indexOf(dropdownFrom)];
    String to = languageCode[availableLang.indexOf(dropdownTo)];

    if (to == 'ilo' || from == 'ilo') {
      const apiKey = 'AIzaSyAqw_1UeKelSsN6_cZReWfpFmN3ZAYb_aM';
      final url = Uri.parse('https://translation.googleapis.com/language/translate/v2/?q=$userinput&target=$to&key=$apiKey');
      final urlImage = Uri.parse('https://translation.googleapis.com/language/translate/v2/?q=$userinput&target=en&key=$apiKey');
      final response = await http.get(url);
      final responseImage = await http.get(urlImage);

      if (responseImage.statusCode == 200) {
        final body = jsonDecode(responseImage.body);
        String translatedText = body['data']['translations'][0]['translatedText'];
        setState(() {
          resultImage = translatedText;
        });
      }
      if (response.statusCode == 200) {
        final body = jsonDecode(response.body);
        String translatedText = body['data']['translations'][0]['translatedText'];
        setState(() {
          result = translatedText;
        });
      }
    }
    else {
      var translation = await translator.translate(userinput, from: languageCode[availableLang.indexOf(dropdownFrom)], to: languageCode[availableLang.indexOf(dropdownTo)]);
      var imageQueryTranslation = await translator.translate(userinput, to: 'en');
      
      setState(() {
        result = translation.text;
        resultImage = imageQueryTranslation.text;
      });
    }
     getImage(resultImage);
  }
  // Translate

  getImage(query) async {
    Uri uri = Uri.parse('https://pixabay.com/api/?key=31967150-485acee5366380eb255118034&q=$query' );
    http.Response response = await http.get(uri);
    
    if (response.statusCode == 200) {
      String data = response.body;
      Map<String, dynamic> imageData = json.decode(data);
      setState(() {
        imageList = [imageData['hits'][0]['largeImageURL'], imageData['hits'][1]['largeImageURL'], imageData['hits'][2]['largeImageURL'], imageData['hits'][3]['largeImageURL']];
      });
      
    } else {
      print('Error: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[400],
        title: const Text('I-translate mo app!'),
            actions: [
              GestureDetector(
                onTap: (() {
                  FirebaseAuth.instance.signOut();
                }),
                child:Icon(Icons.logout)),
            ],
       ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: 
        ListView(
          children: [
            // First Row
            Row(
              children: [
                const Expanded(flex: 1, child: Text('From:  ')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<String>(
                    value: dropdownFrom,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownFrom = newValue!;
                      });
                    },
                    items: availableLang
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // Second Row
            const SizedBox(height: 10,),

            Row(
              children: [
                const Expanded(flex: 1, child: Text('To:  ')),
                Expanded(
                  flex: 5,
                  child: DropdownButton<String>(
                    value: dropdownTo,
                    icon: const Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownTo = newValue!;
                      });
                    },
                    items: availableLang
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
            // TextFeild
            const SizedBox(height: 10,),
            TextField(
              maxLines: 5,
              onChanged: (val) {
                setState(() {
                  userinput = val;
                });
              },
              decoration: const InputDecoration(
                  hintText: "Enter something",
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.all(Radius.circular(15)))),
            ),
            const SizedBox(height: 10,),
            MaterialButton(
              height: 50,
             color:  Colors.deepPurple[400],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: const BorderSide(color:  Colors.deepPurple,)
              ),
              child: const Text('Translate', style: TextStyle(color: Colors.white, fontSize: 20 )),
              onPressed: (){
                  resultTranslate();
              }),

              // Result
              const SizedBox(height: 10,),
              Center(child: Text('Result: $result', style: const TextStyle(color: Colors.black, fontSize: 20 ))),
              const SizedBox(height: 20,),

              Row(
                children: [
                  Expanded(child: Image.network(imageList[0]),),

                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(child: Image.network(imageList[1]),),
                ],
              )
          ],
        ),
      ),
    );
  }
}
