import 'dart:io';

import 'package:test/cart.dart';
import 'package:test/product.dart';

const allProducts = [
  Product(id: 1, name: "apples", price: 1.50),
  Product(id: 2, name: "bananas", price: 2.25),
  Product(id: 3, name: "pears", price: 3.00),
  Product(id: 4, name: "grapes", price: 4.50),
  Product(id: 5, name: "cucumbers", price: 2.50),
  Product(id: 6, name: "steak", price: 19.50),
];

Product? chooseProduct() {
  final productList =
      allProducts.map((product) => product.displayName).join('\n');
  stdout.write('Available products:\n$productList\nYour choice: ');
  final line = stdin.readLineSync();
  for (var product in allProducts) {
    if (product.initial == line) {
      return product;
    }
  }
  print('Product not found bruv');
  return null;
}

bool checkout(Cart cart) {
  if (cart.isEmpty) {
    print('cart is empty yo');
    return false;
  }
  final total = cart.total();
  print('Total: \$$total');
  stdout.write('Payment in cash: ');
  final line = stdin.readLineSync();
  if (line == null || line.isEmpty) {
    return false;
  }
  final paid = double.tryParse(line);
  if (paid == null) {
    return false;
  }
  if (paid >= total) {
    final change = paid - total;
    print('Change: \$${change.toStringAsFixed(2)}');
    return true;
  } else {
    print('Not enough cash home slice');
    return false;
  }
}

void main() {
  final cart = Cart();
  while (true) {
    stdout.write(
        "What would you like to do? (v)iew items, (a)dd items, or (c)heckout: ");
    final line = stdin.readLineSync();
    if (line == 'a') {
      final product = chooseProduct();
      if (product != null) {
        cart.addProduct(product);
        print(cart);
      }
    }
    if (line == 'v') {
        print(cart);
    }
    if (line == 'c') {
      if (checkout(cart)) {
        break;
      }
    }
  }
}
