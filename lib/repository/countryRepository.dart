

import 'package:flutter/material.dart';
import 'package:hng9_country_info/constants/consts.dart';
import 'package:hng9_country_info/model/country_model.dart';
import 'package:hng9_country_info/network/network_enum.dart';
import 'package:hng9_country_info/network/network_helper.dart';
import 'package:hng9_country_info/network/network_service.dart';

class CountryRespository{


  Future<List<Country>?> getData() async {
    final response = await NetworkService.sendRequest(
        requestType: RequestType.get,
        url: StaticValues.apiUrl,
        queryParam: null);

    debugPrint('Response ${response?.statusCode}');


    return await NetworkHelper.filterResponse(
        callBack: _listOfCountriesFromJson,
        response: response,
        parameterName: CallBackParameterName.all,
        onFailureCallBackWithMessage: (errorType, msg) {
          debugPrint('Error type-$errorType - Message $msg');
          return null;
        });

  }
  // Future<List<Country>?> fetchSearchData(String query) async {
  //
  //   return getData().then((value) => value!.map((e) => Country.fromJson(e)).where((country){
  //     final countryV = country.name!.common!.toLowerCase();
  //     final searchValue = query.toLowerCase();
  //     return countryV.contains(searchValue);
  //   }).toList());
  //
  // }
    List<Country> _listOfCountriesFromJson(json) {
    List<Country> countryList = (json as List)
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .toList();
    countryList.sort((a, b) {
      return a.name!.common!.toLowerCase().compareTo(b.name!.common!.toLowerCase());
    });
    return  countryList;
  }
}