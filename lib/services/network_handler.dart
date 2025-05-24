import 'package:http/http.dart' as http;
import 'dart:convert';


   Future<String> fetchTafsir(int surah, int ayah) async {
      final url = Uri.parse('https://api.alquran.cloud/v1/ayah/$surah:$ayah/ar.ibn-kathir');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("${response.statusCode}");
        print("///////////////////////");
        print("${data}");

        return data['data']['text']; // نص التفسير
      } else {
        print("${response.statusCode}");
        print("///////////////////////");
        throw Exception('فشل في جلب التفسير // افحص الاتصال');
      }
    }
