import 'package:islamicapp/core/network/Api_Services.dart';

import 'prayerTimesModel.dart';

class Prayertimesrepo {
  apiService _apiservice = apiService();

  Future<List<Prayertimesmodel>> getprayerTimes(
    double  latitude,
      double longitude,
      double method,
      int latitudeAdjustmentMethod,

  ) async {
    List<Prayertimesmodel> days = [];

    final Response = await _apiservice.get(
      '/2026',
      params: {
        'latitude': latitude,
        'longitude': longitude,
        'method': method,
        'shafaq': 'general',
        "tune":"0%2C0%2C05%2C0%2C0%2C0%2C0%2C0%2C-0",

        "latitudeAdjustmentMethod":latitudeAdjustmentMethod

        //curl -X GET "https://api.aladhan.com/v1/calendar/2026?latitude=51.5194682&longitude=-0.1360365&method=5&shafaq=general&tune=5%2C3%2C5%2C7%2C9%2C-1%2C0%2C8%2C-6" \
      },
    );
    Map<String, dynamic> data = Response['data'];

    data.forEach((month, daysLsist) {
      for (var day in daysLsist) {
        days.add(Prayertimesmodel.fromJson(day));
      }
    });


    return days;
  }
}
