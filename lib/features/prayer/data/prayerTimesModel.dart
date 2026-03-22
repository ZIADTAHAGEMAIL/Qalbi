class Prayertimesmodel {
  final String fajr;
  final String dhohr;
  final String asr;
  final String magrib;
  final String isha;
  final String tarrkhMelady;
  final String dayName;

  final String hegry;
  final String hegryMonthName;
  final String hegryDayNumber;
  Prayertimesmodel({
    required this.fajr,
    required this.dhohr,
    required this.asr,
    required this.magrib,
    required this.isha,
    required this.tarrkhMelady,

    required this.dayName,
    required this.hegry,
    required this.hegryMonthName,
    required this.hegryDayNumber,
  });
  factory Prayertimesmodel.fromJson(Map<String, dynamic> json) {
    // final timing = json['timings'];
    // final date = json['date'];
    // return Prayertimesmodel(
    //   fajr: timing['Fajr'],
    //   dhohr: timing['Dhuhr'],
    //   asr: timing['Asr'],
    //   magrib: timing['Maghrib'],
    //   isha: timing['Isha'],
    //
    //   tarrkhMelady: date['readable'] ?? '',
    //   dayName: date['hijri']['weekday']['ar'] ?? '',
    //
    //   hegry: date['hijri']['date'],
    //
    //   hegryMonthName: date['hijri']['month']['ar'] ?? "Nullll",
    //   hegryDayNumber: date['hijri']['month']['number'].toString(),
    // );



    if (json.containsKey('timings')) {
      final timing = json['timings'];
      final date = json['date'];
      return Prayertimesmodel(
        fajr: timing['Fajr'] ?? '',
        dhohr: timing['Dhuhr'] ?? '',
        asr: timing['Asr'] ?? '',
        magrib: timing['Maghrib'] ?? '',
        isha: timing['Isha'] ?? '',
        tarrkhMelady: date['readable'] ?? '',
        dayName: date['hijri']['weekday']['ar'] ?? '',
        hegry: date['hijri']['date'] ?? '',
        hegryMonthName: date['hijri']['month']['ar'] ?? '',
        hegryDayNumber: date['hijri']['month']['number'].toString(),
      );
    } else {
      // 2. دي اللي بتشغل الداتا لما نرجعها من الـ Cache (الـ SharedPreferences)
      return Prayertimesmodel(
        fajr: json['fajr'] ?? '',
        dhohr: json['dhohr'] ?? '',
        asr: json['asr'] ?? '',
        magrib: json['magrib'] ?? '',
        isha: json['isha'] ?? '',
        tarrkhMelady: json['tarrkhMelady'] ?? '',
        dayName: json['dayName'] ?? '',
        hegry: json['hegry'] ?? '',
        hegryMonthName: json['hegryMonthName'] ?? '',
        hegryDayNumber: json['hegryDayNumber'] ?? '',
      );
    }
  }





  Map<String, dynamic> toJson() {
    return {
      'fajr': fajr,
      'dhohr': dhohr,
      'asr': asr,
      'magrib': magrib,
      'isha': isha,
      'tarrkhMelady': tarrkhMelady,
      'dayName': dayName,
      'hegry': hegry,
      'hegryMonthName': hegryMonthName,
      'hegryDayNumber': hegryDayNumber,
    };
  }

}
