String currencyCodeFormatter(String currencyCodeJson) {
  switch (currencyCodeJson) {
    case 'BRL':
      return 'R\$';
    case 'USD':
      return 'US\$';
    case 'EUR':
      return '€';
    case 'GBP':
      return '£';
    case 'JPY':
      return '¥';
    case 'CAD':
      return 'C\$';
    case 'AUD':
      return 'A\$';
    case 'CNY':
      return '¥';
    default:
      return currencyCodeJson;
  }
}
