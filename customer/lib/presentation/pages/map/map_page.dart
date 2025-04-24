import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quick/presentation/components/components.dart';
import 'package:remixicon/remixicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:quick/app_constants.dart';
import 'package:quick/application/map/map_bloc.dart';
import 'package:quick/domain/model/model/location_model.dart';
import 'package:quick/presentation/style/style.dart';
import 'package:lottie/lottie.dart' as lottie;
import 'package:quick/infrastructure/service/services.dart';

import 'widgets/main_list_shimmer.dart';
import 'widgets/my_location_button.dart';
import 'widgets/searched_location_item.dart';

part 'map_page_mixin.dart';

class MapPage extends StatefulWidget {
  final LocationModel? location;

  const MapPage({super.key, this.location});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>
    with MapPageMixin, TickerProviderStateMixin {
  @override
  void initState() {
    _animationController = AnimationController(vsync: this);
    checkPermission();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: (colors) => BlocBuilder<MapBloc, MapState>(
              builder: (context, state) {
                final event = context.read<MapBloc>();
                return Stack(
                  children: [
                    GoogleMap(
                      tiltGesturesEnabled: false,
                      myLocationButtonEnabled: false,
                      onTap: (location) {
                        event.add(MapEvent.goToMyLocation(location: location));
                      },
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                        bearing: 0,
                        target: AppHelpers.getLocation(widget.location),
                        tilt: 0,
                        zoom: 17,
                      ),
                      onMapCreated: (controller) {
                        event.add(MapEvent.setMapController(controller));
                      },
                      onCameraMoveStarted: () {
                        _animationController.repeat(
                          min: AppConstants.pinLoadingMin,
                          max: AppConstants.pinLoadingMax,
                          period: _animationController.duration! *
                              (AppConstants.pinLoadingMax -
                                  AppConstants.pinLoadingMin),
                        );
                        event.add(const MapEvent.setChoosing(true));
                      },
                      onCameraIdle: () {
                        event.add(MapEvent.fetchLocationName(
                          _cameraPosition?.target ??
                              AppHelpers.getLocation(widget.location),
                        ));

                        _animationController.forward(
                          from: AppConstants.pinLoadingMax,
                        );

                        event.add(const MapEvent.setChoosing(false));
                      },
                      onCameraMove: (cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                    ),
                    IgnorePointer(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 78.0,
                          ),
                          child: lottie.Lottie.asset(
                            "assets/lottie/pin.json",
                            onLoaded: (composition) {
                              _animationController.duration =
                                  composition.duration;
                            },
                            controller: _animationController,
                            width: 250,
                            height: 250,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        53.verticalSpace,
                        Row(
                          children: [
                            16.horizontalSpace,
                            MyLocationButton(
                              iconData: Remix.arrow_left_s_line,
                              width: 50,
                              onTap: () {
                                if (_animationController.isCompleted) {
                                  Navigator.pop(context);
                                }
                              },
                              colors: colors,
                            ),
                            6.horizontalSpace,
                            Expanded(
                              child: Container(
                                height: 50.r,
                                padding: REdgeInsets.symmetric(horizontal: 15),
                                decoration: BoxDecoration(
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: colors.icon,
                                      offset: const Offset(0, 2),
                                      blurRadius: 2,
                                      spreadRadius: 0,
                                    ),
                                  ],
                                  color: colors.backgroundColor,
                                  borderRadius: BorderRadius.circular(25.r),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      Remix.search_line,
                                      size: 20.r,
                                      color: colors.textBlack,
                                    ),
                                    12.horizontalSpace,
                                    Expanded(
                                      child: TextFormField(
                                        controller: state.textController,
                                        style: CustomStyle.interNormal(
                                            color: colors.textBlack, size: 16),
                                        onChanged: (value) => event
                                            .add(MapEvent.setQuery(context)),
                                        cursorWidth: 1.r,
                                        cursorColor: colors.textBlack,
                                        decoration: InputDecoration.collapsed(
                                          hintText: AppHelpers.getTranslation(
                                              TrKeys.searchLocation),
                                          hintStyle: CustomStyle.interRegular(
                                              color: colors.textHint, size: 14),
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () => event.add(
                                          const MapEvent.clearSearchField()),
                                      splashRadius: 20.r,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        Remix.close_line,
                                        size: 20.r,
                                        color: colors.textBlack,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            16.horizontalSpace,
                          ],
                        ),
                        if (state.isSearching)
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.r),
                              color: colors.backgroundColor,
                            ),
                            margin: REdgeInsets.symmetric(
                                horizontal: 16, vertical: 6),
                            padding: REdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            child: state.isSearchLoading
                                ? const MainListShimmer()
                                : ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: state.searchedPlaces.length,
                                    padding: EdgeInsets.zero,
                                    itemBuilder: (context, index) {
                                      return SearchedLocationItem(
                                        place: state.searchedPlaces[index],
                                        isLast:
                                            state.searchedPlaces.length - 1 ==
                                                index,
                                        onTap: () {
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                          event.add(MapEvent.goToLocation(
                                              place:
                                                  state.searchedPlaces[index]));
                                        },
                                        colors: colors,
                                      );
                                    },
                                  ),
                          ),
                      ],
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 150),
                      bottom: state.isChoosing ? -60.r : 20.r,
                      left: 16.r,
                      right: 16.r,
                      child: CustomButton(
                        title: TrKeys.confirmLocation,
                        bgColor: CustomStyle.black,
                        titleColor: colors.white,
                        onTap: () {
                          event.add(MapEvent.saveLocalAddress(true,
                              context: context));
                          Navigator.pop(
                              context,
                              LocationModel(
                                  latitude: state.location?.latitude.toString(),
                                  longitude:
                                      state.location?.longitude.toString(),
                                  address: state.textController?.text));
                        },
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 150),
                      bottom: 89.r,
                      right: state.isChoosing ? -60.r : 15.r,
                      child: MyLocationButton(
                        iconData: Remix.navigation_fill,
                        onTap: getMyLocation,
                        colors: colors,
                      ),
                    ),
                  ],
                );
              },
            ));
  }
}
