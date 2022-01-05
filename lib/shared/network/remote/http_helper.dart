import 'dart:async';

import 'package:http/http.dart' as http;
import 'package:jo_sequal_software_pexels_app/shared/components/constants.dart';

abstract class HttpHelper {
  static Future<http.Response> getRequest(String apiUrl) async {
    final url = Uri.parse(apiUrl);
    try {
      return await http
          .get(url, headers: {'Authorization': kPexelsApiKey}).timeout(const Duration(seconds: 10));
    } on TimeoutException catch (_) {
      rethrow;
    } catch (error) {
      rethrow;
    }
  }
}
