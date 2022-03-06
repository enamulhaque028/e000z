import 'package:flutter/material.dart';

class SendFaqsView extends StatefulWidget {
  const SendFaqsView({Key key}) : super(key: key);

  @override
  _SendFaqsViewState createState() => _SendFaqsViewState();
}

class _SendFaqsViewState extends State<SendFaqsView> {
  bool _expanded = false;
  String selectionText = 'If you have any query feel free to ask';
  TextEditingController _faqController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ExpansionPanelList(
        elevation: 0,
        animationDuration: Duration(milliseconds: 1500),
        children: [
          ExpansionPanel(
            headerBuilder: (context, isExpanded) {
              return ListTile(
                title: Text(
                  selectionText,
                  style: TextStyle(color: Colors.black),
                ),
              );
            },
            body: Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 150,
                    child: TextFormField(
                      controller: _faqController,
                      onFieldSubmitted: (String value) {
                        setState(() {
                          _faqController.text = value;
                        });
                      },
                      validator: (value) =>
                          value.isEmpty ? '     Field is required' : null,
                      maxLines: 50,
                      decoration: new InputDecoration(
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: new BorderSide(color: Colors.green),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        errorBorder: new OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: new BorderSide(color: Colors.red),
                        ),
                        labelText: "Ask a Question",
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    width: 80,
                    child: MaterialButton(
                      height: 45,
                      // minWidth: 340,
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(4)),
                      onPressed: () {},
                      child: Center(
                        child: Text(
                          "Send",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      color: Colors.green[300],
                    ),
                  ),
                ],
              ),
            ),
            isExpanded: _expanded,
            canTapOnHeader: true,
          ),
        ],
        dividerColor: Colors.grey,
        expansionCallback: (panelIndex, isExpanded) {
          _expanded = !_expanded;
          setState(() {});
        },
      ),
    );
  }
}
