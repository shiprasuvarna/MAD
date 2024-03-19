import 'dart:io';

void main() {
  print("Enter an integer:");
  String? input = stdin.readLineSync();

  // Parse the input to an integer
  int? number = int.tryParse(input ?? '');

  if (number != null && number >= 0) {
    // Print the Fibonacci series up to the input number
    print("Fibonacci series up to $number:");
    printFibonacciSeries(number);
  } else {
    print("Invalid input. Please enter a valid non-negative integer.");
  }
}

void printFibonacciSeries(int n) {
  int first = 0;
  int second = 1;

  while (first <= n) {
    print(first);
    int next = first + second;
    first = second;
    second = next;
  }
}
