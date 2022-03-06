import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/chat_list_model.dart';
import 'package:swipe/services/chat/chat_list_service.dart';
import 'package:swipe/services/chat/send_chat_service.dart';
import 'package:swipe/widgets/custom_button.dart';
import 'package:swipe/widgets/shimmer_effect.dart';
import 'components/chat_header_tile.dart';
import 'components/chatbox_tile.dart';

class ChatDetailPage extends StatefulWidget {
  @override
  State<ChatDetailPage> createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late ChatListModel chatListInfo;
  bool isLoading = true;
  final TextEditingController chatController = new TextEditingController();
  final SendChatService sendChatService = new SendChatService();
  @override
  void initState() {
    ChatListService().fetchChats().then((value) {
      setState(() {
        chatListInfo = value;
        isLoading = false;
      });
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // var messages = ChatMessage.messages;
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            clipBehavior: Clip.none,
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover,
                height: 180,
                width: size.width,
              ),
              Positioned(
                top: 50,
                left: 16,
                child: CustomButton(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  iconData: Icons.arrow_back_ios_new,
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 130),
                height: size.height,
                child: Column(
                  children: [
                    ChatHeaderTile(
                      imageUrl: "assets/images/background.png",
                      name: "Maciej Kowalski",
                      activeStatus: "Online",
                    ),
                    Expanded(
                      child: Container(
                        width: size.width,
                        child: isLoading
                          ? Center(child: ShimmerList())
                          :  ListView.builder(
                          itemCount: chatListInfo.chats!.length,
                          shrinkWrap: true,
                          reverse: true,
                          // physics: ClampingScrollPhysics(),
                          padding: EdgeInsets.only(top: 10, bottom: 120),
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var chats = chatListInfo.chats![index];
                            return Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 14,
                              ),
                              child: Align(
                                alignment: chats.userId == "61e3b633238dd28a6f5f8608"
                                ? Alignment.topRight
                                : Alignment.topLeft,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: chats.userId == "61e3b633238dd28a6f5f8608"
                                    ? Colors.blue[200]
                                    : Colors.grey.shade200,
                                  ),
                                  padding: EdgeInsets.all(16),
                                  child: Text(
                                    chats.text.toString(),
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 0,
                child: ChatBoxTile(
                  chatController: chatController,
                  onChatSend: (chatText) {
                    if (chatController.text.isNotEmpty) {
                       sendChatService.sendMesage(text: chatController.text).then((value) {
                        ChatListService().fetchChats().then((value) {
                          setState(() {
                            chatListInfo = value;
                            chatController.clear();
                          });
                        });
                      });
                    }
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
