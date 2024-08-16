import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nusainfra/controllers/expense_controller.dart';
import 'package:nusainfra/models/expense.dart';

class ExpenseScreen extends StatelessWidget {
  final ExpenseController expenseController = Get.find<ExpenseController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expenses'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showExpenseForm(context);
            },
          ),
        ],
      ),
      body: Obx(
        () {
          if (expenseController.expenses.isEmpty) {
            return Center(child: Text('No expenses available.'));
          } else {
            return ListView.builder(
              itemCount: expenseController.expenses.length,
              itemBuilder: (context, index) {
                final expense = expenseController.expenses[index];
                return ListTile(
                  title: Text(expense.name),
                  subtitle: Text(
                      'Amount: ${expense.amount} - ${DateFormat.yMMMd().format(expense.time)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showExpenseForm(context, expense: expense);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _confirmDelete(context, expense.id);
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  void _showExpenseForm(BuildContext context, {Expense? expense}) {
    final TextEditingController nameController =
        TextEditingController(text: expense?.name ?? '');
    final TextEditingController amountController =
        TextEditingController(text: expense?.amount.toString() ?? '');
    DateTime selectedDate = expense?.time ?? DateTime.now();
    int selectedCategoryId = expense?.categoryId ?? 1; // Default category
    int selectedWalletId =
        1; 

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(expense == null ? 'Add Expense' : 'Edit Expense'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Expense Name'),
              ),
              TextField(
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              Text('Select Date:'),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    selectedDate = pickedDate;
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.calendar_today),
                      SizedBox(width: 8),
                      Text(DateFormat.yMMMd().format(selectedDate)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (expense == null) {
                  expenseController.createExpense(
                    selectedWalletId,
                    nameController.text,
                    selectedCategoryId,
                    double.parse(amountController.text),
                    selectedDate,
                  );
                } else {
                  expenseController.updateExpense(
                    expense.id,
                    nameController.text,
                    selectedCategoryId,
                    double.parse(amountController.text),
                    selectedDate,
                  );
                }
                Get.back();
              },
              child: Text(expense == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDelete(BuildContext context, int expenseId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Delete Expense'),
          content: Text('Are you sure you want to delete this expense?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                expenseController.deleteExpense(expenseId);
                Get.back();
              },
              child: Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
