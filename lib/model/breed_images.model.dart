class BreedImagesModel {
  final List<dynamic> images;

  BreedImagesModel({
    required this.images,
  });

  factory BreedImagesModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> listImages = (json['message'] is List) ? json['message'] : [json['message']];
    return BreedImagesModel(
      images: listImages,
    );
  }
}
