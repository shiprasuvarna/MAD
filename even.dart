import 'dart:io';

void main() {
  print("Enter a list of integer numbers separated by space:");

  // Read input from the user
  String input = stdin.readLineSync()!;
  
  // Split the input string into a list of strings
  List<String> numbersAsString = input.split(' ');

  // Convert each string to an integer and filter out non-integer values
  List<int> numbers = numbersAsString
      .where((element) => int.tryParse(element) != null)
      .map((element) => int.parse(element))
      .toList();

  // Print even numbers
  print("Even numbers in the list:");
  for (int number in numbers) {
    if (number % 2 == 0) {
      print(number);
    }
  }
}
