import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:luvit_assessment/services/translator_service.dart';
import 'package:luvit_assessment/widgets/selection_bar.dart';

import '../data/fruit.dart';
import 'card_data_population.dart';
import 'custom_heart_button.dart';
import 'custom_icon_button.dart';
import 'gradient_layer.dart';

class CardWidget extends StatefulWidget {
  const CardWidget({super.key, required this.fruitList});
  final List<Fruit> fruitList;

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  TranslationService translator = TranslationService();
  double bottomPosition = 0.0;
  double leftPosition = 0.0;
  int currentPage = 0;
  late PageController pageController;
  int currentFruit = 0;

  void handleRightTap() {
    // Handle tap on the right side of the card.
    print("Tapped on the right side of the card");
    setState(() {
      currentPage =
          (currentPage + 1) % widget.fruitList[currentFruit].images.length;
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut);
    });
  }

  void handleLeftTap() {
    // Handle tap on the left side of the card.
    print("Tapped on the left side of the card");
    setState(() {
      currentPage =
          (currentPage - 1 + widget.fruitList[currentFruit].images.length) %
              widget.fruitList[currentFruit].images.length;
      pageController.animateToPage(currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.linearToEaseOut);
    });
  }

  @override
  Widget build(BuildContext context) {
    //  if (widget.fruitList[currentFruit].images.isNotEmpty)
    pageController = PageController(initialPage: currentPage);

    print('performance: rebuilding Card');
    return Scaffold(
        backgroundColor: const Color(0x000e0d0d),
        body: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  SvgPicture.asset('assets/location.svg'),
                  Text(
                    '목이길어슬픈기린님의 새로운 스팟',
                    style: Theme.of(context).textTheme.bodyMedium,
                  )
                ],
              ),
              Row(
                children: [
                  CustomIconButton(
                      icon: SvgPicture.asset('assets/star2.svg'),
                      label: '323,233'),
                  SvgPicture.asset('assets/bell.svg'),
                ],
              )
            ],
          ),
          SizedBox(
            height: 730,
            child: (currentFruit >= widget.fruitList.length)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('추천 드릴 친구들을 준비 중이에요',
                            style: Theme.of(context).textTheme.displayLarge),
                        const SizedBox(
                          height: 8,
                        ),
                        Text('매일 새로운 친구들을 소개시켜드려요',
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  )
                : GestureDetector(
                    onVerticalDragUpdate: (details) {
                      // Handle vertical swipe on the card.
                      if (details.delta.dy > 0) {
                        print("Swiped down on the card");
                        setState(() {
                          bottomPosition += details.delta.dy;
                        });
                      } else if (details.delta.dy < 0) {
                        print("Swiped up on the card");
                      }
                    },
                    onHorizontalDragUpdate: (details) {
                      // Handle horizontal swipe on the card.
                      if (details.delta.dx > 0) {
                        print("Swiped right on the card");
                      } else if (details.delta.dx < 0) {
                        print("Swiped left on the card");
                        setState(() {
                          leftPosition += details.delta.dx;
                        });
                      }
                    },
                    onHorizontalDragEnd: (details) => setState(() {
                          if (leftPosition != 0) {
                            currentFruit++;
                          }
                          leftPosition = 0;
                        }),
                    onVerticalDragEnd: (details) => setState(() {
                          if (bottomPosition != 0) {
                            currentFruit++;
                          }
                          bottomPosition = 0;
                        }),
                    child: Stack(children: [
                      AnimatedPositioned(
                          duration: const Duration(milliseconds: 200),
                          left: leftPosition,
                          bottom: bottomPosition * -1,
                          child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                  color: const Color(0x0E0D0D),
                                  borderRadius: BorderRadius.circular(16.0),
                                  border: Border.all(
                                      color: Color.fromARGB(255, 52, 52, 52),
                                      width: 1)),
                              margin: const EdgeInsets.all(32.0),
                              height: MediaQuery.of(context).size.height - 250,
                              width: MediaQuery.of(context).size.width - 64,
                              child: Center(
                                  child: SizedBox(
                                      height: 700,
                                      child: Stack(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            child: PageView.builder(
                                                itemCount:
                                                    widget.fruitList.length,
                                                controller: pageController,
                                                onPageChanged: (int index) {
                                                  setState(() {
                                                    currentPage = index;
                                                  });
                                                },
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Image.network(
                                                    widget
                                                        .fruitList[currentFruit]
                                                        .images[index],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                            error,
                                                            stackTrace) =>
                                                        Center(
                                                      child: Text(
                                                        'Error Loading Image.',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge,
                                                      ),
                                                    ),
                                                  );
                                                }),
                                          ),
                                          SelectorBar(
                                              widget: widget,
                                              currentFruit: currentFruit,
                                              currentPage: currentPage),
                                          const GradientLayer(),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: GestureDetector(
                                              onTap: handleLeftTap,
                                              behavior: HitTestBehavior.opaque,
                                              child: Container(
                                                alignment: Alignment.centerLeft,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        64) /
                                                    2,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: GestureDetector(
                                              onTap: handleRightTap,
                                              behavior: HitTestBehavior.opaque,
                                              child: Container(
                                                alignment:
                                                    Alignment.centerRight,
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        64) /
                                                    2,
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.bottomCenter,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      CardDataPopulation(
                                                          widget: widget,
                                                          currentFruit:
                                                              currentFruit),
                                                      const CustomHeartButton()
                                                    ],
                                                  ),
                                                  const Icon(
                                                    Icons
                                                        .keyboard_arrow_down_rounded,
                                                    color: Colors.white,
                                                  )
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      )))))
                    ])),
          )
        ]));
  }
}
