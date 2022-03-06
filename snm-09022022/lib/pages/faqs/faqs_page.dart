import 'package:dil_app/config/common_const.dart';
import 'package:flutter/material.dart';

import 'frequent_question_view.dart';
import 'send_faqs_view.dart';

class FaqsPage extends StatefulWidget {
  const FaqsPage({Key key}) : super(key: key);

  @override
  _FaqsPageState createState() => _FaqsPageState();
}

class _FaqsPageState extends State<FaqsPage> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFf6edf7),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      // ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16.0, right: 16.0, top: 40, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                padding: EdgeInsets.only(bottom: 8),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
            ),
            SendFaqsView(),
            SizedBox(height: 16),
            Container(
              height: 50,
              width: width,
              color: Color(PrimaryColor),
              child: Center(
                child: Text(
                  'Frequently asked questions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(top: 16),
                shrinkWrap: true,
                itemCount: 40,
                itemBuilder: (context, index) {
                  return FrequentQestionsView(
                    questions: 'How can I send image?',
                    anwsers:
                        'How can I send image? How can I send image? How can I send image? How can I send image? How can I send image?',
                    rating: 3.5,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
