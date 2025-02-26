import '../../expense/model/expenseType.dart';
import '../../expense/model/incomeType.dart';
import '../model/transaction.dart';

// Extended dummyExpensesByDay with December 2024 and January 2025
List<TransactionByDay> dummyExpensesByDay = [
  // February 2025 (existing data)
  TransactionByDay(
    date: DateTime(2025, 2, 24),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 120000, note: "Dinner with friends"),
      Transaction(type: ExpenseType.move, amount: 10000, note: "Taxi fare"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 23),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 450000, note: "Dentist appointment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 22),
    transactions: [
      Transaction(type: ExpenseType.entertain, amount: 80000, note: "Concert ticket"),
      Transaction(type: ExpenseType.clothes, amount: 300000, note: "New jacket"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 21),
    transactions: [
      Transaction(type: ExpenseType.billElectric, amount: 60000, note: "Electricity bill"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 150000, note: "Lunch at restaurant"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 19),
    transactions: [
      Transaction(type: ExpenseType.pet, amount: 85000, note: "Cat litter"),
      Transaction(type: ExpenseType.gift, amount: 50000, note: "Friend’s wedding gift"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 18),
    transactions: [
      Transaction(type: ExpenseType.education, amount: 70000, note: "E-book purchase"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 17),
    transactions: [
      Transaction(type: ExpenseType.billInternet, amount: 30000, note: "Monthly internet"),
      Transaction(type: ExpenseType.eat, amount: 90000, note: "Sushi takeout"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 16),
    transactions: [
      Transaction(type: ExpenseType.move, amount: 20000, note: "Train ticket"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 15),
    transactions: [
      Transaction(type: ExpenseType.clothes, amount: 180000, note: "Winter boots"),
      Transaction(type: ExpenseType.entertain, amount: 150000, note: "Movie night"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 14),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 250000, note: "Valentine’s dinner"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 13),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 200000, note: "Pharmacy meds"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 12),
    transactions: [
      Transaction(type: ExpenseType.billElectric, amount: 55000, note: "Utility bill"),
      Transaction(type: ExpenseType.pet, amount: 120000, note: "Vet visit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 11),
    transactions: [
      Transaction(type: ExpenseType.gift, amount: 30000, note: "Anniversary present"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 10),
    transactions: [
      Transaction(type: ExpenseType.education, amount: 100000, note: "Online workshop"),
      Transaction(type: ExpenseType.eat, amount: 60000, note: "Pizza delivery"),
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
    date: DateTime(2025, 2, 8),
    transactions: [
      Transaction(type: ExpenseType.entertain, amount: 95000, note: "Game subscription"),
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

  // January 2025 (new data)
  TransactionByDay(
    date: DateTime(2025, 1, 30),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 130000, note: "Dinner party"),
      Transaction(type: ExpenseType.move, amount: 15000, note: "Subway fare"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 27),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 250000, note: "Eye checkup"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 24),
    transactions: [
      Transaction(type: ExpenseType.entertain, amount: 70000, note: "Theater tickets"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 21),
    transactions: [
      Transaction(type: ExpenseType.billElectric, amount: 65000, note: "January electric bill"),
      Transaction(type: ExpenseType.clothes, amount: 200000, note: "Winter coat"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 18),
    transactions: [
      Transaction(type: ExpenseType.pet, amount: 90000, note: "Pet grooming"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 15),
    transactions: [
      Transaction(type: ExpenseType.education, amount: 80000, note: "Course materials"),
      Transaction(type: ExpenseType.gift, amount: 45000, note: "New Year gift"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 12),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 110000, note: "Lunch with colleagues"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 9),
    transactions: [
      Transaction(type: ExpenseType.billInternet, amount: 35000, note: "Internet renewal"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 6),
    transactions: [
      Transaction(type: ExpenseType.move, amount: 12000, note: "Bus ticket"),
      Transaction(type: ExpenseType.entertain, amount: 60000, note: "Streaming subscription"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 3),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 180000, note: "Medical checkup"),
    ],
  ),

  // December 2024 (new data)
  TransactionByDay(
    date: DateTime(2024, 12, 31),
    transactions: [
      Transaction(type: ExpenseType.eat, amount: 200000, note: "New Year’s Eve dinner"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 28),
    transactions: [
      Transaction(type: ExpenseType.gift, amount: 150000, note: "Holiday gift"),
      Transaction(type: ExpenseType.clothes, amount: 300000, note: "Winter sweater"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 25),
    transactions: [
      Transaction(type: ExpenseType.entertain, amount: 120000, note: "Christmas movie"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 22),
    transactions: [
      Transaction(type: ExpenseType.billElectric, amount: 70000, note: "December electric bill"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 19),
    transactions: [
      Transaction(type: ExpenseType.pet, amount: 75000, note: "Pet supplies"),
      Transaction(type: ExpenseType.eat, amount: 95000, note: "Dinner out"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 16),
    transactions: [
      Transaction(type: ExpenseType.healthCare, amount: 220000, note: "Flu shot"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 13),
    transactions: [
      Transaction(type: ExpenseType.move, amount: 18000, note: "Train fare"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 10),
    transactions: [
      Transaction(type: ExpenseType.education, amount: 90000, note: "Online seminar"),
      Transaction(type: ExpenseType.billInternet, amount: 32000, note: "Internet bill"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 7),
    transactions: [
      Transaction(type: ExpenseType.entertain, amount: 85000, note: "Game purchase"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 4),
    transactions: [
      Transaction(type: ExpenseType.clothes, amount: 280000, note: "Holiday outfit"),
    ],
  ),
];

// Extended dummyIncomesByDay with December 2024 and January 2025
List<TransactionByDay> dummyIncomesByDay = [
  // February 2025 (existing data)
  TransactionByDay(
    date: DateTime(2025, 2, 25),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 700000, note: "Side hustle payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 24),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5200000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 23),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1800000, note: "Crypto gains"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 22),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 950000, note: "Consulting fee"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 21),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5100000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 20),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 19),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2500000, note: "Real estate profit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 18),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 400000, note: "Referral bonus"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 17),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 4900000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 16),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 3000000, note: "Stock sale"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 15),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 650000, note: "Freelance gig"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 14),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 13),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1200000, note: "Bond interest"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 12),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 850000, note: "Project bonus"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 11),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 4800000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 10),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2200000, note: "Dividend payout"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 9),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 500000, note: "Cashback rewards"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 8),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 800000, note: "Freelance project payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 7),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5100000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 2, 6),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),

  // January 2025 (new data)
  TransactionByDay(
    date: DateTime(2025, 1, 31),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5100000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 28),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2000000, note: "Stock gains"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 25),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 600000, note: "Bonus payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 22),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 4900000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 19),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1500000, note: "Dividend income"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 16),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 750000, note: "Freelance work"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 13),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 10),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1800000, note: "Crypto profit"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 7),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 450000, note: "Referral bonus"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2025, 1, 4),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5200000, note: "Monthly salary"),
    ],
  ),

  // December 2024 (new data)
  TransactionByDay(
    date: DateTime(2024, 12, 30),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5000000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 27),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2500000, note: "Real estate sale"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 24),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 900000, note: "Holiday bonus"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 21),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 4800000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 18),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 1700000, note: "Stock dividends"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 15),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 600000, note: "Consulting fee"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 12),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 5100000, note: "Monthly salary"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 9),
    transactions: [
      Transaction(type: IncomeType.invest, amount: 2000000, note: "Bond payout"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 6),
    transactions: [
      Transaction(type: IncomeType.extra, amount: 700000, note: "Freelance payment"),
    ],
  ),
  TransactionByDay(
    date: DateTime(2024, 12, 3),
    transactions: [
      Transaction(type: IncomeType.salary, amount: 4900000, note: "Monthly salary"),
    ],
  ),
];