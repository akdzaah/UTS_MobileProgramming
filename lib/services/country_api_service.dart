
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/country.dart';

class CountryApiService {
  static const String _baseUrl = 'https://countries.dev';

  Future<List<Country>> getCountries() async {
    final uri = Uri.parse(
      '$_baseUrl/countries?fields=name,capital,region,flag,alpha2Code,cca2,population,area,currencies,languages',
    );


    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil daftar negara.');
    }

    final data = jsonDecode(response.body);

    if (data is! List) {
      throw Exception('Format daftar negara tidak sesuai.');
    }

    return data
        .whereType<Map<String, dynamic>>()
        .map((json) => Country.fromJson(json))
        .toList();
  }

  Future<Country> getCountryDetail(String code) async {
    if (code.isEmpty) {
      throw Exception('Kode negara tidak tersedia.');
    }

    final uri = Uri.parse(
      '$_baseUrl/alpha/${Uri.encodeComponent(code)}',
    );

    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('Gagal mengambil detail negara.');
    }

    final data = jsonDecode(response.body);

    if (data is! Map<String, dynamic>) {
      throw Exception('Format detail negara tidak sesuai.');
    }

    return Country.fromJson(data);
  }
}
