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

  @override
  String toString() => '$quantity x ${product.name}: \$$price';
}

class Cart {
  final Map<int, Item> _items = {};

  void addProduct(product) {
    final item = _items[product.id];
    if (item == null) {
      _items[product.id] = Item(product: product, quantity: 1);
    } else {
      _items[product.id] = Item(product: product, quantity: item.quantity + 1);
    }
  }

  double total() => _items.values
      .map((item) => item.price)
      .reduce((value, element) => value + element);

  @override
  String toString() {
    if (_items.isEmpty) {
      print('cart be empty bruv');
    }
    final itemizedList =
        _items.values.map((item) => item.toString()).join('\n');
    return '------\n$itemizedList\nTotal: \$${total()}\n------';
  }

  bool get isEmpty => _items.isEmpty;
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
