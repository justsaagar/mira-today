import 'dart:math';

import 'package:demo/model/card_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  int stepCount = 0;
  List cardTempList = [];
  List<CardModel> cardList = [];
  CardModel? cardStep1;
  CardModel? cardStep2;
  Random random = Random();

  List list = ['steve', 'bill', 'musk'];

  getCardList() {
    cardStep1 = null;
    cardStep2 = null;
    stepCount = 0;
    cardList = [];
    cardTempList = [];

    List<int> numbers = [];

    for (int i = 0; i < 6; i++) {
      int randomNumber = random.nextInt(90) + 10;
      numbers.add(randomNumber);
    }
    cardTempList = numbers + numbers;
    cardTempList.shuffle();
    for (var element in cardTempList) {
      cardList.add(CardModel(element, isCardOpened: false));
    }
    update();
  }

  cardOnTap(BuildContext context, CardModel cardModel) {
    stepCount++;
    if (stepCount % 2 == 0) {
      cardStep1 = cardModel;
    } else {
      cardStep2 = cardModel;
    }
    cardModel.isCardOpened = true;

    if (cardStep1 != null && cardStep2 != null && cardStep1!.cardNumber == cardStep2!.cardNumber) {
      cardStep1 = null;
      cardStep2 = null;
    } else if (cardStep1 != null && cardStep2 != null) {
      Future.delayed(const Duration(microseconds: 1000), () {
        cardList.every((element) {
          if (element.cardNumber == cardStep1?.cardNumber || element.cardNumber == cardStep2?.cardNumber) {
            element.isCardOpened = false;
          }
          return true;
        });
        cardStep1 = null;
        cardStep2 = null;
        update();
      });
    }
    if (cardList.every((element) => element.isCardOpened)) {
      Get.dialog(
        AlertDialog(
          title: const Center(child: Text('You are win...👑')),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 15,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    getCardList();
                    Get.back();
                  },
                  child: const Text('Restart',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 15,
                      )),
                ),
              ],
            ),
          ),
        ),
      );
    }
    update();
  }
}
