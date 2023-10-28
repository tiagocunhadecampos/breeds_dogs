import 'package:breeds_dogs/widgets/customFlushbar.utils.dart';
import 'package:breeds_dogs/widgets/select.widget.dart';
import 'package:flutter/material.dart';

import '../model/breed.model.dart';
import '../utils/theme.utils.dart';
import 'buton.widget.dart';

class FilterWidget extends StatefulWidget {
  final List<BreedModel>? items;
  final Function(Map<String, dynamic>) action;
  const FilterWidget({this.items, required this.action, super.key});

  @override
  State<FilterWidget> createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  List<dynamic> subBreedList = [];
  String breedSelect = '';
  String subBreedSelect = '';

  void setListSubBreed(String breed) {
    setState(() {
      breedSelect = breed;
      subBreedList = widget.items!
          .where((element) => element.breed == breedSelect)
          .map((element) => element.subBreeds)
          .expand((subBreeds) => subBreeds ?? [])
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: InkWell(
                child: Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: 150,
                  height: 5,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: ThemeUtils.getTheme()),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            SelecWidget(
              title: 'Breed',
              hint: 'Select Breed',
              items: widget.items,
              action: (value) async {
                debugPrint(value);
                setListSubBreed(value);
              },
            ),
            subBreedList.isNotEmpty
                ? SelecWidget(
                    title: 'Sub-Breed',
                    hint: 'Select Sub-Breed',
                    items: subBreedList,
                    action: (value) {
                      debugPrint(value);
                      setState(() {
                        subBreedSelect = value;
                      });
                    },
                  )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ButtonWidget(
                title: 'CONFIRM',
                selectColor: ThemeUtils.getThemeTitle(),
                onPressed: () {
                  Map<String, dynamic> breedsSelect = {'breed': breedSelect, 'subBreed': subBreedSelect};
                  if (breedSelect.isNotEmpty) {
                    widget.action(breedsSelect);
                    Navigator.pop(context);
                    CustomFlushbar.showTopFlushbar(context, text: 'Selected Breed $breedSelect $subBreedSelect');
                  } else {
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
