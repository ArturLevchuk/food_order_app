enum ProductTypes { pizza, soup, drink }

class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imgSrc;
  final List<Map<String, dynamic>> additives;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imgSrc,
    required this.additives,
  });
}

class PizzaProduct extends Product {
  final List<Map<String, double>> sizes;

  PizzaProduct({
    required super.id,
    required super.name,
    required super.description,
    required super.imgSrc,
    required this.sizes,
    required super.additives,
  }) : super(price: sizes.first.values.first);
}

List<Product> allProducts = [
  PizzaProduct(
    id: "1",
    name: "Тревісо",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    // price: 220,
    imgSrc: "assets/images/pizza.jpeg",
    additives: [
      {"Моццарелла 40г": 35},
      {"Пармезан 20г": 30},
      {"Чеддер 30г": 27},
      {"Фета 50г": 40},
      {"Сулугуні 50г": 25}
    ],
    sizes: [
      {"30": 150},
      {"40": 180},
      {"75": 220}
    ],
  ),
  PizzaProduct(
    id: "2",
    name: "Баварська",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    // price: 310,
    imgSrc: "assets/images/bavarska.jpeg",
    additives: [
      {"Моццарелла 40г": 35},
      {"Пармезан 20г": 110},
      {"Чеддер 30г": 27},
      {"Фета 50г": 40},
      {"Сулугуні 50г": 125}
    ],
    sizes: [
      {"30": 150},
      {"40": 180},
      {"75": 220},
      {"100": 270},
      {"125": 350},
    ],
  ),
  PizzaProduct(
    id: "2",
    name: "Маргарита",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    // price: 150,
    imgSrc: "assets/images/margarita.png",
    additives: [
      {"Моццарелла 40г": 35},
      {"Пармезан 20г": 30},
      {"Чеддер 30г": 27},
      {"Фета 50г": 40},
      {"Сулугуні 50г": 25}
    ],
    sizes: [
      {"30": 150},
      {"40": 180},
      {"75": 220},
      {"100": 270},
      {"125": 350},
    ],
  ),
  PizzaProduct(
    id: "2",
    name: "Пепероні",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    // price: 215,
    imgSrc: "assets/images/peperoni.png",
    additives: [
      {"Моццарелла 40г": 35},
      {"Пармезан 20г": 30},
      {"Чеддер 30г": 27},
      {"Фета 50г": 40},
      {"Сулугуні 50г": 25}
    ],
    sizes: [
      {"30": 150},
      {"40": 180},
      {"75": 220}
    ],
  ),
];
