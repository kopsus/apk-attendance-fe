import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:myapp/features/login/views/login_page.dart';
import 'package:myapp/features/profile/views/bloc/profile_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc()..add(InitEvent()),
      child: ProfileView(),
    );
  }
}

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xffF5F5F5),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              decoration: BoxDecoration(color: DistroColors.white, boxShadow: [
                DistroShadows.shadow_200,
                DistroShadows.shadow_300
              ]),
              child: Row(
                children: [
                  Spacer(),
                  Text(
                    'Profile',
                    style: DistroTypography.bodyLargeSemiBold
                        .copyWith(color: DistroColors.black),
                  ),
                  Spacer(),
                  Icon(
                    Icons.notifications_none_rounded,
                    color: DistroColors.tertiary_700,
                  )
                ],
              ),
            ),
            Expanded(child: bodySection())
          ],
        ),
      ),
    );
  }

  Widget bodySection() {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state.status == ProfileStatus.logout) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginPage()), (route) => false);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: DistroColors.tertiary_300),
                      child: Center(
                        child: Icon(
                          Icons.person_outline_outlined,
                          size: 32,
                          color: DistroColors.tertiary_500,
                        ),
                      ),
                    ),
                    HorizontalSeparator(width: 2),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.name,
                          style: DistroTypography.bodySmallSemiBold
                              .copyWith(color: DistroColors.black),
                        ),
                        Text(
                          state.role,
                          style: DistroTypography.bodySmallRegular
                              .copyWith(color: DistroColors.tertiary_500),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                          decoration: BoxDecoration(
                              color: Color(0xffE3FCEE),
                              borderRadius: BorderRadius.circular(12)),
                          child: Text(
                            'Best Employee',
                            style: DistroTypography.captionLargeSemiBold
                                .copyWith(color: DistroColors.success_500),
                          ),
                        )
                      ],
                    ),
                    Spacer(),
                    Icon(Icons.edit_outlined, color: DistroColors.black)
                  ],
                ),
              ),
              VerticalSeparator(height: 2),
              Text(
                'Account',
                style: DistroTypography.captionLargeSemiBold
                    .copyWith(color: DistroColors.tertiary_450),
              ),
              VerticalSeparator(height: 1),
              menuItem(
                  icon: SvgPicture.asset('assets/icons/ic_cerf.svg'),
                  label: 'Awards'),
              VerticalSeparator(height: 2),
              Text(
                'Others',
                style: DistroTypography.captionLargeSemiBold
                    .copyWith(color: DistroColors.tertiary_450),
              ),
              VerticalSeparator(height: 1),
              menuItem(
                  icon: SvgPicture.asset('assets/icons/ic_language.svg'),
                  label: 'Language'),
              VerticalSeparator(height: 1),
              menuItem(
                  icon: SvgPicture.asset('assets/icons/ic_privacy.svg'),
                  label: 'Term and Conditions'),
              VerticalSeparator(height: 1),
              menuItem(
                  icon: SvgPicture.asset('assets/icons/ic_info.svg'),
                  label: 'Help'),
              VerticalSeparator(height: 1),
              menuItem(
                  icon: SvgPicture.asset('assets/icons/ic_phone.svg'),
                  label: 'Contact Us'),
              Spacer(),
              SizedBox(
                height: 50,
                width: SizeConfig.screenWidth,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff88D8FF),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8))),
                  onPressed: () {
                    context.read<ProfileBloc>().add(LogOut());
                  },
                  child: Text(
                    'Log Out',
                    style: DistroTypography.bodySmallSemiBold
                        .copyWith(color: Color(0xff104087)),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget menuItem({required Widget icon, required String label}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          border: Border.all(color: DistroColors.tertiary_200, width: 1),
          color: Colors.white,
          borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          icon,
          HorizontalSeparator(width: 2),
          Text(
            label,
            style: DistroTypography.bodySmallSemiBold
                .copyWith(color: DistroColors.tertiary_700),
          )
        ],
      ),
    );
  }
}
