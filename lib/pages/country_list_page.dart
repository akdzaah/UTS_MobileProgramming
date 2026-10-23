
import 'package:flutter/material.dart';

import '../models/country.dart';
import '../services/country_api_service.dart';
import 'country_detail_page.dart';

class CountryListPage extends StatefulWidget {
  const CountryListPage({super.key});

  @override
  State<CountryListPage> createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  final CountryApiService _apiService = CountryApiService();
  final TextEditingController _searchController =
  TextEditingController();

  late Future<List<Country>> _countriesFuture;
  String _searchQuery = '';

  static const Color navyBlue = Color(0xFF163A70);
  static const Color primaryBlue = Color(0xFF3478F6);
  static const Color backgroundColor = Color(0xFFF2F7FF);
  static const Color textColor = Color(0xFF263445);
  static const Color secondaryText = Color(0xFF7A8799);

  @override
  void initState() {
    super.initState();
    _countriesFuture = _apiService.getCountries();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _reloadCountries() {
    setState(() {
      _countriesFuture = _apiService.getCountries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        backgroundColor: navyBlue,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        title: const Row(
          children: [
            Icon(Icons.public, size: 27),
            SizedBox(width: 10),
            Text(
              'World Explorer',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Muat Ulang',
            icon: const Icon(
              Icons.refresh_rounded,
              size: 27,
            ),
            onPressed: _reloadCountries,
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: Column(
        children: [
          // Header biru
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 12, 22, 30),
            decoration: const BoxDecoration(
              color: navyBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Jelajahi Dunia! 🌍',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Temukan informasi menarik dari berbagai negara.',
                  style: TextStyle(
                    color: Color(0xFFDCE8FF),
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          // Kolom pencarian
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 22, 18, 14),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
                fontSize: 16,
                color: textColor,
              ),
              decoration: InputDecoration(
                hintText: 'Cari nama negara...',
                prefixIcon: const Icon(
                  Icons.search_rounded,
                  size: 25,
                  color: primaryBlue,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                  tooltip: 'Hapus pencarian',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {
                      _searchQuery = '';
                    });
                  },
                )
                    : null,
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 17,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E9F5),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: Color(0xFFE0E9F5),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: const BorderSide(
                    color: primaryBlue,
                    width: 1.5,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          // Judul daftar
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 22,
              vertical: 4,
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.explore_outlined,
                  color: primaryBlue,
                  size: 23,
                ),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text(
                    'Daftar Negara',
                    style: TextStyle(
                      color: navyBlue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (_searchQuery.isNotEmpty)
                  Text(
                    'Hasil pencarian',
                    style: TextStyle(
                      color: secondaryText,
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Data dari API
          Expanded(
            child: FutureBuilder<List<Country>>(
              future: _countriesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: primaryBlue,
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.cloud_off_rounded,
                            size: 58,
                            color: secondaryText,
                          ),
                          const SizedBox(height: 14),
                          const Text(
                            'Belum berhasil memuat data negara.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: textColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Periksa koneksi internet, lalu coba lagi.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: secondaryText,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 18),
                          ElevatedButton.icon(
                            onPressed: _reloadCountries,
                            icon: const Icon(Icons.refresh),
                            label: const Text('Coba Lagi'),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                final allCountries = snapshot.data ?? [];

                final countries = allCountries.where((country) {
                  return country.name.toLowerCase().contains(
                    _searchQuery.trim().toLowerCase(),
                  );
                }).toList();

                if (countries.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.search_off_rounded,
                          size: 60,
                          color: Color(0xFF9AA9BD),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Negara tidak ditemukan',
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: navyBlue,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Coba gunakan nama negara lain.',
                          style: TextStyle(
                            color: secondaryText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 20,
                  ),
                  itemCount: countries.length,
                  itemBuilder: (context, index) {
                    final country = countries[index];

                    return Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      elevation: 2,
                      shadowColor: navyBlue.withValues(alpha: 0.08),
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                        side: const BorderSide(
                          color: Color(0xFFE8EFF8),
                        ),
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        leading: Container(
                          width: 58,
                          height: 58,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF2F7FF),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            country.flag,
                            style: const TextStyle(fontSize: 34),
                          ),
                        ),
                        title: Text(
                          country.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: navyBlue,
                            height: 1.3,
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_city_rounded,
                                    size: 15,
                                    color: primaryBlue,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Ibu kota: ${country.capital}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: textColor,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 5),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.public_rounded,
                                    size: 15,
                                    color: primaryBlue,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      'Wilayah: ${country.region}',
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: secondaryText,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 17,
                          color: primaryBlue,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CountryDetailPage(
                                    country: country,
                                  ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
