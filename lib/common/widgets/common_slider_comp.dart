import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:progresspallet/constants/app_dimens.dart';
import 'package:progresspallet/constants/app_sizes.dart';

class CommonSliderWidget extends StatelessWidget {
  final List<String>? bannerImages;
  const CommonSliderWidget({
    super.key,
    this.bannerImages,
  });

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        aspectRatio: 0.5,
        viewportFraction: 0.85,
        enableInfiniteScroll: true,
        autoPlay: true,
        initialPage: 0,
        enlargeCenterPage: true,
        height: AppSizes.getHeight(
          context,
          percent: 25,
        ),
      ),
      items: bannerImages?.map((element) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimens.dp10),
                color: Colors.transparent,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  element,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
