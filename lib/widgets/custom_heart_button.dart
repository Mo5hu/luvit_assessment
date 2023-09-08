import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

class CustomHeartButton extends StatelessWidget {
  const CustomHeartButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 16),
      child: SvgPicture.asset(
        'assets/heart.svg',
        height: 52,
        width: 52,
      ),
    );
  }
}
