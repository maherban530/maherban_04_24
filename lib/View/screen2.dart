import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controllers/second_controller.dart';


class Screen2 extends StatelessWidget {
  Screen2({super.key});

  final SecondController secondController = Get.put(SecondController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SizedBox.fromSize(
          size: const Size(200, 60),
          child: Obx( () => 
             FlipCard(
              toggler: secondController.toggler.value,
              frontCard: AppCard(title: secondController.initText.value),
              backCard: AppCard(title: secondController.initText.value),
            ),
          ),
        ),
      ),
    );
  } 
}

class AppCard extends StatelessWidget {
  final String title;

  const AppCard({super.key, 
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.indigo[400],
      ),
      child: Center(
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 40.0,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class FlipCard extends StatelessWidget {
  final bool toggler;
  final Widget frontCard;
  final Widget backCard;

  const FlipCard({super.key, 
    required this.toggler,
    required this.backCard,
    required this.frontCard,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 800),
        transitionBuilder: _transitionBuilder,
        layoutBuilder: (widget, list) => Stack(children: [widget!, ...list]),
        switchInCurve: Curves.ease,
        switchOutCurve: Curves.ease.flipped,
        child: toggler
            ? SizedBox(key: const ValueKey('front'), child: frontCard)
            : SizedBox(key: const ValueKey('back'), child: backCard),
      ),
    );
  }

  Widget _transitionBuilder(Widget widget, Animation<double> animation) {
    final rotateAnimation = Tween(begin: pi, end: 0.0).animate(animation);
    return AnimatedBuilder(
      animation: rotateAnimation,
      child: widget,
      builder: (context, widget) {
        final isFront = ValueKey(toggler) == widget!.key;
        final rotationY = isFront ? rotateAnimation.value : min(rotateAnimation.value, pi * 0.5);
        return Transform(
          transform: Matrix4.rotationX(rotationY)..setEntry(3, 0, 0),
          alignment: Alignment.center,
          child: widget,
        );
      },
    );
  }
}