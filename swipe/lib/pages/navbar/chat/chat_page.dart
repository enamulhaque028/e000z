import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/models/chat_list_model.dart';
import 'package:swipe/pages/navbar/chat/chat_details_page.dart';
import 'package:swipe/services/chat/chat_list_service.dart';
import 'package:swipe/widgets/shimmer_effect.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late ChatListModel chatListInfo;
  bool isLoading = true;
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
    return Scaffold(
      backgroundColor: AppColor.kBackground,
      body: Builder(
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Image.asset(
                'assets/images/bg.png',
                fit: BoxFit.cover, height: 220, width: size.width,
              ),
              Positioned(
                top: 60,
                child: Container(
                  width: size.width,
                  child: Center(
                    child: Text(
                      'Chat',
                      style: TextStyle(fontSize: 18, color: AppColor.kBackground,
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  height: size.height,
                  padding: EdgeInsets.only(top: 120),
                  child: Card(
                    color: AppColor.kBackground,
                    elevation: 0.0,
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    child: isLoading
                    ? Center(child: ShimmerList())
                    : ListView.builder(
                        shrinkWrap: true,
                        itemCount: chatListInfo.chats!.length,
                        itemBuilder: (context, index) {
                          var chats = chatListInfo.chats![index];
                          String formatDate = DateFormat("MMMM d").format(chats.time!);
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => ChatDetailPage()),
                              );
                            },
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    backgroundColor: AppColor.kBackground,
                                    radius: 29.0,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: AssetImage("assets/images/background.png"),
                                    ),
                                  ),
                                  title: Text(
                                    'Maciej Kowalski',
                                    style: TextStyle(
                                      color: AppColor.secondaryTextColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                    ),
                                  ),
                                  subtitle: Text(
                                    chats.text.toString(),
                                    style: TextStyle(
                                      color: Color.fromRGBO(129, 129, 152, 1),
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  trailing: Text(
                                    formatDate.toString(),
                                    style: TextStyle(
                                      color: AppColor.secondaryTextColor,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                                Divider(thickness: 1)
                              ],
                            ),
                          );
                        }),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
