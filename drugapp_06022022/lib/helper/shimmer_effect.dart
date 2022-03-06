import 'package:flutter/material.dart';
import 'package:mediinfo/services/db/db_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatefulWidget {
  @override
  _ShimmerListState createState() => _ShimmerListState();
}

class _ShimmerListState extends State<ShimmerList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  DBProvider dbProvider = DBProvider();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SmartRefresher(
        controller: _refreshController,
        onRefresh: () async {
          await dbProvider.getAllProducts();
          // if failed,use refreshFailed()
          _refreshController.refreshCompleted();
        },
        enablePullDown: true,
        enablePullUp: true,
        header: WaterDropMaterialHeader(),
        child: ListView.builder(
          itemCount: 6,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.grey[300],
                  child: ShimmerLayout(),
                ));
          },
        ),
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              bottom: 8,
              left: 8,
              right: 8,
            ),
            child: Container(
              height: 70,
              width: 70,
              color: Colors.grey,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: height / 40,
                width: width / 1.60,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: height / 40,
                width: width / 1.60,
                color: Colors.grey,
              ),
              SizedBox(height: 5),
              Container(
                height: height / 40,
                width: width / 1.60 * 0.75,
                color: Colors.grey,
              )
            ],
          )
        ],
      ),
    );
  }
}
