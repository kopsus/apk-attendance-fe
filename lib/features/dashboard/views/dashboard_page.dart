import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:myapp/features/dashboard/model/menu_model.dart';
import 'package:myapp/features/dashboard/views/map_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardView();
  }
}

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  String _currentTime = '';
  String _currentDate = '';
  List<MenuModel> menus = MenuModel.getMenu();

  @override
  void initState() {
    setState(() {
        _currentTime = _getCurrentTime();
        _currentDate = _getCurrentDate();
      });
    Timer.periodic(Duration(minutes: 1), (timer) {
      setState(() {
        _currentTime = _getCurrentTime();
        _currentDate = _getCurrentDate();
      });
    });
    super.initState();
  }

  String _getCurrentTime() {
    DateTime now = DateTime.now();
    String formattedTime = '';
    if(now.minute<=9){
      formattedTime = "${now.hour}:0${now.minute}";
    }else{
      formattedTime = "${now.hour}:${now.minute}";
    }
     
    return formattedTime;
  }

  String _getCurrentDate() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEEE, dd MMMM').format(now);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DistroColors.white,
      body: Stack(
        children: [
          //background
          Container(
            width: SizeConfig.screenWidth,
            height: SizeConfig.screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff096F9F),
                  Color(0xff88D8FF)
                ]
              )
            ),
          ),
          //body
          bodySection(),
          //appbar
          homepageAppBar(),
          //clock-in or clock-out
        ],
      ),
    );
  }

  Widget bodySection() {
    return SafeArea(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(top: (SizeConfig.safeBlockVertical*10) + 30),
                  child: Column(
                    children: [
                      Text(_currentTime, 
                        style: DistroTypography.heading4.copyWith(
                          fontWeight: FontWeight.w600,
                          color: DistroColors.tertiary_50)),
                      VerticalSeparator(height: .5),
                      Text(_currentDate, 
                        style: DistroTypography.bodySmallRegular.copyWith(
                          color: DistroColors.tertiary_50
                      )),
                      VerticalSeparator(height: 3),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>MapPage(location: GeoPoint(latitude: 6.175895, longitude: 106.827125),)));
                        },
                        child: Container(
                          height: SizeConfig.safeBlockHorizontal*30,
                          width: SizeConfig.safeBlockHorizontal*30,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color(0xff88D8FF),
                                Colors.white
                              ]
                            ),
                            boxShadow: [
                              DistroShadows.shadow_200,
                              DistroShadows.shadow_300
                            ]
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/illustration/hand.svg', width: 56, fit: BoxFit.fitWidth),
                              VerticalSeparator(height: 1),
                              Text('Clock-in', 
                                style: DistroTypography.bodySmallSemiBold.copyWith(
                                  color: DistroColors.tertiary_700))
                            ],
                          ),
                        ),
                      ),
                      VerticalSeparator(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on, 
                            color: DistroColors.tertiary_50, 
                            size: 14),
                          Text('Location', 
                            style: DistroTypography.bodySmallRegular.copyWith(
                              color: DistroColors.tertiary_50))
                        ],
                      ),
                      VerticalSeparator(height: 3),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          clockWidget(
                            assets: 'assets/illustration/clock.svg',
                            label: 'Clock-In'
                          ),
                          clockWidget(
                            assets: 'assets/illustration/afternoon.svg',
                            label: 'Clock-Out'
                          ),
                          clockWidget(
                            assets: 'assets/illustration/countdown.svg',
                            label: 'Working Hrs'
                          ),
                        ],
                      ),
                      VerticalSeparator(height: 3),
                      bottomSheet(),
                    ],
                  ),
                ),
              ),
              SafeArea(child: homepageVector()),
            ],
          ),
        ],
          ),
    );
  }

  Widget bottomSheet() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: SizeConfig.safeBlockVertical*40,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: DistroColors.tertiary_50,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            menuSection(),
            VerticalSeparator(height: 3),
            Text('Your Activity', 
              style: DistroTypography.bodyLargeSemiBold.copyWith(
                color: DistroColors.tertiary_700
              )),
            VerticalSeparator(height: 3),
            ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) => Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: DistroColors.white,
                  borderRadius: BorderRadius.circular(12)
                ),
                child: Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: DistroColors.primary_400
                      ),
                      child: SvgPicture.asset('assets/illustration/in.svg'),
                    ),
                    HorizontalSeparator(width: 5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Clock-In', 
                          style: DistroTypography.bodyLargeSemiBold.copyWith(
                            color: DistroColors.tertiary_600)),
                        VerticalSeparator(height: .5),
                        Text('1 January 2024', 
                          style: DistroTypography.bodySmallRegular.copyWith(
                            color: DistroColors.tertiary_400))
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('00:00', 
                          style: DistroTypography.bodyLargeSemiBold.copyWith(
                            color: DistroColors.tertiary_600)),
                        VerticalSeparator(height: .5),
                        Text('On-time', 
                          style: DistroTypography.bodySmallRegular.copyWith(
                            color: DistroColors.tertiary_400))
                      ],
                    )
                  ],
                ),
              ),
              separatorBuilder: (_,__)=>VerticalSeparator(height: 2),)
          ],
        )
      ),
    );
  }

  GridView menuSection() {
    return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.only(top: 8),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisSpacing: SizeConfig.safeBlockHorizontal*2,
            mainAxisSpacing: SizeConfig.safeBlockVertical*2,
            crossAxisCount: 4),
          itemCount: menus.length,
          itemBuilder: (context, index) => menuItem(index),
        );
  }

  Container menuItem(int index) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: DistroColors.white,
      ),
      child: Column(
        children: [
          Image.asset(menus[index].assets,
            height: 28, 
            fit: BoxFit.fitHeight),
          VerticalSeparator(height: .5),
          Text(menus[index].label, 
            style: DistroTypography.captionLargeSemiBold.copyWith(
              color: DistroColors.tertiary_600
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  SizedBox clockWidget({required String assets, String? time, required String label}) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          SvgPicture.asset(assets,
            width: 26, 
            fit: BoxFit.fitWidth),
          VerticalSeparator(height: 1),
          Text(time != null ? time : '--:--',
            style: DistroTypography.bodyLargeSemiBold.copyWith(
              color: DistroColors.tertiary_50
            )),
          VerticalSeparator(height: .25),
          Text(label,
            style: DistroTypography.captionLargeRegular.copyWith(
              color: DistroColors.tertiary_50
            ))
        ],
      ),
    );
  }

  SafeArea homepageAppBar() {
    return SafeArea(
          child: Container(
            height: 80,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xff00F0FF),
                  Color(0xff096F9F)
                ]
              )
            ),
            child: Stack(
              children: [
                homepageVector(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical:16),
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: DistroColors.tertiary_300
                          ),
                          child: Center(child: Icon(Icons.person_outline_outlined, size: 32, color: DistroColors.tertiary_500,),),
                        ),
                        HorizontalSeparator(width: 3),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Name', style: DistroTypography.bodyLargeSemiBold.copyWith(color: DistroColors.tertiary_50),),
                            Text('Role', style: DistroTypography.bodySmallRegular.copyWith(color: DistroColors.tertiary_100),)
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.notifications_outlined, color: DistroColors.white,)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
  }

  SvgPicture homepageVector() {
    return SvgPicture.asset(
                'assets/illustration/homepage_vector.svg',
                 width: SizeConfig.safeBlockHorizontal*30, 
                 fit: BoxFit.fitWidth,
                 alignment: Alignment.topLeft,);
  }
}