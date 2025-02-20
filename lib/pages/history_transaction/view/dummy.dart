import '../../expense/model/expenseType.dart';
import '../../expense/model/incomeType.dart';
import '../model/transaction.dart';

List<TransactionByDay> dummyExpensesByDay = [
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(expenseType: ExpenseType.eat, amount: 150000, note: "Lunch at restaurant"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 9),
    transactions: [
      Transaction(expenseType: ExpenseType.billElectric, amount: 50000, note: "Electric bill"),
      Transaction(expenseType: ExpenseType.move, amount: 7500, note: "Bus fare"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 7),
    transactions: [
      Transaction(expenseType: ExpenseType.clothes, amount: 250000, note: "Bought a new T-shirt"),
      Transaction(expenseType: ExpenseType.entertain, amount: 120000, note: "Cinema ticket"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 6),
    transactions: [
      Transaction(expenseType: ExpenseType.healthCare, amount: 300000, note: "Doctor visit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 5),
    transactions: [
      Transaction(expenseType: ExpenseType.eat, amount: 20000, note: "Dinner at steakhouse"),
      Transaction(expenseType: ExpenseType.pet, amount: 100000, note: "Dog food"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 3),
    transactions: [
      Transaction(expenseType: ExpenseType.billInternet, amount: 25000, note: "Internet bill"),
      Transaction(expenseType: ExpenseType.eat, amount: 180000, note: "Coffee and breakfast"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 1),
    transactions: [
      Transaction(expenseType: ExpenseType.education, amount: 45000, note: "Online course fee"),
      Transaction(expenseType: ExpenseType.gift, amount: 20000, note: "Birthday gift"),
    ],
  ),
];

List<TransactionByDay> dummyIncomesByDay = [
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(incomeType: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 8),
    transactions: [
      Transaction(incomeType: IncomeType.extra, amount: 800000, note: "Freelance project payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 6),
    transactions: [
      Transaction(incomeType: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 4),
    transactions: [
      Transaction(incomeType: IncomeType.invest, amount: 2000000, note: "Stock market profit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 2),
    transactions: [
      Transaction(incomeType: IncomeType.extra, amount: 600000, note: "Bonus at work"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 24),
    transactions: [
      Transaction(incomeType: IncomeType.invest, amount: 1500000, note: "Dividend payout"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 22),
    transactions: [
      Transaction(incomeType: IncomeType.extra, amount: 900000, note: "Freelance payment"),
    ],
  ),
];
