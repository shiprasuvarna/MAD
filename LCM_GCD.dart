import 'dart:io';

void main() {
  print("Enter the first integer:");
  String? input1 = stdin.readLineSync();
  print("Enter the second integer:");
  String? input2 = stdin.readLineSync();

  // Parse the inputs to integers
  int? number1 = int.tryParse(input1 ?? '');
  int? number2 = int.tryParse(input2 ?? '');

  if (number1 != null && number2 != null) {
    // Calculate and print the LCM and GCD
    print("LCM: ${calculateLCM(number1, number2)}");
    print("GCD: ${calculateGCD(number1, number2)}");
  } else {
    print("Invalid input. Please enter valid integers.");
  }
}

int calculateLCM(int a, int b) {
  // LCM is the product of two numbers divided by their GCD
  return (a * b) ~/ calculateGCD(a, b);
}

int calculateGCD(int a, int b) {
  // Euclidean algorithm to find GCD
  while (b != 0) {
    int temp = b;
    b = a % b;
    a = temp;
  }
  return a;
}
