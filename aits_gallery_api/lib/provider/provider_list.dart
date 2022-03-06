import 'package:aits_gallery/provider/provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<GalleryDataProvider>(create: (_) => GalleryDataProvider()),
];