import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:health_line_bd/config/common_const.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:health_line_bd/theme/init_theme_choose.dart';

class CustomSlider extends StatelessWidget {
  const CustomSlider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    List<String> imageUrl = [
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
      'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
      'https://images.unsplash.com/photo-1579154204601-01588f351e67?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
      'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
      'https://images.unsplash.com/photo-1581093450021-4a7360e9a6b5?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
    ];
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: height,
            width: width,
            child: Center(
              child: Swiper(
                itemBuilder: (BuildContext context, int index) {
                  return Image.network(
                    imageUrl[index],
                    fit: BoxFit.cover,
                  );
                },
                itemCount: imageUrl.length,
                pagination: new SwiperPagination(
                  margin: EdgeInsets.only(bottom: 80),
                ),
                control: new SwiperControl(),
                autoplay: false,
              ),
            ),
          ),
          Positioned(
              left: width * 0.5 - 42,
              bottom: 20,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => InitThemeChoose(),
                    ),
                    (Route<dynamic> route) => false,
                  );
                },
                child: Row(
                  children: [
                    Text('Skip'),
                    SizedBox(width: 5),
                    Icon(Icons.play_circle_outline),
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF333333),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12), // <-- Radius
                  ),
                ),
              ))
        ],
      ),
    );
  }
}

// class CustomSlider extends StatefulWidget {
//   @override
//   _CustomSliderState createState() => _CustomSliderState();
// }

// class _CustomSliderState extends State<CustomSlider> {
//   final int _numPages = 2;
//   final PageController _pageController = PageController(initialPage: 0);
//   int _currentPage = 0;

//   List<Widget> _buildPageIndicator() {
//     List<Widget> list = [];
//     for (int i = 0; i < _numPages; i++) {
//       list.add(i == _currentPage ? _indicator(true) : _indicator(false));
//     }
//     return list;
//   }

//   Widget _indicator(bool isActive) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 150),
//       margin: EdgeInsets.symmetric(horizontal: 8.0),
//       height: 12.0,
//       width: isActive ? 24.0 : 16.0,
//       decoration: BoxDecoration(
//         color: isActive ? Color(PrimaryColor) : Colors.grey[300],
//         shape: BoxShape.circle,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: cViolet,
//       body: AnnotatedRegion<SystemUiOverlayStyle>(
//         value: SystemUiOverlayStyle.light,
//         child: Column(
//           children: [
//             // Container(),
//             // Image.asset('assets/images/splash_icon.png', height: 145),
//             Column(
//               children: [
//                 Container(
//                   decoration: BoxDecoration(
//                       borderRadius:
//                           BorderRadius.only(bottomLeft: Radius.circular(20))),
//                   height: MediaQuery.of(context).size.height - 100,
//                   width: MediaQuery.of(context).size.width,
//                   child: PageView(
//                     physics: ClampingScrollPhysics(),
//                     controller: _pageController,
//                     onPageChanged: (int page) {
//                       setState(() {
//                         _currentPage = page;
//                       });
//                     },
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.only(
//                                 bottomLeft: Radius.circular(20))),
//                         child: Image.network(
//                           'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
//                           fit: BoxFit.fill,
//                         ),
//                       ),
//                       Image.network(
//                         'https://images.unsplash.com/photo-1532187863486-abf9dbad1b69?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1500&q=80',
//                         fit: BoxFit.fill,
//                       ),
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: _buildPageIndicator(),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
