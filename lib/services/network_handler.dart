import 'package:http/http.dart' as http;
import 'dart:convert';


   Future<String> fetchTafsir(int surah, int ayah) async {
      final url = Uri.parse('https://api.alquran.cloud/v1/ayah/$surah:$ayah/ar.jalalayn');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['data']['text']; // نص التفسير
      } else {
        throw Exception('فشل في جلب التفسير // افحص الاتصال');
      }
    }