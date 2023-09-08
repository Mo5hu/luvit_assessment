import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'card.dart';
import 'custom_icon_button.dart';

class CardDataPopulation extends StatelessWidget {
  const CardDataPopulation({
    super.key,
    required this.widget,
    required this.currentFruit,
  });

  final CardWidget widget;
  final int currentFruit;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomIconButton(
          icon: SvgPicture.asset('assets/star.svg'),
          label: '29,930',
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(widget.fruitList[currentFruit].name,
                style: Theme.of(context).textTheme.displayLarge),
            Text(widget.fruitList[currentFruit].age.toString(),
                style: Theme.of(context).textTheme.bodyLarge),
          ],
        ),
        Text(
          widget.fruitList[currentFruit].description,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('goodSmile'),
          child: const CustomIconButton(
            icon: Text('🍸'),
            label: '전혀 안 함',
          ),
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('smocking'),
          child: const CustomIconButton(
            icon: Text('🚬'),
            label: '비흡연',
          ),
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('exercise'),
          child: const CustomIconButton(
            icon: Text('💪🏻'),
            label: '매일 1시간 이상',
          ),
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('goodFace'),
          child: const CustomIconButton(
            icon: Text('🤝'),
            label: '만나는 걸 좋아함',
          ),
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('INFP'),
          child: const CustomIconButton(
            icon: Text(''),
            label: 'INFP',
          ),
        ),
        Visibility(
          visible: widget.fruitList[currentFruit].tags.contains('INTP'),
          child: const CustomIconButton(
            icon: Text(''),
            label: 'INTP',
          ),
        ),
      ],
    );
  }
}
