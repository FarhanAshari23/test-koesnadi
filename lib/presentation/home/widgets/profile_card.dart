import 'package:flutter/material.dart';

import '../../../common/helper/app_navigation.dart';
import '../../../core/configs/theme/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final Widget nextPage;
  final IconData icon;
  const ProfileCard({
    super.key,
    required this.nextPage,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => AppNavigator.push(context, nextPage),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: width * 0.155,
          height: height * 0.095,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.secondary,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 40,
            ),
          ),
        ),
      ),
    );
  }
}
