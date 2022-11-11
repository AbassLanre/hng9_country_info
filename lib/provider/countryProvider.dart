

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:hng9_country_info/constants/consts.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/network/network_enum.dart';
import 'package:hng9_country_info/network/network_helper.dart';
import 'package:hng9_country_info/network/network_service.dart';
import 'package:provider/provider.dart';

class CountryProvider extends ChangeNotifier{

  Future<List<Country>?>? _getCountryData;

  Future<List<Country>?>? get getCountryData => _getCountryData;

  setCountryData(Future<List<Country>?>? countryData){
    _getCountryData =countryData;
    notifyListeners();
  }


}