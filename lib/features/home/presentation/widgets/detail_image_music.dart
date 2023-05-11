import 'package:flutter/material.dart';

import '../../../../component/image_widget.dart';

class DetailImageMusic extends StatelessWidget {
  final String urlImage;

  const DetailImageMusic({Key? key, required this.urlImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _detailImage(context);
  }

  _detailImage(context) {
    return ImageWidget(
      imageUrl: urlImage,
      width: double.maxFinite,
      height: MediaQuery.of(context).size.height * 0.50,
      borderRadiusGeometry: BorderRadius.circular(0),
      fit: BoxFit.fill,
    );
  }
}
