// RANDOM GENERATOR ACTIVITY

import 'dart:math';

String generateRandomString(int lengthOfString) {
  final random = Random();
  const allChars =
      'AaBbCcDdlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1EeFfGgHhIiJjKkL234567890';
  final randomString = List.generate(
          lengthOfString, (index) => allChars[random.nextInt(allChars.length)])
      .join();
  return randomString;
}

String passWord() {
  return "${generateRandomString(4)}p${generateRandomString(2)}ar${generateRandomString(2)}t${generateRandomString(3)}hn";
}
