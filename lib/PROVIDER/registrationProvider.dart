import 'package:flutter/cupertino.dart';

class RegistrationProvider with ChangeNotifier {
  String status = '3';
  int typeID = 0;

  String? shopImage;
  String? imageName;
  String? shopName;
  String? shopType;
  String? phoneNumber;
  String? city;
  String? description;

  String? homeDelevery;
  String? opneTime;
  String? closeTime;

  String? leaveDays;

  String? latittude;
  String? longitude;
  String? location;

  String? serachRadius;

  changeStatus(String passedStatus) {
    status = passedStatus;
    notifyListeners();
  }

  setImage(String passImage) {
    shopImage = passImage;
    notifyListeners();
  }

  setImageName(String passImageName) {
    imageName = passImageName;
    notifyListeners();
  }

  setShopName(String passShopName) {
    shopName = passShopName;
    notifyListeners();
  }

  setShoptype(String passShopType) {
    shopType = passShopType;
    notifyListeners();
  }

  setPhoneNumber(String passPhone) {
    phoneNumber = passPhone;
    notifyListeners();
  }

  setCity(String passCity) {
    city = passCity;
    notifyListeners();
  }

  setDescription(String passDescription) {
    description = passDescription;
    notifyListeners();
  }

  setHomeDelivery(String passHomeDelevery) {
    homeDelevery = passHomeDelevery;
    notifyListeners();
  }

  setOpenTime(String passOpenTime) {
    opneTime = passOpenTime;
    notifyListeners();
  }

  setCloseTime(String passCloseTime) {
    closeTime = passCloseTime;
    notifyListeners();
  }

  setLeaveDays(String passLeveDay) {
    leaveDays = passLeveDay;
    notifyListeners();
  }

  setLat(String passLat) {
    latittude = passLat;
    notifyListeners();
  }

  setLong(String passLong) {
    longitude = passLong;
    notifyListeners();
  }

  setLocation(String passLocation) {
    location = passLocation;
    notifyListeners();
  }

  setRadius(String passRadius) {
    serachRadius = passRadius;
    notifyListeners();
  }

  setTypeID(int passTypeID) {
    typeID = passTypeID;
    notifyListeners();
  }
}
