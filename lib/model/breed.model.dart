class BreedModel {
  final String breed;
  final List<dynamic>? subBreeds;

  BreedModel({
    required this.breed,
    required this.subBreeds,
  });

  factory BreedModel.fromJson(String breed, List<String> subBreeds) {
    return BreedModel(breed: breed, subBreeds: subBreeds);
  }
}
