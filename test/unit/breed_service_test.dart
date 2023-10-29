import 'package:flutter_test/flutter_test.dart';
import 'package:breeds_dogs/service/breed.service.dart';

void main() {
  test('Test if getImages returns a non-null result', () async {
    final result = await BreedService.getImages();
    expect(result, isNotNull);
  });
}
