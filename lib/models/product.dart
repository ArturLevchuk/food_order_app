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
      }),
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
      }),
  Product(
      id: "3",
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
    id: "4",
    name: "Пепероні",
    description:
        "Соус гірчичний, сир Моцарела, салямі, свинина, мисливські ковбаски, помідори, мариновані огірки, мисливські ковбаски, перець гострий, олія часникова, зелень",
    imgSrc: "assets/images/peperoni.png",
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
      "125": 350,
    },
  ),
  Product(
    id: '5',
    name: 'Цезар з куркою',
    description:
        'Смачний салат Цезар з соковитою куркою, сиром пармезан та ароматними грінками. Класичний рецепт із соусом на основі яєць, оливкової олії та часнику. Ідеально поєднує солодку курку, хрусткі грінки та ніжний сир. Додає сил та насолоди смаком.',
    imgSrc: 'assets/images/caesar-salad.jpg',
    productType: ProductType.salads,
    additives: {'Цезарне соус': 10, 'Пармезан': 20, 'Грінки': 15},
    sizes: {
      '150': 150,
      '300': 300,
    },
  ),
  Product(
    id: '6',
    name: 'Грецький салат',
    description:
        'Овочевий рай у тарілці! Яскравий грецький салат зі свіжих помідорів, огірків, перцю, цибулі та оливок. Заправлений ароматною оливковою олією та освіжаючим узбецьким сиром фета. Ідеальна легка страва для спекотної погоди. Насичує вітамінами та дарує смак Середземномор',
    imgSrc: 'assets/images/greek-salad.jpg',
    productType: ProductType.salads,
    additives: {'Фета': 15, 'Маслини': 5, 'Оливкова олія': 20},
    sizes: {'200': 200, '400': 400},
  ),
  Product(
    id: '7',
    name: 'Салат із креветками',
    description:
        'Розкішний салат зі смаженими креветками, ніжним авокадо та солодкими чері-томатами. Ідеальне поєднання смаків та текстур. Ароматні креветки додають насиченості, авокадо - кремовості, а соковиті томати - свіжості. Піднімає настрій та дарує море задоволення.',
    imgSrc: 'assets/images/shrimp-salad.jpg',
    productType: ProductType.salads,
    additives: {'Креветки': 50, 'Авокадо': 20, 'Чері-томати': 10},
    sizes: {'250': 250, '500': 300},
  ),
];
