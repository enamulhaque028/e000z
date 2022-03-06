import 'dart:async';
import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:agora_rtc_engine/rtc_local_view.dart' as RtcLocalView;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as RtcRemoteView;
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:swipe/config/presentation/app_color.dart';
import 'package:swipe/pages/navbar/home/components/custom_button.dart';
import 'package:swipe/pages/navbar/home/components/bottom_pannel_tile.dart';
import 'package:swipe/pages/navbar/home/components/country_list.dart';
import 'package:swipe/pages/navbar/home/components/gender_list.dart';
import 'package:swipe/pages/navbar/home/components/profile_and_notification_tile.dart';
import 'package:swipe/pages/navbar/home/components/side_panel_tile.dart';
import 'package:swipe/pages/navbar/home/notification/notification_page.dart';
import 'package:swipe/pages/navbar/home/profile/profile_page.dart';
import 'package:swipe/pages/navbar/home/shop/shop_page.dart';
import 'package:swipe/pages/navbar/navbar_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// App state class
class _HomePageState extends State<HomePage> {
  bool _joined = false;
  int _remoteUid = 0;
  bool _switch = false;
  /// Define App ID and TOKEN
  String appId = '95ac7f4ef6df4bf2bb0deb4218bf5f22';
  String token = '00695ac7f4ef6df4bf2bb0deb4218bf5f22IAB2+rQ705v3yce9O2lYKaWGNwAcuAWegg8uIeAOlOLC2KnpWdsAAAAAEAAD1/lOW84kYgEAAQBaziRi';
  String channelName = 'swipe';
  late RtcEngine engine;
  bool isMutedAudio = false;
  bool isMutedVideo = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Init the app
  Future<void> initPlatformState() async {
    await [Permission.camera, Permission.microphone].request();

    // Create RTC client instance
    RtcEngineContext context = RtcEngineContext(appId);
    engine = await RtcEngine.createWithContext(context);
    // Define event handling logic
    engine.setEventHandler(RtcEngineEventHandler(
        joinChannelSuccess: (String channel, int uid, int elapsed) {
          print('joinChannelSuccess $channel $uid');
          setState(() {
            _joined = true;
          });
        }, userJoined: (int uid, int elapsed) {
      print('userJoined $uid');
      setState(() {
        _remoteUid = uid;
      });
    }, userOffline: (int uid, UserOfflineReason reason) {
      print('userOffline $uid');
      setState(() {
        _remoteUid = 0;
      });
    }));
    // Enable video
    await engine.enableVideo();
    // Join channel with channel name as 123
    await engine.joinChannel(token, channelName, null, 0);
  }


  // Build UI
  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: GestureDetector(
        onVerticalDragUpdate: (dragUpdateDetails) {
        _onLeaveChannel();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => NavBarPage()),
        );
      },
        child: Padding(
          padding: new EdgeInsets.only(top: statusBarHeight),
          child: Stack(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  height: double.infinity,
                  child: Center(
                    child: _switch ? _renderRemoteVideo() : _renderLocalPreview(),
                  ),
                ),
              ),
              /*:::::::::::::::::::::::::: Profile And Notification Tile ::::::::::::::::::::::::::*/
              ProfileAndNotificationTile(
                onTapProfile: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
                },
                onTapNotification: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => NotificationPage()));
                },
              ),
        
              /*:::::::::::::::::::::::::: Side Panel Tile ::::::::::::::::::::::::::*/
              SidePanelTile(
                isMutedVideo: isMutedVideo,
                onTapVideo: _onToggleMuteVideo,
                onTapCamera: _onSwitchCamera,
                isMutedAudio: isMutedAudio,
                onTapAudio: _onToggleMuteAudio,
                onTapDiamond: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ShopPage()),
                  );
                },
              ),
        
              /*:::::::::::::::::::::::::: Bottom Panel Tile ::::::::::::::::::::::::::*/
              Align(
                alignment: Alignment.bottomCenter,
                child: BottomPanelTile(
                  onTapGender: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColor.kBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                      ),
                      builder: (context) {
                        return GenderList();
                      },
                    );
                  },
                  onTapCountry: () {
                    showModalBottomSheet(
                      context: context,
                      backgroundColor: AppColor.kBackground,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                      ),
                      builder: (context) {
                        return CountryList();
                      },
                    );
                  },
                ),
              ),
              Visibility(
                visible: !isMutedVideo,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: Container(
                      width: 100,
                      height: 100,
                      color: Colors.blue,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _switch = !_switch;
                          });
                        },
                        child: Center(
                          child:
                          _switch ? _renderLocalPreview() : _renderRemoteVideo(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isVisible,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: CustomButton(
                      icon: Icons.call_end,
                      fillColor: Colors.red,
                      iconColor: Colors.white,
                      iconSize: 30,
                      onTapBtn: _onLeaveChannel,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Local preview
  Widget _renderLocalPreview() {
    if (_joined) {
      return RtcLocalView.SurfaceView();
    } else {
      return Text(
        'Please join channel first',
        textAlign: TextAlign.center,
      );
    }
  }

  // Remote preview
 Widget _renderRemoteVideo() {
    if (_remoteUid != 0) {
      return RtcRemoteView.SurfaceView(
        uid: _remoteUid,
        channelId: channelName,
      );
    } else {
      return Text(
        'Please wait remote user join',
        textAlign: TextAlign.center,
      );
    }
  }

  //Enable and Disable audio
  void _onToggleMuteAudio() async {
    setState(() {
      isMutedAudio = !isMutedAudio;
    });
    await engine.muteLocalAudioStream(isMutedAudio);
  }

  //Enable and Disable video
  void _onToggleMuteVideo() async {
    setState(() {
      isMutedVideo = !isMutedVideo;
    });
    await engine.muteLocalVideoStream(isMutedVideo);
  }

  //Switch camera
  void _onSwitchCamera() async {
    await engine.switchCamera();
  }
  
  //Switch camera
  void _onLeaveChannel() async {
    await engine.leaveChannel();
  }

}
