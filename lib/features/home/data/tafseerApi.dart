
import '../../../core/network/Api_Services.dart';
class TafseerRepo {
  apiService _apiservice = apiService();

  Future<String> getTafsirFromApi(int surahNumber, int verseNumber) async {
    try {
      final dynamic responseData = await _apiservice.get(
        'https://api.alquran.cloud/v1/ayah/$surahNumber:$verseNumber/ar.muyassar',
      );


      if (responseData != null && responseData['code'] == 200) {
        return responseData['data']['text'];
      } else {
        return "عذراً، لم نتمكن من جلب التفسير حالياً.";
      }
    } catch (e) {
      print("Tafseer Error: $e");
      return "تأكد من اتصالك بالإنترنت لقراءة التفسير.";
    }
  }
}
