import 'package:flutter/foundation.dart';

class StarHelper {

  // إظهار أو إخفاء نجومة
  static final ValueNotifier<bool> visible =
      ValueNotifier(false);

  // الرسالة الحالية
  static final ValueNotifier<String> message =
      ValueNotifier("");

  // عنوان العملية
  static final ValueNotifier<String> title =
      ValueNotifier("");

  // نوع العملية
  static final ValueNotifier<String> action =
      ValueNotifier("");

  // عدد النجوم المطلوبة
  static final ValueNotifier<int> stars =
      ValueNotifier(0);

  // هل يوجد زر إعلان
  static final ValueNotifier<bool> showAdButton =
      ValueNotifier(false);

  // هل يوجد زر نجوم
  static final ValueNotifier<bool> showStarButton =
      ValueNotifier(false);
  static void hide() {

    visible.value = false;

  }

  static void show({

    required String titleText,

    required String messageText,

    String actionName = "",

    int needStars = 0,

    bool adButton = false,

    bool starButton = false,

  }) {

    title.value = titleText;

    message.value = messageText;

    action.value = actionName;

    stars.value = needStars;

    showAdButton.value = adButton;

    showStarButton.value = starButton;

    visible.value = true;

  }
  static void showHint() {

    show(

      titleText: "نجومة ⭐",

      messageText: "هل تريد تلميحاً؟",

      actionName: "hint",

      adButton: true,

    );

  }

  static void showUnlockGame(int needStars) {

    show(

      titleText: "فتح اللعبة",

      messageText:
          "يمكنني فتح اللعبة مقابل $needStars نجوم أو مشاهدة إعلان.",

      actionName: "unlock_game",

      needStars: needStars,

      starButton: true,

      adButton: true,

    );

  }

  static void showSkipLevel(int needStars) {

    show(

      titleText: "تخطي المرحلة",

      messageText:
          "هل تريد تخطي المرحلة؟",

      actionName: "skip_level",

      needStars: needStars,

      starButton: true,

      adButton: true,

    );

  }

}