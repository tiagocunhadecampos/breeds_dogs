import 'package:breeds_dogs/widgets/customFlushbar.utils.dart';
import 'package:breeds_dogs/widgets/filter.widget.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../bloc/breed.bloc.dart';
import '../utils/theme.utils.dart';
import '../widgets/buton.widget.dart';
import '../widgets/card_breed.widget.dart';
import '../widgets/shimer.widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late BreedBloc _bloc;
  ValueNotifier<bool> isButtonRandom = ValueNotifier<bool>(true);

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    _bloc = BreedBloc();
    await _bloc.getImages();
    await _bloc.getBreeds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeUtils.getBackGround(),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ThemeUtils.getBackGround(),
        flexibleSpace: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Lottie.asset(
                'assets/images/breed.json',
                fit: BoxFit.contain,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Breeds',
                style: TextStyle(
                  color: ThemeUtils.getTheme(),
                  fontFamily: 'GreatVibes',
                  fontSize: 35,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Divider(
              color: ThemeUtils.getTheme(),
              thickness: 0.5,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await _bloc.getImages();
                },
                color: ThemeUtils.getTheme(),
                child: StreamBuilder(
                  stream: _bloc.streamBreedImages.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: snapshot.data!.images.length,
                        itemBuilder: (context, index) {
                          return CardBreed(image: snapshot.data!.images[index]);
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Error: ${snapshot.error}',
                              style: TextStyle(color: ThemeUtils.getErrorColor(), fontSize: 20),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
                              child: ButtonWidget(
                                  title: 'TRY AGAIN',
                                  selectColor: ThemeUtils.getTheme(),
                                  onPressed: () async {
                                    await _bloc.getImages();
                                    await _bloc.getBreeds();
                                  }),
                            )
                          ],
                        ),
                      );
                    } else {
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // Defina o número de colunas desejado
                        ),
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return const ShimerWidget();
                        },
                      );
                    }
                  },
                ),
              ),
            ),
            Divider(
              color: ThemeUtils.getTheme(),
              thickness: 0.5,
            ),
            const SizedBox(
              height: 10,
            ),
            StreamBuilder(
                stream: _bloc.streamBreed.stream,
                builder: (context, snapshot) {
                  final data = snapshot.data;
                  return ButtonWidget(
                    title: 'FILTER',
                    selectColor: ThemeUtils.getThemeTitle(),
                    onPressed: () {
                      showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0))),
                        builder: (context) {
                          return FilterWidget(
                              items: data,
                              action: (value) {
                                _bloc.getBreedSelect(value);
                              });
                        },
                      );
                    },
                  );
                }),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 90.0),
          child: ValueListenableBuilder<bool>(
            valueListenable: isButtonRandom,
            builder: (BuildContext context, bool isEnabled, Widget? child) {
              return FloatingActionButton(
                backgroundColor: ThemeUtils.getThemeTitle(),
                onPressed: () {
                  _bloc.getBreedRandom(isButtonRandom.value);
                  String selectRandom =
                      isButtonRandom.value ? 'Selected a random breed' : 'Selected Breeds and Subbreed at random';
                  isButtonRandom.value = !isButtonRandom.value;
                  CustomFlushbar.showTopFlushbar(context, text: selectRandom);
                },
                child: const Icon(
                  Icons.shuffle,
                  color: Colors.white,
                ),
              );
            },
          )),
    );
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
