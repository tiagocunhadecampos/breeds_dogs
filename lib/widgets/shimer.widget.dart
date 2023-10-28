import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimerWidget extends StatelessWidget {
  const ShimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey,
      highlightColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 3.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50,
                width: double.infinity,
                color: Colors.grey,
              ),
              const SizedBox(
                height: 2,
              ),
              Expanded(
                child: Container(
                  height: 270,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
