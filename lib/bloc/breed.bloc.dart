import 'dart:async';

import '../model/breed.model.dart';
import '../model/breed_images.model.dart';
import '../service/breed.service.dart';

class BreedBloc {
  StreamController<BreedImagesModel?> streamBreedImages = StreamController();
  StreamController<List<BreedModel>?> streamBreed = StreamController();

  // Fetch images for a specific breed
  Future<void> getImages() async {
    // First, add a loading state to indicate data is being fetched
    streamBreedImages.add(null);

    // Add a small delay before fetching the real data
    await Future.delayed(const Duration(milliseconds: 500));

    // Fetch the real data
    BreedImagesModel? images = await BreedService.getImages();

    if (images != null) {
      streamBreedImages.add(images);
    } else {
      // Handle the error state if needed
      streamBreedImages.addError('Failed to load data');
    }
  }

  // Fetch a list of breeds with their sub-breeds
  Future<void> getBreeds() async {
    List<BreedModel>? images = await BreedService.getBreedsNames();

    if (images != null) {
      streamBreed.add(images);
    } else {
      // Handle the error state if needed
      streamBreed.addError('Failed to load data');
    }
  }

  // Fetch images for a selected breed and sub-breed
  Future<void> getBreedSelect(Map<String, dynamic> breedSelect) async {
    streamBreedImages.add(null);

    await Future.delayed(const Duration(milliseconds: 500));

    BreedImagesModel? images = await BreedService.getBreedSelect(breedSelect['breed'], breedSelect['subBreed']);

    if (images is BreedImagesModel) {
      streamBreedImages.add(images);
    } else {
      // Handle the error state if needed
      streamBreedImages.addError('Failed to load data');
    }
  }

  // Fetch random images for a breed
  Future<void> getBreedRandom(bool random) async {
    streamBreedImages.add(null);

    await Future.delayed(const Duration(milliseconds: 500));

    BreedImagesModel? images = await BreedService.getBreedRandom(random);

    if (images is BreedImagesModel) {
      streamBreedImages.add(images);
    } else {
      // Handle the error state if needed
      streamBreedImages.addError('Failed to load data');
    }
  }

  // Close the streams when they are no longer needed
  void dispose() {
    streamBreed.close();
  }
}
