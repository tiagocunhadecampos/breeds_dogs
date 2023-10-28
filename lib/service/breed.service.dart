import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/breed.model.dart';
import '../model/breed_images.model.dart';

const baseUrl = 'https://dog.ceo/api';

class BreedService {
  // Method to fetch images for a specific breed
  static Future<BreedImagesModel?> getImages() async {
    String url = '$baseUrl/breed/hound/images';
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return BreedImagesModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Method to fetch a list of breeds with their sub-breeds
  static Future<List<BreedModel>?> getBreedsNames() async {
    String url = '$baseUrl/breeds/list/all';
    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        final Map<String, dynamic> responseMap = json.decode(res.body);
        final Map<String, dynamic> message = responseMap['message'];

        final List<BreedModel> finalList = message.entries.map((entry) {
          return BreedModel(breed: entry.key, subBreeds: entry.value);
        }).toList();

        return finalList;
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Method to fetch images for a selected breed and sub-breed
  static Future<BreedImagesModel?> getBreedSelect(String breed, String subBreed) async {
    String breedSelect = subBreed.isNotEmpty ? '$breed/$subBreed' : breed;
    String url = '$baseUrl/breed/$breedSelect/images';

    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return BreedImagesModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  // Method to fetch random images for a breed
  static Future<BreedImagesModel?> getBreedRandom(bool radom) async {
    String radomList = radom ? 'random' : 'random/50';
    String url = '$baseUrl/breeds/image/$radomList';

    try {
      var res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        return BreedImagesModel.fromJson(json.decode(res.body));
      } else {
        return null;
      }
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
