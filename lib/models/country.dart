
class Country {
  final String name;
  final String flag;
  final String capital;
  final String region;
  final String code;
  final int population;
  final double area;
  final List<String> currencies;
  final List<String> languages;

  const Country({
    required this.name,
    required this.flag,
    required this.capital,
    required this.region,
    required this.code,
    required this.population,
    required this.area,
    required this.currencies,
    required this.languages,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final nameData = json['name'];
    final capitalData = json['capital'];
    final currencyData = json['currencies'];
    final languageData = json['languages'];

    final currencies = <String>[];
    if (currencyData is List) {
      for (final item in currencyData) {
        if (item is Map && item['name'] != null) {
          final code = item['code'];
          final symbol = item['symbol'];
          String value = item['name'].toString();

          if (code != null && code.toString().isNotEmpty) {
            value += ' ($code)';
          }
          if (symbol != null && symbol.toString().isNotEmpty) {
            value += ' - $symbol';
          }
          currencies.add(value);
        }
      }
    }

    final languages = <String>[];
    if (languageData is List) {
      for (final item in languageData) {
        if (item is Map && item['name'] != null) {
          languages.add(item['name'].toString());
        }
      }
    }

    final populationValue = json['population'];
    final areaValue = json['area'];

    return Country(
      name: nameData is Map
          ? (nameData['common'] ?? nameData['name'] ?? 'Tidak diketahui')
          .toString()
          : (nameData?.toString() ?? 'Tidak diketahui'),
      flag: (json['flag'] ?? '🌐').toString(),
      capital: capitalData is List && capitalData.isNotEmpty
          ? capitalData.first.toString()
          : capitalData?.toString() ?? 'Tidak diketahui',
      region: (json['region'] ?? 'Tidak diketahui').toString(),
      code: (json['cca2'] ??
          json['alpha2Code'] ??
          json['code'] ??
          '')
          .toString(),
      population: populationValue is num
          ? populationValue.toInt()
          : int.tryParse('$populationValue') ?? 0,
      area: areaValue is num
          ? areaValue.toDouble()
          : double.tryParse('$areaValue') ?? 0,
      currencies: currencies,
      languages: languages,
    );
  }
}
