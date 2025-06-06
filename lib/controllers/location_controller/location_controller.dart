import 'dart:async';

import 'package:get/get.dart';
import 'package:simple_nav_bar/models/city.dart';

class LocationController extends GetxController {
  final cities = <City>[..._chadCities].obs;
  final filteredCities = <City>[..._chadCities].obs;
  final filteredSubPrefectures = <String>[].obs;

  final isSubPrefecturePage = false.obs;
  final selectedCity = Rx<City?>(null);

  final RxString searchQuery = ''.obs;
  Timer? debounce;

  void setSearchQuery(String query) {
    searchQuery.value = query;

    debounce?.cancel();
    debounce = Timer(Duration(milliseconds: 300), () {
      if (isSubPrefecturePage.value && selectedCity.value != null) {
        filterSubPrefectures(selectedCity.value!, query: query);
      } else {
        filterCities(query);
      }
    });
  }

  void filterCities(String query) {
    final results = _chadCities;
    if (query.isEmpty) {
      filteredCities.assignAll(results);
    } else {
      filteredCities.assignAll(
        _chadCities
            .where((c) => c.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void filterSubPrefectures(City city, {String query = ''}) {
    final allSubPrefectures = city.subPrefectures;
    if (query.isEmpty) {
      filteredSubPrefectures.assignAll(allSubPrefectures);
    } else {
      filteredSubPrefectures.assignAll(
        allSubPrefectures.where(
          (s) => s.toLowerCase().contains(query.toLowerCase()),
        ),
      );
    }
  }

  static final List<City> _chadCities = [
    City(
      name: "N'Djamena",
      subPrefectures: [
        "N'Djamena-Centre",
        "N'Djamena-Nord",
        "N'Djamena-Sud",
        "N'Djamena-Est",
        "N'Djamena-Ouest",
      ],
    ),
    City(
      name: "Moundou",
      subPrefectures: ["Moundou Centre", "Bébalem", "Mbikou", "Béna"],
    ),
    City(
      name: "Sarh",
      subPrefectures: ["Sarh", "Kyabé", "Koumra", "Danamadji"],
    ),
    City(
      name: "Abeché",
      subPrefectures: ["Abeché", "Abdi", "Biltine", "Arada"],
    ),
    City(
      name: "Mongo",
      subPrefectures: ["Mongo", "Mangalmé", "Bitkine", "Baro"],
    ),
    City(
      name: "Am-Timan",
      subPrefectures: [
        "Am-Timan",
        "Haraze Mangueigne",
        "Aboudeïa",
        "Djourf Al Ahmar",
      ],
    ),
    City(
      name: "Bongor",
      subPrefectures: ["Bongor", "Gounou Gaya", "Fianga", "Kélo"],
    ),
    City(name: "Pala", subPrefectures: ["Pala", "Léré", "Binder", "Lamé"]),
    City(
      name: "Faya-Largeau",
      subPrefectures: ["Faya", "Kirdimi", "Kouba Olanga"],
    ),
    City(name: "Bol", subPrefectures: ["Bol", "Bagasola", "Liwa"]),
  ];
}
