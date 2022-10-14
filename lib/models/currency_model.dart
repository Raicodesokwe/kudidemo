class CurrencyModel {
  final String flag;
  final String country;
  CurrencyModel({required this.country, required this.flag});
}

List<CurrencyModel> currencyList = [
  CurrencyModel(country: 'Australian Dollar', flag: 'aus.jpg'),
  CurrencyModel(country: 'Euro', flag: 'euro.png'),
  CurrencyModel(country: 'Japanese Yen', flag: 'japan.png'),
  CurrencyModel(country: 'South African\nRand', flag: 'sa.jpg'),
  CurrencyModel(country: 'US Dollar', flag: 'usflag.jpg'),
  CurrencyModel(country: 'UK Pound', flag: 'uk.png'),
  CurrencyModel(country: 'Kenya Shilling', flag: 'kenya.jpg'),
  CurrencyModel(country: 'Indian Rupee', flag: 'india.jpg'),
  CurrencyModel(country: 'Pakistan Rupee', flag: 'pakistan.jpg'),
  CurrencyModel(country: 'UAE Dirham', flag: 'uae.png'),
];
