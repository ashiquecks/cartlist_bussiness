import 'package:cartlistmurchant/PROVIDER/registrationProvider.dart';
import 'package:cartlistmurchant/WIDGETS/cartlistCard.dart';
import 'package:cartlistmurchant/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class WorkingStatus extends StatefulWidget {
  const WorkingStatus({super.key});

  @override
  State<WorkingStatus> createState() => _WorkingStatusState();
}

class _WorkingStatusState extends State<WorkingStatus> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TimeOfDay? openTime;
  TimeOfDay? closeTime;
  TimeOfDay? openTimePick;
  TimeOfDay? closeTimePick;

  bool checkedValue = false;

  String? _currentAddress;
  Position? _currentPosition;

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(
        _currentPosition!,
      );
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    final registerProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) async {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';

        registerProvider.setLocation(_currentAddress ?? "");
        registerProvider.setLat(_currentPosition!.latitude.toString());
        registerProvider.setLong(_currentPosition!.longitude.toString());
        registerProvider.setRadius(_currentPosition!.latitude.toString());

        Future.delayed(const Duration(seconds: 2), () {
          print(registerProvider.imageName);
          print(registerProvider.shopImage);
          print(registerProvider.shopName);
          print(registerProvider.shopType);
          print(registerProvider.phoneNumber);
          print(registerProvider.city);
          print(registerProvider.description);
          print(registerProvider.homeDelevery);
          print(registerProvider.opneTime);
          print(registerProvider.closeTime);
          print(registerProvider.leaveDays);
          print(registerProvider.latittude);
          print(registerProvider.longitude);
          print(registerProvider.location);
          print(registerProvider.serachRadius![0]);
          print(registerProvider.serachRadius![1]);
        });
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    final widgetSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: colorWhite,
      appBar: AppBar(
        elevation: 0,
        leading: const SizedBox(),
        leadingWidth: 0,
        backgroundColor: colorWhite,
        title: const Text(
          "Working status",
          style: TextStyle(color: colorPrimary, fontSize: 16),
        ),
        actions: [
          Row(
            children: [
              borderCube(),
              colorCube(),
              borderCube(),
            ],
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: CheckboxListTile(
                    title: const Text("Home Delevery Provided"),
                    value: checkedValue,
                    onChanged: ((value) {
                      setState(() {
                        checkedValue = value!;
                        if (checkedValue == true) {
                          registerProvider
                              .setHomeDelivery("Home delivery Available");
                        } else {
                          registerProvider.setHomeDelivery(
                              "Not provide home delevery fecility");
                        }
                      });
                    }),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Card(
                      elevation: 4,
                      child: SizedBox(
                        width: widgetSize.width / 2.3,
                        child: TextButton(
                          onPressed: () async {
                            TimeOfDay initialTime = TimeOfDay.now();
                            openTimePick = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                            );
                            setState(() {
                              openTime = openTimePick;
                              registerProvider
                                  .setOpenTime(openTime!.format(context));
                            });
                          },
                          child: Text(openTime == null
                              ? "Open Time"
                              : openTime!.format(context)),
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4,
                      child: SizedBox(
                        width: widgetSize.width / 2.3,
                        child: TextButton(
                          onPressed: () async {
                            TimeOfDay initialTime = TimeOfDay.now();
                            closeTimePick = await showTimePicker(
                              context: context,
                              initialTime: initialTime,
                            );
                            setState(() {
                              closeTime = closeTimePick;
                              registerProvider
                                  .setCloseTime(closeTime!.format(context));
                            });
                          },
                          child: Text(closeTime == null
                              ? "Close Time"
                              : closeTime!.format(context)),
                        ),
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 8, top: 15, bottom: 10),
                  child: Text(
                    "Mark leave days",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: colorRed,
                        fontSize: 16),
                  ),
                ),
                const WorkDayCard(dayName: 'Monday,'),
                const WorkDayCard(dayName: 'Tuesday,'),
                const WorkDayCard(dayName: 'Wednesday,'),
                const WorkDayCard(dayName: 'Thursday,'),
                const WorkDayCard(dayName: 'Friday,'),
                const WorkDayCard(dayName: 'Saturday,'),
                const WorkDayCard(dayName: 'Sunday,'),
                const SizedBox(height: 20),
                SizedBox(
                  width: widgetSize.width,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      Navigator.pushNamed(context, '/userRegistration');
                    },
                    child: const Text('Next'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class WorkDayCard extends StatefulWidget {
  final String dayName;
  const WorkDayCard({super.key, required this.dayName});

  @override
  State<WorkDayCard> createState() => _WorkDayCardState();
}

class _WorkDayCardState extends State<WorkDayCard> {
  bool checkedValue = false;
  @override
  Widget build(BuildContext context) {
    final registerProvider =
        Provider.of<RegistrationProvider>(context, listen: false);
    return ListTile(
      title: Text(widget.dayName),
      trailing: Checkbox(
        value: checkedValue,
        onChanged: (newValue) {
          setState(() {
            checkedValue = newValue!;
            if (registerProvider.leaveDays == null) {
              registerProvider.setLeaveDays(widget.dayName);
            } else {
              registerProvider
                  .setLeaveDays(registerProvider.leaveDays! + widget.dayName);
            }
          });
        }, //  <-- leading Checkbox
      ),
    );
  }
}
