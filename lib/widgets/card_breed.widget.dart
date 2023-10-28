import 'package:flutter/material.dart';
import '../utils/theme.utils.dart';

class CardBreed extends StatelessWidget {
  final String image;
  const CardBreed({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: ThemeUtils.getTheme(),
          width: 2.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
              color: ThemeUtils.getThemeBackground(),
            ),
            child: ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Breed:',
                    style: TextStyle(
                      color: ThemeUtils.getThemeTitle(),
                      fontSize: 14,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        getUrlBreed(),
                        style: TextStyle(
                          color: ThemeUtils.getThemeTitle(),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => showImageModal(context),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return Image.asset(
                      'assets/images/dog_placeholder.png',
                      fit: BoxFit.cover,
                    );
                  },
                  errorBuilder: (context, url, error) => ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/dog_placeholder.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String getUrlBreed() {
    Uri uri = Uri.parse(image);

    // Get the path segments of the URL
    List<String> pathSegments = uri.pathSegments;

    // Look for the segment that contains "breeds/"
    int index = pathSegments.indexOf("breeds");

    // Check if "breeds/" was found and if there is a next segment
    if (index >= 0 && index < pathSegments.length - 1) {
      return pathSegments[index + 1]; // Return the next segment
    } else {
      return ''; // Not found or no next segment
    }
  }

  showImageModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(12),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image,
                    errorBuilder: (context, url, error) => ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        'assets/images/dog_placeholder.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 30,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: CircleAvatar(
                      backgroundColor: ThemeUtils.getTheme(),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
