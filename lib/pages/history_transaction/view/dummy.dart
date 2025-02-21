import '../../expense/model/expenseType.dart';
import '../../expense/model/incomeType.dart';
import '../model/transaction.dart';

List<TransactionByDay> dummyExpensesByDay = [
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 150000, note: "Lunch at restaurant"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 9),
    transactions: [
      Transaction(type: ExpenseType.billElectric, amount: 50000, note: "Electric bill"),
      Transaction(type: ExpenseType.move, amount: 7500, note: "Bus fare"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 7),
    transactions: [
      Transaction(type: ExpenseType.clothes, amount: 250000, note: "Bought a new T-shirt"),
      Transaction(type: ExpenseType.entertain, amount: 120000, note: "Cinema ticket"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 6),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 300000, note: "Doctor visit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 5),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 20000, note: "Dinner at steakhouse"),
      Transaction(type: ExpenseType.pet, amount: 100000, note: "Dog food"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 3),
    transactions: [
      Transaction(type: ExpenseType.billInternet, amount: 25000, note: "Internet bill"),
      Transaction(type: ExpenseType.eat, amount: 180000, note: "Coffee and breakfast"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 1),
    transactions: [
      Transaction(type: ExpenseType.education, amount: 45000, note: "Online course fee"),
      Transaction(type: ExpenseType.gift, amount: 20000, note: "Birthday gift"),
    ],
  ),
];

List<TransactionByDay> dummyIncomesByDay = [
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 8),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 800000, note: "Freelance project payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 6),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 4),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2000000, note: "Stock market profit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 2),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 600000, note: "Bonus at work"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 24),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1500000, note: "Dividend payout"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 22),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 900000, note: "Freelance payment"),
    ],
  ),
];
