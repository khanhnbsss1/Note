// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Edit`
  String get edit {
    return Intl.message('Edit', name: 'edit', desc: '', args: []);
  }

  /// `Title`
  String get title {
    return Intl.message('Title', name: 'title', desc: '', args: []);
  }

  /// `Enter your title`
  String get enter_your_title {
    return Intl.message(
      'Enter your title',
      name: 'enter_your_title',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message('Date', name: 'date', desc: '', args: []);
  }

  /// `Pick your date`
  String get pick_your_date {
    return Intl.message(
      'Pick your date',
      name: 'pick_your_date',
      desc: '',
      args: [],
    );
  }

  /// `Content`
  String get content {
    return Intl.message('Content', name: 'content', desc: '', args: []);
  }

  /// `Enter your content`
  String get enter_your_content {
    return Intl.message(
      'Enter your content',
      name: 'enter_your_content',
      desc: '',
      args: [],
    );
  }

  /// `No event`
  String get no_event {
    return Intl.message('No event', name: 'no_event', desc: '', args: []);
  }

  /// `Income`
  String get income {
    return Intl.message('Income', name: 'income', desc: '', args: []);
  }

  /// `Expense`
  String get expense {
    return Intl.message('Expense', name: 'expense', desc: '', args: []);
  }

  /// `Enter Amount`
  String get enter_amount {
    return Intl.message(
      'Enter Amount',
      name: 'enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `Please enter the amount`
  String get please_enter_amount {
    return Intl.message(
      'Please enter the amount',
      name: 'please_enter_amount',
      desc: '',
      args: [],
    );
  }

  /// `The amount must be greater than 1000`
  String get enter_amount_warning {
    return Intl.message(
      'The amount must be greater than 1000',
      name: 'enter_amount_warning',
      desc: '',
      args: [],
    );
  }

  /// `Enter note`
  String get enter_note {
    return Intl.message('Enter note', name: 'enter_note', desc: '', args: []);
  }

  /// `Ordered by`
  String get ordered_by {
    return Intl.message('Ordered by', name: 'ordered_by', desc: '', args: []);
  }

  /// `Total expense :`
  String get total_expense {
    return Intl.message(
      'Total expense :',
      name: 'total_expense',
      desc: '',
      args: [],
    );
  }

  /// `Total income :`
  String get total_income {
    return Intl.message(
      'Total income :',
      name: 'total_income',
      desc: '',
      args: [],
    );
  }

  /// `Time :`
  String get time {
    return Intl.message('Time :', name: 'time', desc: '', args: []);
  }

  /// `Remaining`
  String get remain {
    return Intl.message('Remaining', name: 'remain', desc: '', args: []);
  }

  /// `All notes`
  String get all_notes {
    return Intl.message('All notes', name: 'all_notes', desc: '', args: []);
  }

  /// `Done`
  String get done {
    return Intl.message('Done', name: 'done', desc: '', args: []);
  }

  /// `Language`
  String get language {
    return Intl.message('Language', name: 'language', desc: '', args: []);
  }

  /// `Night mode`
  String get night_mode {
    return Intl.message('Night mode', name: 'night_mode', desc: '', args: []);
  }

  /// `Settings`
  String get setting {
    return Intl.message('Settings', name: 'setting', desc: '', args: []);
  }

  /// `Time to check transaction (Month)`
  String get Time_check_transaction {
    return Intl.message(
      'Time to check transaction (Month)',
      name: 'Time_check_transaction',
      desc: '',
      args: [],
    );
  }

  /// `Version`
  String get version {
    return Intl.message('Version', name: 'version', desc: '', args: []);
  }

  /// `Food & Drink`
  String get expenseType_eat {
    return Intl.message(
      'Food & Drink',
      name: 'expenseType_eat',
      desc: '',
      args: [],
    );
  }

  /// `Clothing`
  String get expenseType_clothes {
    return Intl.message(
      'Clothing',
      name: 'expenseType_clothes',
      desc: '',
      args: [],
    );
  }

  /// `Education`
  String get expenseType_education {
    return Intl.message(
      'Education',
      name: 'expenseType_education',
      desc: '',
      args: [],
    );
  }

  /// `Entertainment`
  String get expenseType_entertain {
    return Intl.message(
      'Entertainment',
      name: 'expenseType_entertain',
      desc: '',
      args: [],
    );
  }

  /// `Transportation`
  String get expenseType_move {
    return Intl.message(
      'Transportation',
      name: 'expenseType_move',
      desc: '',
      args: [],
    );
  }

  /// `Healthcare`
  String get expenseType_healthCare {
    return Intl.message(
      'Healthcare',
      name: 'expenseType_healthCare',
      desc: '',
      args: [],
    );
  }

  /// `Pets`
  String get expenseType_pet {
    return Intl.message('Pets', name: 'expenseType_pet', desc: '', args: []);
  }

  /// `Gifts`
  String get expenseType_gift {
    return Intl.message('Gifts', name: 'expenseType_gift', desc: '', args: []);
  }

  /// `Electricity Bill`
  String get expenseType_billElectric {
    return Intl.message(
      'Electricity Bill',
      name: 'expenseType_billElectric',
      desc: '',
      args: [],
    );
  }

  /// `Internet Bill`
  String get expenseType_billInternet {
    return Intl.message(
      'Internet Bill',
      name: 'expenseType_billInternet',
      desc: '',
      args: [],
    );
  }

  /// `Water Bill`
  String get expenseType_billWater {
    return Intl.message(
      'Water Bill',
      name: 'expenseType_billWater',
      desc: '',
      args: [],
    );
  }

  /// `Salary`
  String get incomeType_salary {
    return Intl.message(
      'Salary',
      name: 'incomeType_salary',
      desc: '',
      args: [],
    );
  }

  /// `Bonus`
  String get incomeType_extra {
    return Intl.message('Bonus', name: 'incomeType_extra', desc: '', args: []);
  }

  /// `Investment`
  String get incomeType_invest {
    return Intl.message(
      'Investment',
      name: 'incomeType_invest',
      desc: '',
      args: [],
    );
  }

  /// `Other Income`
  String get incomeType_other {
    return Intl.message(
      'Other Income',
      name: 'incomeType_other',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
