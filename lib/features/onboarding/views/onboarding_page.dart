import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/features/login/views/login_page.dart';
import 'package:myapp/features/onboarding/model/onboarding_model.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final List<OnboardingModel> list = OnboardingModel.generateOnboardingList();
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: DistroColors.primary_400,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SafeArea(
            child: Visibility(
              visible: currentPage != list.length - 1,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_)=> const LoginPage())
                            );
                      },
                      child: Text(
                        'Skip',
                        style: DistroTypography.bodySmallSemiBold.copyWith(
                          color: DistroColors.tertiary_700)
                      )
                    ),
                    HorizontalSeparator(width: 1),
                    const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: DistroColors.tertiary_700),
                  ],
                ),
              ),
            ),
          ),
          const Spacer(),
          SvgPicture.asset(
            list[currentPage].imageUrl, 
            width: SizeConfig.safeBlockHorizontal*80,
            fit: BoxFit.fitWidth,
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            height: SizeConfig.blockSizeVertical*40,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              color: DistroColors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(list[currentPage].title, style: DistroTypography.bodyLargeSemiBold.copyWith(color: DistroColors.tertiary_600, fontSize: 22)),
                const VerticalSeparator(height: 1),
                Text(list[currentPage].description, style: DistroTypography.bodyLargeRegular.copyWith(color: DistroColors.tertiary_600,),),
                const Spacer(),
                SafeArea(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 6,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: list.length,
                          itemBuilder: (context, index){
                            return Container(
                              height: 6,
                              width: SizeConfig.safeBlockHorizontal*(index == currentPage ? 12 : 3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                color: index == currentPage ? DistroColors.primary_500 : DistroColors.primary_300
                              ),
                            );
                          }, 
                          separatorBuilder: (_,__) => const HorizontalSeparator(width: 1)),
                      ),
                      DistroElevatedButton(
                        label: Text(
                          list[currentPage].buttonLabel, 
                          style: DistroTypography.bodySmallSemiBold.copyWith(color: DistroColors.white)),
                        onPressed: (){
                          if(currentPage == list.length-1){
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_)=> const LoginPage())
                            );
                          }else {
                            setState(() {
                              currentPage++;
                            });
                          }
                        })
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}