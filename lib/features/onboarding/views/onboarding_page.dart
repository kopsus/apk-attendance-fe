import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:myapp/features/onboarding/model/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<OnboardingModel> list = OnboardingModel.generateOnboardingList();
  int currentPage = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DistroColors.primary_400,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(
              visible: currentPage == list.length - 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('Skip', style: DistroTypography.bodySmallSemiBold.copyWith(color: DistroColors.tertiary_700)),
                  const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: DistroColors.tertiary_700),
                ],
              ),
            ),
            PageView.builder(
              controller: _pageController,
              itemCount: list.length,
              onPageChanged: (index){
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: ((context, index) {
                return Column();
              }))
          ],
        )
      )
    );
  }
}