import 'dart:io';

void main() {
  print("Enter an integer:");
  String? input = stdin.readLineSync();

  // Parse the input to an integer
  int? number = int.tryParse(input ?? '');

  if (number != null) {
    // Print the equivalent number in words
    print("Equivalent number in words: ${convertToWords(number)}");
  } else {
    print("Invalid input. Please enter a valid integer.");
  }
}

String convertToWords(int number) {
  if (number == 0) {
    return "Zero";
  }

  List<String> units = [
    "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine"
  ];

  List<String> teens = [
    "", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen",
    "Seventeen", "Eighteen", "Nineteen"
  ];

  List<String> tens = [
    "", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"
  ];

  String result = "";

  if (number >= 100) {
    result += "${units[number ~/ 100]} Hundred ";
    number %= 100;
  }

  if (number >= 11 && number <= 19) {
    result += "${teens[number - 10]}";
  } else if (number >= 20 || number == 10) {
    result += "${tens[number ~/ 10]} ";
    number %= 10;
  }

  if (number > 0 && number < 10) {
    result += "${units[number]}";
  }

  return result.trim();
}
