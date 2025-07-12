class FoodEntity {
  final String imageCard;
  final String id;
  final String imageDetail;
  final String name;
  final double price;
  final double rate;
  final String specialItems;
  final String category;
  final int kcal;
  final String time;

  FoodEntity({
    required this.imageCard,
    required this.imageDetail,
    required this.name,
    required this.price,
    required this.rate,
    required this.specialItems,
    required this.category,
    required this.kcal,
    required this.time,
    required this.id,
  });
}