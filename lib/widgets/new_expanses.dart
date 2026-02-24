import 'dart:developer';

import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:expenses_app/Models/expanses.dart';

class NewExpanses extends StatefulWidget {
  NewExpanses({super.key, required this.onAddExpanses});
  final void Function(Expansesmodel) onAddExpanses;
  @override
  State<NewExpanses> createState() => _NewExpansesState();
}

class _NewExpansesState extends State<NewExpanses> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  final formatter = DateFormat();
  Category _selectedCategory = Category.travel;
  DateTime? _selectedDate;
  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titlecontroller,
            maxLength: 50,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountcontroller,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    prefixText: '\$',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Data Selected'
                            : formatter.format(_selectedDate!),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final firstDate = DateTime(
                          now.year - 1,
                          now.month,
                          now.day,
                        );
                        // final lastDate = DateTime(
                        //   now.year + 1,
                        //   now.month,
                        //   now.day,
                        // );
                        final DateTime? pickdata = await showDatePicker(
                          context: context,
                          initialDate: now,
                          firstDate: firstDate,
                          lastDate: now,
                        );
                        setState(() {
                          _selectedDate = pickdata;
                        });
                      },
                      icon: Icon(Icons.calendar_month),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              DropdownButton(
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.name.toUpperCase()),
                  );
                }).toList(),
                value: _selectedCategory,
                onChanged: (newvalue) {
                  setState(() {
                    _selectedCategory = newvalue as Category;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final double? enteredAmount = double.tryParse(
                    _amountcontroller.text,
                  );
                  final bool amountisvalid =
                      enteredAmount == null || enteredAmount <= 0;

                  if (_titlecontroller.text.trim().isEmpty ||
                      amountisvalid ||
                      _selectedDate == null) {
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: Text('Invalid Input'),
                        content: Text(
                          'Please enter a valid title, amount and date',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                            child: Text('Okay'),
                          ),
                        ],
                      ),
                    );
                  } else {
                    widget.onAddExpanses(
                      Expansesmodel(
                        title: _titlecontroller.text,
                        amount: enteredAmount,
                        date: _selectedDate!,
                        category: _selectedCategory,
                      ),
                    );
                    Navigator.pop(context);
                  }
                },
                child: Text('Save Expanses'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
