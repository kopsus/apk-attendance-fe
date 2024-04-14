import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<InitEvent>(_init);
    on<RefreshLocation>(_refreshLocation);
    on<GetDashboardStatus>(_getDashboardStatus);
    on<GetDashboardHistory>(_getDashboardHistory);
    on<CheckNearLocation>(_checkNearLocation);
    on<SendAttendanceData>(_sendAttendanceData);
    on<GetUserDetail>(_getUserDetail);
  }

  void _init(InitEvent event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      Position position = await _determinePositionV2();
      final address = await getAndSetLocation(position);

      emit(state.copyWith(
          status: DashboardStatus.initSuccess,
          location: address,
          position: position,
          accuracy: position.accuracy,
          isNearLocation: null));
    } on LocationServiceDisabledException catch (e) {
      emit(state.copyWith(
          status: DashboardStatus.locationDisable, isNearLocation: null));
    } catch (e) {
      emit(state.copyWith(
          status: DashboardStatus.locationDisable, isNearLocation: null));
    }
  }

  void _refreshLocation(
      RefreshLocation event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      Position position = await _determinePositionV2();

      emit(state.copyWith(
          status: DashboardStatus.success,
          position: position,
          accuracy: position.accuracy));
    } on LocationServiceDisabledException catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.locationDisable,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.locationDisable,
      ));
    }
  }

  void _checkNearLocation(
      CheckNearLocation event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      bool isNearLocation = checkNearLocation(
          event.currentPosition, event.companyLat, event.companyLong);

      emit(state.copyWith(
          status: DashboardStatus.success, isNearLocation: isNearLocation));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failed,
      ));
    }
  }

  void _getDashboardStatus(
      GetDashboardStatus event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      final result = await DashboardDatasource.getDashboardStatus();

      if (result.data.action == 'clock-in') {
        emit(state.copyWith(
            status: DashboardStatus.success,
            isClockIn: false,
            companyAddress: result.data.companyAddress,
            companyLat: result.data.companyLatitude,
            companyLong: result.data.companyLongitude));
      } else {
        String clockIn = DateFormat('HH:mm').format(
            DateTime.fromMillisecondsSinceEpoch(result.data.clockIn!)
                .toLocal());
        emit(state.copyWith(
            status: DashboardStatus.success,
            isClockIn: true,
            clockInTime: clockIn,
            companyAddress: result.data.companyAddress,
            companyLat: result.data.companyLatitude,
            companyLong: result.data.companyLongitude));
      }
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failed,
      ));
    }
  }

  void _getDashboardHistory(
      GetDashboardHistory event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      final result = await DashboardDatasource.getDashboardHistory();

      emit(state.copyWith(
          status: DashboardStatus.success, historyList: result.data));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failed,
      ));
    }
  }

  void _sendAttendanceData(
      SendAttendanceData event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      await DashboardDatasource.postAttendance(event.image);

      emit(state.copyWith(status: DashboardStatus.postSuccess));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failed,
      ));
    }
  }

  void _getUserDetail(GetUserDetail event, Emitter<DashboardState> emit) async {
    try {
      emit(state.copyWith(status: DashboardStatus.loading));
      final name = await AuthDatasource.getName();
      final role = await AuthDatasource.getRole();

      emit(state.copyWith(
          status: DashboardStatus.success, name: name, role: role));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.failed,
      ));
    }
  }

  Future<Position> _determinePositionV2() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw LocationServiceDisabledException();
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw LocationServiceDisabledException();
      }
    }

    _locationData = await location.getLocation();

    return Position(
        longitude: _locationData.longitude ?? 0.0,
        latitude: _locationData.latitude ?? 0.0,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
            _locationData.time?.toInt() ?? 0),
        accuracy: _locationData.accuracy ?? 0,
        altitude: _locationData.altitude ?? 0,
        heading: _locationData.heading ?? 0,
        speed: _locationData.speed ?? 0,
        speedAccuracy: _locationData.accuracy ?? 0,
        altitudeAccuracy: _locationData.verticalAccuracy ?? 0,
        headingAccuracy: _locationData.headingAccuracy ?? 0);
  }

  Future<String> getAndSetLocation(Position position) async {
    try {
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(position.latitude, position.longitude);

      // This will give you the first placemark, which should be the most accurate.
      geocoding.Placemark placemark = placemarks[0];

      // You can use the placemark to get the address, city, country, etc.
      String? address = placemark.street;
      String? city = placemark.locality;
      String? country = placemark.country;
      return "$address, $city, $country";
    } catch (e) {
      rethrow;
    }
  }

  bool checkNearLocation(
      Position currentPosition, double companyLat, double companyLong) {
    var isNearLocation = false;
    var threshold = 50;

    if (Platform.isAndroid) {
      bool isMockLocation = currentPosition.isMocked;

      if (isMockLocation) {
        return isNearLocation;
      } else {
        final distance = Geolocator.distanceBetween(currentPosition.latitude,
            currentPosition.longitude, companyLat, companyLong);

        if (distance < threshold) {
          isNearLocation = true;
        }
        return isNearLocation;
      }
    } else {
      final distance = Geolocator.distanceBetween(currentPosition.latitude,
          currentPosition.longitude, companyLat, companyLong);

      if (distance < threshold) {
        isNearLocation = true;
      }
      return isNearLocation;
    }
  }
}
