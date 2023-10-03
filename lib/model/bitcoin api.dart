import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

String selectedCurrency = 'AUD';

Future getCoinData(String selectedCurrency) async {
  Map<String, String> cryptoPrices = {};
  for (String crypto in cryptoList) {
    var url = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$crypto/$selectedCurrency?apikey=C04D5F23-5B9A-43ED-A984-62D6D20F4EA9');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      var coinData = jsonDecode(response.body);
      double price = coinData['rate'];
      cryptoPrices[crypto] = price.toStringAsFixed(0);
    } else {
      print("${response.statusCode}for coin");
      throw 'An error occured';
    }
  }
  return cryptoPrices;
}

class DisplayCurrenciesScreen extends StatefulWidget {
  const DisplayCurrenciesScreen({super.key});

  @override
  State<DisplayCurrenciesScreen> createState() =>
      _DisplayCurrenciesScreenState();
}

class _DisplayCurrenciesScreenState extends State<DisplayCurrenciesScreen> {
  DropdownButton<String> andriodDropdown() {
    List<DropdownMenuItem<String>> dropItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropItems.add(newItem);
    }

    return DropdownButton<String>(
        value: selectedCurrency,
        items: dropItems,
        onChanged: (value) {
          setState(() {
            selectedCurrency = value!;
          });
        });
  }

  CupertinoPicker iosPicker() {
    List<Text> items = [];
    for (String currency in currenciesList) {
      var newItem = Text(currency);
      items.add(newItem);
    }
    return CupertinoPicker(
        itemExtent: 32,
        onSelectedItemChanged: (selectedIndex) {
          selectedCurrency = currenciesList[selectedIndex];
        },
        children: items);
  }

  Map<String, String> CryptoPrices1 = {};
  bool isWaiting = false;
  getData1() async {
    isWaiting = true;
    try {
      var newCryptoMap = await getCoinData(selectedCurrency);

      isWaiting = false;
      if (newCryptoMap != null) {
        setState(() {
          CryptoPrices1 = newCryptoMap;
        });
      }
    } catch (error) {
      debugPrint('error');
      rethrow;
    }
  }

  @override
  void initState() {
    getData1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          BuildCard(
            labelText: 'BTC',
            labelCurrency: selectedCurrency,
            price: isWaiting ? '?' : CryptoPrices1['BTC'].toString(),
          ),
          BuildCard(
            labelText: 'ETH',
            labelCurrency: selectedCurrency,
            price: isWaiting ? '?' : CryptoPrices1['ETH'].toString(),
          ),
          BuildCard(
            labelText: 'LTC',
            labelCurrency: selectedCurrency,
            price: isWaiting ? '?' : CryptoPrices1['LTC'].toString(),
          ),
          Container(
              color: Colors.blueAccent,
              child: Center(child: andriodDropdown())),
          Container(color: Colors.blueGrey, child: Center(child: iosPicker())),
        ],
      ),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    super.key,
    required this.labelText,
    required this.labelCurrency,
    required this.price,
  });

  final String labelText;
  final String labelCurrency;
  final String price;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      elevation: 10,
      child: Text('1 $labelText = $price$labelCurrency'),
    );
  }
}
