import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/configs/theme/app_colors.dart';
import '../../auth/bloc/gender_selection_cubit.dart';

class CardGender extends StatelessWidget {
  final String gender;
  final int initGender;
  final int genderIndex;
  const CardGender({
    super.key,
    required this.gender,
    required this.genderIndex,
    required this.initGender,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        context.read<GenderSelectionCubit>().selectGender(genderIndex);
      },
      child: Container(
        width: width * 0.25,
        height: height * 0.065,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color:
              context.read<GenderSelectionCubit>().selectedIndex == genderIndex
                  ? AppColors.primary
                  : AppColors.inversePrimary,
        ),
        child: Center(
          child: Text(
            gender,
            style: TextStyle(
              fontWeight: FontWeight.w800,
              color: context.read<GenderSelectionCubit>().selectedIndex ==
                      genderIndex
                  ? AppColors.inversePrimary
                  : AppColors.primary,
            ),
          ),
        ),
      ),
    );
  }
}
