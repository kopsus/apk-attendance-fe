import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class MapPage extends StatefulWidget {
  final GeoPoint location;
  const MapPage({super.key, required this.location});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  MapController controller = MapController(
    areaLimit: BoundingBox.world(),
    initPosition: GeoPoint(latitude: 6.175895, longitude: 106.827125));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            OSMFlutter(
                controller: controller,
                osmOption: OSMOption(
                  enableRotationByGesture: false,
                  showContributorBadgeForOSM: false,
                  showDefaultInfoWindow: false,
                  showZoomController: true,
                  
                )
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Container(
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: DistroColors.tertiary_50,
                      boxShadow: [
                        DistroShadows.shadow_200,
                        DistroShadows.shadow_300
                      ],
                      border: Border.all(color: DistroColors.black.withOpacity(.1))
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Confirm Address', style: DistroTypography.bodySmallSemiBold.copyWith(
                              color: DistroColors.tertiary_300
                            ),),
                            Text('Acurate To 1.5 km', style: DistroTypography.bodySmallSemiBold.copyWith(
                              color: DistroColors.tertiary_300
                            ))
                          ],
                        ),
                        VerticalSeparator(height: 2),
                        Text('Jl. Simpang Lima, Mugassari, Kec. Semarang Sel., Kota Semarang, Jawa Tengah 50249', style: 
                          DistroTypography.bodyLargeRegular.copyWith(color: DistroColors.tertiary_600),),
                        VerticalSeparator(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            DistroOutlineButton(
                              width: SizeConfig.safeBlockHorizontal*35,
                              label: Text('Refresh'), 
                              onPressed: (){}),
                            DistroElevatedButton(
                              width: SizeConfig.safeBlockHorizontal*35,
                              label: Text('Confirm'), 
                              onPressed: (){})
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
              top: 16,
              left: 24,
              child: InkWell(
                onTap: ()=> Navigator.pop(context),
                child: Container(
                  width: 32,
                  height: 32,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: DistroColors.tertiary_400.withOpacity(.6)
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: DistroColors.black,
                      size: 15)
                  )
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}