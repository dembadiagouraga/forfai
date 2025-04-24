part of 'map_page.dart';

mixin MapPageMixin on State<MapPage>{
  late AnimationController _animationController;
  final GeolocatorPlatform _locator = GeolocatorPlatform.instance;
  CameraPosition? _cameraPosition;
  LocationPermission? check;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  checkPermission() async {
    check = await _locator.checkPermission();
  }

  Future<void> getMyLocation() async {
    if (check == LocationPermission.denied ||
        check == LocationPermission.deniedForever) {
      check = await Geolocator.requestPermission();
      if (check != LocationPermission.denied &&
          check != LocationPermission.deniedForever) {
        Geolocator.getCurrentPosition().then((loc) {
          final latLng = LatLng(loc.latitude, loc.longitude);
          if (mounted) {
            context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
          }
        });
      }
    } else {
      if (check != LocationPermission.deniedForever) {
        Geolocator.getCurrentPosition().then((loc) {
          final latLng = LatLng(loc.latitude, loc.longitude);
          if (mounted) {
            context.read<MapBloc>().add(MapEvent.goToTappedLocation(latLng));
          }
        });
      }
    }
  }

}
