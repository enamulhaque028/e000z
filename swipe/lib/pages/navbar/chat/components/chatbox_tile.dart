import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class ChatBoxTile extends StatelessWidget {
  final TextEditingController chatController;
  final Function(String) onChatSend;
  const ChatBoxTile({
    Key? key,
    required this.chatController,
    required this.onChatSend,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: 100,
      color: AppColor.iconBackground,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: TextFormField(
                    controller: chatController,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.attach_file),
                      suffixIcon: Icon(Icons.keyboard_voice_outlined),
                      hintText: 'Message...',
                      hintStyle: TextStyle(color: AppColor.primaryTextColor),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.transparent,
                          width: 1,
                        ),
                      ),
                      filled: true,
                      fillColor: AppColor.kBackground,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              InkWell(
                onTap: () {
                  onChatSend(chatController.text);
                },
                child: Image.asset(
                  'assets/images/send_btn.png',
                  height: 55,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
