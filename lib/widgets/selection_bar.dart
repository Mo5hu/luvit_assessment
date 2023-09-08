import 'package:flutter/material.dart';

import 'card.dart';

class SelectorBar extends StatelessWidget {
  const SelectorBar({
    super.key,
    required this.widget,
    required this.currentFruit,
    required this.currentPage,
  });

  final CardWidget widget;
  final int currentFruit;
  final int currentPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      height: 35,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: (MediaQuery.of(context).size.width -
                      32 -
                      64 -
                      (widget.fruitList[currentFruit].images.length * 4)) /
                  widget.fruitList[currentFruit].images.length,
              decoration: BoxDecoration(
                color: (index == currentPage)
                    ? const Color(0xFFff0e73)
                    : const Color(0xFF202020),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
          );
        },
        itemCount: widget.fruitList[currentFruit].images.length,
      ),
    );
  }
}
