import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class ComplaintPageFields extends StatefulWidget {
  const ComplaintPageFields({
    Key key,
    @required TextEditingController issueTitleController,
    @required TextEditingController issueDescController,
  })  : _issueTitleController = issueTitleController,
        _issueDescController = issueDescController,
        super(key: key);

  final TextEditingController _issueTitleController;
  final TextEditingController _issueDescController;

  @override
  _ComplaintPageFieldsState createState() => _ComplaintPageFieldsState();
}

class _ComplaintPageFieldsState extends State<ComplaintPageFields> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appPadding = 30.0;

    return Positioned(
      bottom: size.height * 0.3,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(appPadding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'We are here to assist you!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.blue,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: appPadding),
                child: Container(
                  child: ClayContainer(
                    curveType: CurveType.convex,
                    emboss: true,
                    color: Colors.white,
                    borderRadius: 30,
                    depth: -30,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: appPadding),
                      child: TextFormField(
                        controller: widget._issueTitleController,
                        onFieldSubmitted: (String value) {
                          setState(() {
                            widget._issueTitleController.text = value;
                          });
                        },
                        validator: (value) =>
                            value.isEmpty ? '     Field is required' : null,
                        decoration: InputDecoration(
                          hintText: 'What is the subject of your complaint?',
                          border: InputBorder.none,
                          fillColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                height: 100,
                child: ClayContainer(
                  emboss: true,
                  curveType: CurveType.convex,
                  color: Colors.white,
                  borderRadius: 30,
                  depth: -30,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    child: TextFormField(
                      controller: widget._issueDescController,
                      onFieldSubmitted: (String value) {
                        setState(() {
                          widget._issueDescController.text = value;
                        });
                      },
                      validator: (value) =>
                          value.isEmpty ? '     Field is required' : null,
                      maxLines: 50,
                      decoration: InputDecoration(
                          hintText: 'Please enter your complaint',
                          border: InputBorder.none,
                          fillColor: Colors.black),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 8.0),
                child: Text(
                  'N.B: Your complaint will be cofedential and anonymous. We assure that it will not be disclosed or shared anywhere.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.red.withOpacity(0.6),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
