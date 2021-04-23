import 'dart:io';

const allProducts = [
  Product(id: 1, name: "apples", price: 1.50),
  Product(id: 2, name: "bananas", price: 2.25),
  Product(id: 3, name: "pears", price: 3.00),
  Product(id: 4, name: "grapes", price: 4.50),
  Product(id: 5, name: "cucumbers", price: 2.50),
  Product(id: 6, name: "steak", price: 19.50),
];

class Product {
  const Product({required this.id, required this.name, required this.price});
  final int id;
  final String name;
  final double price;

  String get displayName => '($initial)${name.substring(1)}: \$$price';
  String get initial => name.substring(0, 1);
}

class Item {
  const Item({required this.product, this.quantity = 1});

  final Product product;
  final int quantity;

  double get price => quantity * product.price;
}

class Cart {
  final Map<int, Item> _items = {};

  void addProduct(Product, product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = Item(product: product, quantity: 1);
    } else {
      _items[product.id] = Item(product: product, quantity: item.quantity + 1);
    }
  }

  @override
  String toString() {
    if (_items.isEmpty) {
      print('cart be empty bruv');
    }
  }
}

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

void main() {
  while (true) {
    stdout.write(
        "What would you like to do? (v)iew items, (a)dd items, or (c)heckout: ");
    final line = stdin.readLineSync();
    if (line == 'a') {
      final product = chooseProduct();
      if (product != null) {
        print(product.displayName);
      }
    }
    if (line == 'v') {
      final product = chooseProduct();
      if (product != null) {
        print(product.displayName);
      }
    }
    if (line == 'c') {
      final product = chooseProduct();
      if (product != null) {
        print(product.displayName);
      }
    }
  }
}
