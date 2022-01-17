import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomRatingBar extends StatelessWidget {
  final double starsSize;
  final bool addRate;
  final Function(double) onRatingUpdate;
  final double initRate;

  const CustomRatingBar(
      {Key? key,
      this.starsSize = 20,
      this.addRate = false,
      required this.onRatingUpdate,
      this.initRate = 2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: RatingBar.builder(
        glowRadius: 50,
        itemSize: starsSize,
        unratedColor: Colors.grey.shade300,
        initialRating: initRate,
        minRating: 1,
        updateOnDrag: false,
        ignoreGestures: !addRate,
        direction: Axis.horizontal,
        allowHalfRating: true,
        itemCount: 5,
        itemBuilder: (context, _) => const Icon(
          Icons.star,
          color: Colors.amber,
        ),
        onRatingUpdate: onRatingUpdate,
      ),
    );
  }
}
