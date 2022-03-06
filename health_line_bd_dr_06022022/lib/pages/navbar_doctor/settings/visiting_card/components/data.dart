import 'model.dart';

List<VisitingCardModel> getVisitingcardData() {
  List<VisitingCardModel> data = [];

  //card1
  data.add(
    VisitingCardModel(
      imageUrl:
          'https://images.creativemarket.com/0.1.0/ps/4334228/1500/1125/m1/fpnw/wm0/01_screenshot-.jpg?1524336486&s=4c37fa2c8248e20ea8a8d4b5cd4f7e8c',
      isSelected: false,
      spValue: 'card1',
    ),
  );
  //card2
  data.add(
    VisitingCardModel(
      imageUrl:
          'https://fiverr-res.cloudinary.com/images/q_auto,f_auto/gigs/123876881/original/bb763249b3e099278e855f8ab4fbac74f85bc3a1/design-amazing-business-card-for-you.jpg',
      isSelected: false,
      spValue: 'card2',
    ),
  );
  //card3
  data.add(
    VisitingCardModel(
      imageUrl:
          'https://5.imimg.com/data5/SELLER/Default/2021/2/QR/AZ/AN/46661134/business-card-design-250x250.jpg',
      isSelected: false,
      spValue: 'card3',
    ),
  );

  return data;
}
