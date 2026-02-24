import 'dart:math';

import 'package:expenses_app/Models/expanses.dart';
import 'package:expenses_app/widgets/expanses%20list/expanses_item.dart';
import 'package:flutter/material.dart';

class ExpansesList extends StatelessWidget {
  const ExpansesList({super.key, required this.expanses, required this.onRemoveExpanses});

  final List<Expansesmodel> expanses;
  final Function(Expansesmodel) onRemoveExpanses;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expanses.length,
      itemBuilder: (context, index) =>
          Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withOpacity(0.75),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: const Icon(Icons.delete, color: Colors.white,),
            ),
            key: ValueKey(expanses[index]),
            onDismissed: (direction)=> onRemoveExpanses(expanses[index]),
            child: expansesItem(expanses: expanses[index])),
    );
  }
}
