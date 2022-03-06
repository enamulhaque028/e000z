import 'package:flutter/material.dart';
import 'package:health_line_bd/config/common_const.dart';
import 'package:intl/intl.dart';

class CustomSearchBar extends StatefulWidget {
  final Function(String) onChanged;
  final TextEditingController controller;
  const CustomSearchBar({
    Key key,
    @required this.onChanged,
    @required this.controller,
  }) : super(key: key);

  @override
  _CustomSearchBarState createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  TextEditingController textController = new TextEditingController();
  @override
    void initState() {
      setState(() {
        textController = widget.controller;
      });
      super.initState();
    }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            // child: Text(
            //   'Find\nDoctors',
            //   style: TextStyle(
            //     color: Colors.white,
            //     fontSize: 35,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            child: IconButton(
              icon: Icon(
                Icons.calendar_today_outlined,
                size: 28,
                color: Colors.white,
              ),
              onPressed: () {
                showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2020, 01),
                  lastDate: DateTime(2025, 12),
                ).then((pickedDate) {
                  String formattedDate = DateFormat('EEEE').format(pickedDate);
                  print(formattedDate);
                  setState(() {
                    textController.text = formattedDate;
                  });
                  widget.onChanged(formattedDate);
                });
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: TextField(
                      controller: textController,
                      onChanged: (value) {
                        widget.onChanged(value);
                      },
                      style: const TextStyle(fontSize: 14),
                      decoration: const InputDecoration(
                        filled: true,
                        focusColor: Colors.red,
                        hoverColor: Colors.red,
                        fillColor: Color(0xFFFFFFFF),
                        hintText: 'Search by name/degree/dept/institute/speciality/day',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 11),
                        // prefixIcon: const Icon(Icons.search),
                        contentPadding: EdgeInsets.only(left: 16, right: 8),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            bottomLeft: Radius.circular(5.0),
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 50,
                    decoration: BoxDecoration(
                      color: cViolet,
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                      ),
                    ),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
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
