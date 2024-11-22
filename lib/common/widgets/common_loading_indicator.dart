import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:progresspallet/constants/app_images.dart';

class CommonLoadingIndicator extends StatelessWidget {
  const CommonLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: lottie.Lottie.asset(
        AppImages.loadingAnimation,
        width: 100,
        height: 100,
        fit: BoxFit.contain,
      ),
    );
  }
}
