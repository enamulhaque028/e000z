import 'package:aits_gallery/screens/home/gallery/gallery_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('AITS Gallery'),
          leading: Icon(Icons.menu),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[Color(0xFF1ACBFC), Color(0xFF1B90F5)],
              ),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () async {},
              icon: Icon(Icons.search),
            ),
          ],
          centerTitle: true,
          bottom: TabBar(
            padding: EdgeInsets.all(8),
            indicator: ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
              ),
              color: Colors.blue,
            ),
            tabs: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Album'),
                ),
              ),
              Center(child: Text('Photos')),
              Center(child: Text('Private')),
            ],
          ),
        ),
        body: TabBarView(children: <Widget>[
          GalleryPage(),
          GalleryPage(),
          GalleryPage(),
        ]),
      ),
    );
  }
}
