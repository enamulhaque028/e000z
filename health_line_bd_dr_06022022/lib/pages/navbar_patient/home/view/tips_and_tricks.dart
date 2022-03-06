import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:health_line_bd/widgets/play_youtube_video.dart';

class TipsAndTricks extends StatefulWidget {
  final String videoUrl;
  final String videoTitle;
  final String videoDuration;
  TipsAndTricks({
    @required this.videoUrl,
    @required this.videoTitle,
    @required this.videoDuration,
  });

  @override
  _TipsAndTricksState createState() => _TipsAndTricksState();
}

class _TipsAndTricksState extends State<TipsAndTricks> {
  bool isVideoAvailable = true;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        !isVideoAvailable
            ? CoolAlert.show(
                context: context,
                type: CoolAlertType.error,
                text: "Video not available!",
              )
            : playYoutubeVideo(
                context: context,
                videoId: widget.videoUrl,
              );
      },
      child: Container(
        width: 210,
        margin: EdgeInsets.only(right: 5),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    ),
                    child: Image.network(
                      'https://i3.ytimg.com/vi_webp/${widget.videoUrl}/sddefault.webp',
                      height: 90,
                      width: 210,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        // Appropriate logging or analytics, e.g.
                        // myAnalytics.recordError(
                        //   'An error occurred loading "https://example.does.not.exist/image.jpg"',
                        //   exception,
                        //   stackTrace,
                        // );
                        Future.delayed(Duration.zero, () async {
                          setState(() {
                            isVideoAvailable = false;
                          });
                        });

                        return Center(
                          child: Image.asset(
                            'assets/images/no_img.png',
                            height: 105,
                            width: 210,
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    ),
                  ),
                  Positioned(
                    top: 25,
                    left: 80,
                    child: Image.asset(
                      'assets/images/play_button.png',
                      height: 45,
                      width: 45,
                    ),
                  ),
                  Positioned(
                    bottom: 3,
                    right: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.75),
                          borderRadius: BorderRadius.all(Radius.circular(3))),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3),
                        child: Text(
                          widget.videoDuration,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, left: 5.0, right: 5.0),
                child: Text(
                  widget.videoTitle,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
