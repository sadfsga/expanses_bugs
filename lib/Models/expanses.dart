import 'package:expenses_app/widgets/expanses.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

const uuid = Uuid();
final dateFormatter = DateFormat.yMd();

enum Category { food, leisure, travel, work }

const categoryicon = {
  Category.food: Icons.restaurant,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight,
  Category.work: Icons.work,
};

class Expansesmodel {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
  String formattedDate() {
    return dateFormatter.format(date);
  }

  Expansesmodel({
    required this.category,
    required this.title,
    required this.amount,
    required this.date,
  }) : id = uuid.v4();
}

class ExpansesBucket {
  final Category category;
  final List<Expansesmodel> expanseslist;

  ExpansesBucket({required this.category, required this.expanseslist});
  ExpansesBucket.forCategory(List<Expansesmodel> allExpanses, this.category)
    : expanseslist = allExpanses
          .where((expanses) => expanses.category == category)
          .toList();
  double get totalAmount {
    double sum = 0;
    for (final expanses in expanseslist) {
      sum += expanses.amount;
    }
    return sum;
  }
}
