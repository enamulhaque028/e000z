import 'package:flutter/material.dart';
import 'package:swipe/config/presentation/app_color.dart';

class SidePanelTile extends StatelessWidget {
  final VoidCallback onTapVideo;
  final VoidCallback onTapCamera;
  final VoidCallback onTapAudio;
  final VoidCallback onTapDiamond;
  final bool isMutedVideo;
  final bool isMutedAudio;
  const SidePanelTile({
    Key? key,
    required this.onTapVideo,
    required this.onTapCamera,
    required this.onTapAudio,
    required this.onTapDiamond,
    required this.isMutedVideo,
    required this.isMutedAudio,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(bottom: 70.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(height: height * 0.1),
                Container(
                  height: height * 0.35,
                  width: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    color: AppColor.kBackground,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ItemTile(
                          assetImgPath: isMutedVideo ? 'assets/images/video_off.png' : 'assets/images/video.png',
                          onTap: () {
                            onTapVideo();
                          },
                        ),
                        ItemTile(
                          assetImgPath: 'assets/images/switch_camera.png',
                          onTap: () {
                            onTapCamera();
                          },
                        ),
                        ItemTile(
                          assetImgPath: isMutedAudio ? 'assets/images/audio_off.png' :'assets/images/audio.png',
                          onTap: () {
                            onTapAudio();
                          },
                        ),
                        InkWell(
                          onTap: () {
                            onTapDiamond();
                          },
                          child: CircleAvatar(
                            backgroundColor: AppColor.kBackground,
                            radius: 20,
                            child: Image.asset(
                              'assets/images/diamond.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}

class ItemTile extends StatelessWidget {
  final String assetImgPath;
  final VoidCallback onTap;
  const ItemTile({
    Key? key,
    required this.assetImgPath,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: CircleAvatar(
        backgroundColor: AppColor.iconBackground,
        radius: 18,
        child: Image.asset(
          assetImgPath,
          height: 25,
          width: 25,
          color: Colors.blue,
        ),
      ),
    );
  }
}
