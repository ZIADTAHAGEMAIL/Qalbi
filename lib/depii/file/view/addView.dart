import 'package:flutter/material.dart';
import 'package:islamicapp/depii/file/data/ExpenseModel.dart';

import 'package:islamicapp/depii/file/widgets/textField.dart';

import '../data/httpExpense.dart';

class Addview extends StatefulWidget {
  final ExpenseModel? expense;
  const Addview({super.key, this.expense});

  @override
  State<Addview> createState() => _AddviewState();
}

class _AddviewState extends State<Addview> {
  final _fromkey = GlobalKey<FormState>();

  double? price;
  String? desc;
  DateTime? selectedDate;

  late TextEditingController priceController = TextEditingController();
  late TextEditingController descController = TextEditingController();
  Httpexpense httpExpense = Httpexpense();

  @override
  void initState() {
    super.initState();

    if (widget.expense == null) {
    } else {
      priceController.text = widget.expense!.Price.toString();
      descController.text = widget.expense!.Description;
      selectedDate = DateTime.parse(widget.expense!.date);
    }
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    final e = widget.expense;
    return Scaffold(
      appBar: AppBar(title: Text(e == null ? "إضافة مصروف" : "حدث الان")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _fromkey,
          child: SingleChildScrollView(
            child: Column(
              spacing: 20,
              children: [
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  onPressed: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2025),
                      lastDate: DateTime(2027),
                    );
                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                  icon: const Icon(Icons.calendar_month),
                  label: Text(
                    selectedDate == null
                        ? 'اختر التاريخ'
                        : 'التاريخ: ${selectedDate!.day}/${selectedDate!.month
                    }/${selectedDate!.year}',
                  ),
                ),

                Textfield(
                  label: 'Price',
                  controller: priceController,
                  onSaved: (val) {
                    price = double.tryParse(val ?? '0');
                  },
                ),

                Textfield(
                  label: 'Description',
                  controller: descController,
                  onSaved: (val) {
                    desc = val;
                  },
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (selectedDate == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('الرجاء اختيار التاريخ أولاً'),
                        ),
                      );
                      return;
                    }

                    if (_fromkey.currentState!.validate()) {
                      _fromkey.currentState!.save();
                      if (e == null) {
                        await httpExpense.add('/expenses', ExpenseModel(

                          date: selectedDate.toString(),
                          Price: price!,
                          Description: desc!,
                        ),);
                        // await _expenseRepo.add(
                        //   ExpenseModel(
                        //
                        //     date: selectedDate.toString(),
                        //     Price: price!,
                        //     Description: desc!,
                        //   ),
                        // );
                      } else {
                        await  httpExpense.update('/expenses',  ExpenseModel(
                          id:  widget.expense?.id,
                          date: selectedDate.toString(),
                          Price: price!,
                          Description: desc!,
                        ),);
                        // await _expenseRepo.update(
                        //   ExpenseModel(
                        //     id:  widget.expense?.id,
                        //     date: selectedDate.toString(),
                        //     Price: price!,
                        //     Description: desc!,
                        //   ),
                        // );
                      }
                      if (mounted) Navigator.pop(context);
                    }
                  },
                  child: Text(e == null ? "إضافة مصروف" : "حدث الان"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
