// enum ProductType { pizza, soup, drink, salads }

enum ProductType {
  pizza,
  soup,
  drink,
  salads;

  String getProductUnit(String unit) {
    switch (this) {
      case ProductType.pizza:
        return "Ø$unit";
      case ProductType.soup || ProductType.drink || ProductType.salads:
        return "$unit гр.";
      default:
        return unit;
    }
  }
}

class Product {
  final String id;
  final String name;
  final String description;
  final String imgSrc;
  final ProductType productType;
  final Map<String, dynamic> additives;
  final Map<String, dynamic> sizes;

  Product({
    required this.id,
    required this.name,
    required this.description,
    required this.imgSrc,
    required this.productType,
    required this.additives,
    required this.sizes,
  });
}

List<Product> allProducts = [
  Product(
      id: "1",
      name: "Тревісо",
      description:
          "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
      imgSrc: "assets/images/pizza.jpeg",
      productType: ProductType.pizza,
      additives: {
        "Моццарелла 40г": 35,
        "Пармезан 20г": 30,
        "Чеддер 30г": 27,
        "Фета 50г": 40,
        "Сулугуні 50г": 25
      },
      sizes: {
        "30": 150,
        "40": 180,
        "75": 220
      }
      ),
  Product(
      id: "2",
      name: "Баварська",
      description:
          "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
      imgSrc: "assets/images/bavarska.jpeg",
      productType: ProductType.pizza,
      additives: {
        "Моццарелла 40г": 35,
        "Пармезан 20г": 30,
        "Чеддер 30г": 27,
        "Фета 50г": 40,
        "Сулугуні 50г": 25
      },
      sizes: {
        "30": 150,
        "40": 180,
        "75": 220,
        "100": 270,
        "125": 350
      }
      // additives: [
      //   {"Моццарелла 40г": 35},
      //   {"Пармезан 20г": 110},
      //   {"Чеддер 30г": 27},
      //   {"Фета 50г": 40},
      //   {"Сулугуні 50г": 125}
      // ],
      // sizes: [
      //   {"30": 150},
      //   {"40": 180},
      //   {"75": 220},
      //   {"100": 270},
      //   {"125": 350},
      // ],
      ),
  Product(
      id: "2",
      name: "Маргарита",
      description:
          "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
      imgSrc: "assets/images/margarita.png",
      productType: ProductType.pizza,
      additives: {
        "Моццарелла 40г": 35,
        "Пармезан 20г": 30,
        "Чеддер 30г": 27,
        "Фета 50г": 40,
        "Сулугуні 50г": 25
      },
      sizes: {
        "30": 150,
        "40": 180,
        "75": 220,
        "100": 270,
        "125": 350
      }),
  Product(
    id: "2",
    name: "Пепероні",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    imgSrc: "assets/images/peperoni.png",
    productType: ProductType.salads,
    additives: {
      "Моццарелла 40г": 35,
      "Пармезан 20г": 30,
      "Чеддер 30г": 27,
      "Фета 50г": 40,
      "Сулугуні 50г": 25
    },
    sizes: {
      "30": 150,
      "40": 180,
      "75": 220,
      "100": 270,
      "125": 350,
    },
  ),
];
