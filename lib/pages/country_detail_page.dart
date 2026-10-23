
import 'package:flutter/material.dart';

import '../models/country.dart';
import '../services/country_api_service.dart';

class CountryDetailPage extends StatefulWidget {
  final Country country;

  const CountryDetailPage({
    super.key,
    required this.country,
  });

  @override
  State<CountryDetailPage> createState() => _CountryDetailPageState();
}

class _CountryDetailPageState extends State<CountryDetailPage> {
  final CountryApiService _apiService = CountryApiService();

  late Future<Country> _detailFuture;

  static const Color navyBlue = Color(0xFF163A70);
  static const Color primaryBlue = Color(0xFF3478F6);
  static const Color backgroundColor = Color(0xFFF2F7FF);
  static const Color textColor = Color(0xFF263445);
  static const Color secondaryText = Color(0xFF7A8799);

  @override
  void initState() {
    super.initState();
    _detailFuture = _loadDetail();
  }

  Future<Country> _loadDetail() {
    if (widget.country.code.isEmpty) {
      return Future.value(widget.country);
    }

    return _apiService.getCountryDetail(widget.country.code);
  }

  String _formatNumber(num number) {
    final text = number.round().toString();

    return text.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
          (match) => '.',
    );
  }

  Widget _sectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: primaryBlue.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              icon,
              color: primaryBlue,
              size: 22,
            ),
          ),
          const SizedBox(width: 11),
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: navyBlue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String title,
    required String value,
    required Color iconColor,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 1,
      shadowColor: navyBlue.withValues(alpha: 0.06),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(
          color: Color(0xFFE5EDF8),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 25,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      color: secondaryText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    value,
                    style: const TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text('Detail Negara'),
      ),
      body: FutureBuilder<Country>(
        future: _detailFuture,
        builder: (context, snapshot) {
          final country = snapshot.data ?? widget.country;

          final currencies = country.currencies.isEmpty
              ? 'Informasi tidak tersedia'
              : country.currencies.join(', ');

          final languages = country.languages.isEmpty
              ? 'Informasi tidak tersedia'
              : country.languages.join(', ');

          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 18, 16, 28),
            children: [
              // Header negara
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 28,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [navyBlue, primaryBlue],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: navyBlue.withValues(alpha: 0.16),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      right: -15,
                      top: -18,
                      child: Icon(
                        Icons.public_rounded,
                        size: 110,
                        color: Colors.white.withValues(alpha: 0.07),
                      ),
                    ),
                    Column(
                      children: [
                        Container(
                          width: 112,
                          height: 96,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.14),
                            borderRadius: BorderRadius.circular(22),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.20),
                            ),
                          ),
                          child: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 62),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          country.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          country.region.isEmpty
                              ? 'Informasi negara'
                              : country.region,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFFDCE8FF),
                            fontSize: 15,
                          ),
                        ),
                        if (country.code.isNotEmpty) ...[
                          const SizedBox(height: 14),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Text(
                              'Kode negara: ${country.code.toUpperCase()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 26),

              _sectionTitle(
                'Informasi Umum',
                Icons.info_outline_rounded,
              ),

              if (snapshot.connectionState == ConnectionState.waiting)
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: LinearProgressIndicator(
                    color: primaryBlue,
                    minHeight: 3,
                  ),
                ),

              if (snapshot.hasError)
                Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFF4E5),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    'Detail belum berhasil dimuat. Data yang tersedia '
                        'tetap ditampilkan. Periksa koneksi internet '
                        'dan coba muat ulang.',
                    style: TextStyle(
                      color: Color(0xFF8A4B08),
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ),

              _infoCard(
                icon: Icons.location_city_rounded,
                title: 'Ibu Kota',
                value: country.capital.isEmpty
                    ? 'Informasi tidak tersedia'
                    : country.capital,
                iconColor: primaryBlue,
              ),

              _infoCard(
                icon: Icons.public_rounded,
                title: 'Wilayah',
                value: country.region.isEmpty
                    ? 'Informasi tidak tersedia'
                    : country.region,
                iconColor: const Color(0xFF168A78),
              ),

              _infoCard(
                icon: Icons.people_alt_rounded,
                title: 'Populasi',
                value: country.population > 0
                    ? '${_formatNumber(country.population)} jiwa'
                    : 'Informasi tidak tersedia',
                iconColor: const Color(0xFF8B5CF6),
              ),

              _infoCard(
                icon: Icons.map_rounded,
                title: 'Luas Wilayah',
                value: country.area > 0
                    ? '${_formatNumber(country.area)} km²'
                    : 'Informasi tidak tersedia',
                iconColor: const Color(0xFFE69526),
              ),

              const SizedBox(height: 12),

              _sectionTitle(
                'Informasi Tambahan',
                Icons.auto_awesome_rounded,
              ),

              _infoCard(
                icon: Icons.payments_rounded,
                title: 'Mata Uang',
                value: currencies,
                iconColor: const Color(0xFF168A78),
              ),

              _infoCard(
                icon: Icons.translate_rounded,
                title: 'Bahasa',
                value: languages,
                iconColor: primaryBlue,
              ),

              if (snapshot.hasError) ...[
                const SizedBox(height: 6),
                SizedBox(
                  height: 50,
                  child: FilledButton.icon(
                    onPressed: () {
                      setState(() {
                        _detailFuture = _loadDetail();
                      });
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Muat Ulang Informasi'),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
