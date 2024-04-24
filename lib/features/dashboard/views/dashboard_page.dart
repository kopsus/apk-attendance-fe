import 'dart:async';

import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:myapp/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:myapp/features/dashboard/model/menu_model.dart';
import 'package:myapp/features/dashboard/views/map_page.dart';
import 'package:myapp/features/profile/views/profile_page.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => DashboardBloc()..add(InitEvent()),
      child: const DashboardView(),
    );
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
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

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
    DateTime now = DateTime.now().toLocal();
    String formattedTime = '';
    if (now.minute <= 9) {
      formattedTime = "${now.hour}:0${now.minute}";
    } else {
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
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        backgroundColor: DistroColors.white,
        body: TabBarView(
          children: [
            Stack(
              children: [
                //background
                Container(
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.screenHeight,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xff1E5EBD), Color(0xff032250)])),
                ),
                //body
                bodySection(),
                //appbar
                homepageAppBar(),
                //clock-in or clock-out
              ],
            ),
            SizedBox(),
            SizedBox(),
            SizedBox(),
            ProfilePage()
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                offset: Offset(0, -4),
                color: Color(0xff18274B).withOpacity(.1),
                spreadRadius: -2,
                blurRadius: 4),
            BoxShadow(
                offset: Offset(0, -2),
                color: Color(0xff18274B).withOpacity(.12),
                spreadRadius: -2,
                blurRadius: 4)
          ]),
          child: TabBar(
            labelPadding: EdgeInsets.symmetric(horizontal: 4),
            padding: EdgeInsets.zero,
            indicator: BoxDecoration(),
            unselectedLabelStyle: DistroTypography.captionLargeRegular
                .copyWith(color: DistroColors.tertiary_500),
            unselectedLabelColor: DistroColors.tertiary_500,
            labelStyle: DistroTypography.captionLargeRegular
                .copyWith(color: DistroColors.primary_600),
            labelColor: DistroColors.primary_600,
            tabs: [
              Container(
                padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home_outlined),
                    VerticalSeparator(height: .35),
                    Text('Home')
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.calendar_month_outlined),
                    VerticalSeparator(height: .35),
                    Text('Schedule')
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.people_outline),
                    VerticalSeparator(height: .35),
                    Text('Employee')
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.history_outlined),
                    VerticalSeparator(height: .35),
                    Text('Activity')
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person_outlined),
                    VerticalSeparator(height: .35),
                    Text('Profile')
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bodySection() {
    return SafeArea(
      child: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () async {
          context.read<DashboardBloc>().add(InitEvent());
        },
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    margin: EdgeInsets.only(
                        top: (SizeConfig.safeBlockVertical * 10) + 30),
                    child: BlocConsumer<DashboardBloc, DashboardState>(
                      listener: (context, state) {
                        if (state.status == DashboardStatus.initSuccess) {
                          context
                              .read<DashboardBloc>()
                              .add(GetDashboardHistory());
                          context
                              .read<DashboardBloc>()
                              .add(GetDashboardStatus());
                          context.read<DashboardBloc>().add(GetUserDetail());
                        }
                        if (state.status == DashboardStatus.locationDisable) {
                          showDialog(
                              context: context,
                              builder: (buildContext) => BlocProvider.value(
                                    value: context.read<DashboardBloc>(),
                                    child: PopScope(
                                      onPopInvoked: (pop) {
                                        context
                                            .read<DashboardBloc>()
                                            .add(InitEvent());
                                      },
                                      child: DistroAlertDialog(
                                        contents: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.pop(buildContext);
                                                },
                                                child: const Icon(
                                                  Icons.close_rounded,
                                                  color: DistroColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          VerticalSeparator(height: 2),
                                          Image.asset(
                                            'assets/illustration/location_off.png',
                                            width:
                                                SizeConfig.safeBlockHorizontal *
                                                    60,
                                            fit: BoxFit.fitWidth,
                                          ),
                                          VerticalSeparator(height: 2),
                                          Text(
                                            'Enable Location for Seamless Attendance',
                                            style: DistroTypography
                                                .bodyLargeSemiBold
                                                .copyWith(
                                                    color: DistroColors
                                                        .tertiary_700),
                                          ),
                                        ],
                                        actions: [
                                          DistroElevatedButton(
                                              fullWidth: true,
                                              label: Text(
                                                'Turn On Location',
                                                style: DistroTypography
                                                    .bodySmallSemiBold
                                                    .copyWith(
                                                        color:
                                                            DistroColors.white),
                                              ),
                                              onPressed: () {
                                                Geolocator.openAppSettings();
                                              })
                                        ],
                                      ),
                                    ),
                                  ));
                        }
                        if (state.status == DashboardStatus.failed) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                                  backgroundColor: DistroColors.warning_500,
                                  content: Text(
                                    'Gagal tersambung ke server, cek koneksi anda atau tunggu beberapa saat lagi',
                                    style: TextStyle(color: Colors.white),
                                  )));
                        }
                        if (state.isNearLocation == false) {
                          showDialog(
                              context: context,
                              builder: (buildContext) => BlocProvider.value(
                                    value: context.read<DashboardBloc>(),
                                    child: DistroAlertDialog(
                                      contents: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Navigator.pop(buildContext);
                                              },
                                              child: const Icon(
                                                Icons.close_rounded,
                                                color: DistroColors.black,
                                              ),
                                            ),
                                          ],
                                        ),
                                        VerticalSeparator(height: 2),
                                        Image.asset(
                                          'assets/illustration/not_near_location.png',
                                          width:
                                              SizeConfig.safeBlockHorizontal *
                                                  60,
                                          fit: BoxFit.fitWidth,
                                        ),
                                        VerticalSeparator(height: 2),
                                        Text(
                                          'You’re outside the attendance area',
                                          style: DistroTypography
                                              .bodyLargeSemiBold
                                              .copyWith(
                                                  color: DistroColors
                                                      .tertiary_700),
                                        ),
                                        VerticalSeparator(height: 1),
                                        Text(
                                          'Sorry, it looks like you are outside the absence area. To continue, please do so with permission.',
                                          style: DistroTypography
                                              .bodySmallRegular
                                              .copyWith(
                                                  color: DistroColors.black),
                                        ),
                                      ],
                                      actions: [
                                        DistroElevatedButton(
                                            fullWidth: true,
                                            label: Text(
                                              'Permissions',
                                              style: DistroTypography
                                                  .bodySmallSemiBold
                                                  .copyWith(
                                                      color:
                                                          DistroColors.white),
                                            ),
                                            onPressed: () {})
                                      ],
                                    ),
                                  ));
                        } else if (state.isNearLocation == true) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                        value: context.read<DashboardBloc>(),
                                        child: MapPage(),
                                      )));
                        }
                      },
                      builder: (context, state) {
                        if (state.status == DashboardStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: DistroColors.primary_500,
                            ),
                          );
                        }
                        return Column(
                          children: [
                            Text(_currentTime,
                                style: DistroTypography.heading4.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: DistroColors.tertiary_50)),
                            VerticalSeparator(height: .5),
                            Text(_currentDate,
                                style: DistroTypography.bodySmallRegular
                                    .copyWith(color: DistroColors.tertiary_50)),
                            VerticalSeparator(height: 3),
                            InkWell(
                              onTap: () {
                                if (state.status == DashboardStatus.failed) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          backgroundColor:
                                              DistroColors.warning_500,
                                          content: Text(
                                            'Please refresh this page',
                                            style:
                                                TextStyle(color: Colors.white),
                                          )));
                                } else {
                                  context.read<DashboardBloc>().add(
                                      CheckNearLocation(
                                          currentPosition: state.position!,
                                          companyLat: state.companyLat,
                                          companyLong: state.companyLong));
                                }
                              },
                              child: Container(
                                height: SizeConfig.safeBlockHorizontal * 30,
                                width: SizeConfig.safeBlockHorizontal * 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24),
                                    color: DistroColors.success_500,
                                    gradient: state.isClockIn
                                        ? LinearGradient(
                                            begin: Alignment.topRight,
                                            end: Alignment.bottomLeft,
                                            colors: [
                                                Color(0xff096F9F),
                                                Color(0xff6C47FF)
                                              ])
                                        : null,
                                    boxShadow: [
                                      DistroShadows.shadow_200,
                                      DistroShadows.shadow_300
                                    ]),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                        'assets/illustration/hand.svg',
                                        width: 56,
                                        fit: BoxFit.fitWidth),
                                    VerticalSeparator(height: 1),
                                    Text(
                                        state.isClockIn
                                            ? 'Clock-out'
                                            : 'Clock-in',
                                        style: DistroTypography
                                            .bodySmallSemiBold
                                            .copyWith(
                                                color: DistroColors.white))
                                  ],
                                ),
                              ),
                            ),
                            VerticalSeparator(height: 3),
                            SizedBox(
                              width: SizeConfig.safeBlockHorizontal * 70,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.location_on,
                                      color: DistroColors.tertiary_50,
                                      size: 20),
                                  HorizontalSeparator(width: 2),
                                  Expanded(
                                    child: Text(state.location,
                                        style: DistroTypography.bodySmallRegular
                                            .copyWith(
                                                color:
                                                    DistroColors.tertiary_50)),
                                  )
                                ],
                              ),
                            ),
                            VerticalSeparator(height: 3),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                clockWidget(
                                    assets: 'assets/illustration/clock.svg',
                                    time: state.clockInTime,
                                    label: 'Clock-In'),
                                clockWidget(
                                    assets: 'assets/illustration/afternoon.svg',
                                    time: state.clockOutTime,
                                    label: 'Clock-Out'),
                                clockWidget(
                                    assets: 'assets/illustration/countdown.svg',
                                    time: state.workingHours,
                                    label: 'Working Hrs'),
                              ],
                            ),
                            VerticalSeparator(height: 3),
                            bottomSheet(),
                          ],
                        );
                      },
                    ),
                  ),
                ),
                // SafeArea(child: homepageVector()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: SizeConfig.safeBlockVertical * 40,
      ),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          decoration: BoxDecoration(
              color: DistroColors.tertiary_50,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              menuSection(),
              VerticalSeparator(height: 3),
              Text('Your Activity',
                  style: DistroTypography.bodyLargeSemiBold
                      .copyWith(color: DistroColors.tertiary_700)),
              VerticalSeparator(height: 3),
              BlocBuilder<DashboardBloc, DashboardState>(
                builder: (context, state) {
                  return ListView.separated(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: state.historyList.length,
                    itemBuilder: (context, index) {
                      var asset = state.historyList[index].action == 'CHECK_IN'
                          ? 'assets/illustration/in.svg'
                          : 'assets/illustration/out.svg';
                      var date = DateFormat('dd MMMM yyyy').format(
                          DateTime.fromMillisecondsSinceEpoch(
                                  state.historyList[index].timestamp!)
                              .toLocal());
                      var time = DateFormat('HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                                  state.historyList[index].timestamp!)
                              .toLocal());
                      var title = state.historyList[index].action == 'CHECK_IN'
                          ? 'Clock-In'
                          : 'Clock-Out';
                      Color color =
                          state.historyList[index].action == 'CHECK_IN'
                              ? DistroColors.primary_400
                              : DistroColors.primary_500;
                      return historyItemList(
                          asset: asset,
                          title: title,
                          date: date,
                          time: time,
                          color: color,
                          status: state.historyList[index].status.toString());
                    },
                    separatorBuilder: (_, __) => VerticalSeparator(height: 2),
                  );
                },
              )
            ],
          )),
    );
  }

  GridView menuSection() {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(top: 8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: SizeConfig.safeBlockHorizontal * 2,
          mainAxisSpacing: SizeConfig.safeBlockVertical * 2,
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
          Image.asset(menus[index].assets, height: 28, fit: BoxFit.fitHeight),
          VerticalSeparator(height: .5),
          Text(
            menus[index].label,
            style: DistroTypography.captionLargeSemiBold
                .copyWith(color: DistroColors.tertiary_600),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  SizedBox clockWidget(
      {required String assets, String? time, required String label}) {
    return SizedBox(
      width: 100,
      child: Column(
        children: [
          SvgPicture.asset(assets, width: 26, fit: BoxFit.fitWidth),
          VerticalSeparator(height: 1),
          Text(time != null ? time : '--:--',
              style: DistroTypography.bodyLargeSemiBold
                  .copyWith(color: DistroColors.tertiary_50)),
          VerticalSeparator(height: .25),
          Text(label,
              style: DistroTypography.captionLargeRegular
                  .copyWith(color: DistroColors.tertiary_50))
        ],
      ),
    );
  }

  SafeArea homepageAppBar() {
    return SafeArea(
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Container(
            height: 80,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              color: DistroColors.primary_700,
            ),
            child: Stack(
              children: [
                // homepageVector(),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Center(
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
                        HorizontalSeparator(width: 3),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              state.name,
                              style: DistroTypography.bodyLargeSemiBold
                                  .copyWith(color: DistroColors.tertiary_50),
                            ),
                            Text(
                              state.role,
                              style: DistroTypography.bodySmallRegular
                                  .copyWith(color: DistroColors.tertiary_100),
                            )
                          ],
                        ),
                        Spacer(),
                        Icon(
                          Icons.notifications_outlined,
                          color: DistroColors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  SvgPicture homepageVector() {
    return SvgPicture.asset(
      'assets/illustration/homepage_vector.svg',
      width: SizeConfig.safeBlockHorizontal * 30,
      fit: BoxFit.fitWidth,
      alignment: Alignment.topLeft,
    );
  }

  Widget historyItemList(
      {required String asset,
      required String title,
      required String date,
      required String time,
      required Color color,
      required String status}) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: DistroColors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: SvgPicture.asset(asset),
          ),
          HorizontalSeparator(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: DistroTypography.bodyLargeSemiBold
                      .copyWith(color: DistroColors.tertiary_600)),
              VerticalSeparator(height: .5),
              Text(date,
                  style: DistroTypography.bodySmallRegular
                      .copyWith(color: DistroColors.tertiary_400))
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(time,
                  style: DistroTypography.bodyLargeSemiBold
                      .copyWith(color: DistroColors.tertiary_600)),
              VerticalSeparator(height: .5),
              Text(status,
                  style: DistroTypography.bodySmallRegular
                      .copyWith(color: DistroColors.tertiary_400))
            ],
          )
        ],
      ),
    );
  }
}
