import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:myapp/features/dashboard/bloc/dashboard_bloc.dart';
import 'package:myapp/features/dashboard/views/dashboard_page.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller = MapController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state.status == DashboardStatus.success) {
            setState(() {
              controller.move(
                  LatLng(state.position!.latitude, state.position!.longitude),
                  15);
            });
          }
          if (state.status == DashboardStatus.postSuccess) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const DashboardPage()),
                (route) => false);
          }
          if (state.status == DashboardStatus.failed) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: DistroColors.warning_500,
                content: Text(
                  'Gagal mengirim ke server, cek koneksi anda atau tunggu beberapa saat lagi',
                  style: TextStyle(color: Colors.white),
                )));
          }
        },
        builder: (context, state) {
          return SafeArea(
            child: Stack(
              children: [
                FlutterMap(
                  mapController: controller,
                  options: MapOptions(
                      initialCenter:
                          LatLng(state.companyLat, state.companyLong),
                      initialZoom: 15,
                      interactionOptions: const InteractionOptions(
                          flags: ~InteractiveFlag.doubleTapZoom)),
                  children: [
                    osmTileLayer,
                    MarkerLayer(markers: [
                      Marker(
                          point: LatLng(state.companyLat, state.companyLong),
                          child: const Icon(
                            size: 40,
                            Icons.location_on,
                            color: Colors.red,
                          )),
                      Marker(
                          width: 24,
                          height: 24,
                          point: LatLng(state.position!.latitude,
                              state.position!.longitude),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                                color: DistroColors.white,
                                shape: BoxShape.circle),
                            child: Container(
                              width: 20,
                              height: 20,
                              decoration: const BoxDecoration(
                                  color: DistroColors.warning_500,
                                  shape: BoxShape.circle),
                            ),
                          ))
                    ])
                  ],
                ),
                confirmAddress,
                Positioned(
                    top: 16,
                    left: 24,
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                            width: 32,
                            height: 32,
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color:
                                    DistroColors.tertiary_400.withOpacity(.6)),
                            child: const Center(
                                child: Icon(Icons.arrow_back_ios_new,
                                    color: DistroColors.black, size: 15))))),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget get confirmAddress => BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: DistroColors.tertiary_50,
                    boxShadow: [
                      DistroShadows.shadow_200,
                      DistroShadows.shadow_300
                    ],
                    border:
                        Border.all(color: DistroColors.black.withOpacity(.1))),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Confirm Address',
                          style: DistroTypography.bodySmallSemiBold
                              .copyWith(color: DistroColors.tertiary_300),
                        ),
                        Text(
                            'Acurate To ${state.accuracy.toStringAsFixed(1)} m',
                            style: DistroTypography.bodySmallSemiBold
                                .copyWith(color: DistroColors.tertiary_300))
                      ],
                    ),
                    const VerticalSeparator(height: 2),
                    Text(
                      state.companyAddress,
                      style: DistroTypography.bodyLargeRegular
                          .copyWith(color: DistroColors.tertiary_600),
                    ),
                    const VerticalSeparator(height: 2),
                    BlocBuilder<DashboardBloc, DashboardState>(
                      builder: (context, state) {
                        if (state.status == DashboardStatus.loading) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: DistroColors.primary_500,
                            ),
                          );
                        }
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DistroOutlineButton(
                                width: SizeConfig.safeBlockHorizontal * 35,
                                label: const Text('Refresh'),
                                onPressed: () {
                                  context
                                      .read<DashboardBloc>()
                                      .add(RefreshLocation());
                                }),
                            DistroElevatedButton(
                                width: SizeConfig.safeBlockHorizontal * 35,
                                label: const Text('Confirm'),
                                onPressed: () async {
                                  var image = await ImagePicker().pickImage(
                                      preferredCameraDevice: CameraDevice.front,
                                      source: ImageSource.camera,
                                      imageQuality: 25,
                                      requestFullMetadata: false);
                                  if (image != null) {
                                    context
                                        .read<DashboardBloc>()
                                        .add(SendAttendanceData(image: image));
                                  }
                                })
                          ],
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          );
        },
      );

  TileLayer get osmTileLayer => TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.shika.distro_app',
      );
}
