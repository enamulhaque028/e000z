import 'package:clay_containers/clay_containers.dart';
import 'package:flutter/material.dart';

class BottomContainer extends StatelessWidget {
  final VoidCallback onTap;
  const BottomContainer({Key key, @required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    const double appPadding = 30.0;
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        child: ClayContainer(
          color: Colors.white,
          height: size.height * 0.3,
          depth: 60,
          spread: 20,
          curveType: CurveType.convex,
          customBorderRadius: BorderRadius.only(
            topRight: Radius.elliptical(350, 250),
            topLeft: Radius.elliptical(350, 250),
          ),
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.07,
              ),
              InkWell(
                onTap: () {
                  onTap();
                },
                child: ClayContainer(
                  color: Colors.white,
                  depth: 50,
                  borderRadius: 30,
                  curveType: CurveType.convex,
                  emboss: true,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: appPadding / 2, horizontal: appPadding * 2),
                    child: Text(
                      'Send',
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
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
}
