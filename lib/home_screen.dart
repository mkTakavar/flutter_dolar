import 'package:dolar/Model/Currency.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:developer' as developer;
import 'package:intl/intl.dart';

import 'header.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Currency> currency = [];

  Future getResponse(BuildContext context) async {
    var url =
        "https://sasansafari.com/flutter/api.php?access_key=flutter123456";

    var value = await http.get(Uri.parse(url));

    if (currency.isEmpty) {
      if (value.statusCode == 200) {
        _showSnackBar(context, "بروز رسانی با موفقیت انجام شد");

        List jsonList = convert.jsonDecode(value.body);

        if (jsonList.isNotEmpty) {
          for (int i = 0; i < jsonList.length; i++) {
            setState(() {
              currency.add(Currency(
                  id: jsonList[i]["id"],
                  title: jsonList[i]["title"],
                  price: jsonList[i]["price"],
                  changes: jsonList[i]["changes"],
                  status: jsonList[i]["status"]));
            });
          }
        }
      }
    }
    return value;
  }

  @override
  void initState() {
    super.initState();
    getResponse(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(55), child: Header()),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Row(
                children: [
                  Image.asset("assets/images/q.jpeg"),
                  const SizedBox(
                    width: 8,
                  ),
                  Text("نرخ ارز آزاد چیست؟",
                      style: Theme.of(context).textTheme.headlineLarge),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Text(
                  "نرخ ارز در معاملات نقدی و رایج روزانه است معاملات نقدی معاملاتی هستند که خریدار و فروشنده به محض انجام معامله ارز و ریال را با هم تبادل می کند",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 6, 0, 0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color.fromARGB(255, 130, 130, 130)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'نرخ آزاد ارز',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        ' قیمت',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Text(
                        'تغییر',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
              ),
              // List View
              SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 2,
                child: ListFutureBuilder(context),
              ),
              // Update Button Box
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 16,
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 232, 232, 232),
                    borderRadius: BorderRadius.circular(1000)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Update btn
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 16,
                      child: TextButton.icon(
                        onPressed: () {
                          currency.clear();
                          ListFutureBuilder(context);
                        },
                        icon: const Icon(
                          CupertinoIcons.refresh_thin,
                          color: Colors.teal,
                        ),
                        label: Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                          child: Text(
                            "بروز رسانی",
                            style: Theme.of(context).textTheme.headlineLarge,
                          ),
                        ),
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.grey[400]),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(1000)))),
                      ),
                    ),
                    Text(
                      "آخرین بروز رسانی ${_getTime()}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      width: 5,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  FutureBuilder<dynamic> ListFutureBuilder(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: currency.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                    child: MyItem(
                      currency: currency,
                      index: index,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  if (index % 10 == 0) {
                    return const Padding(
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 0),
                      child: Add(),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
      future: getResponse(context),
    );
  }

  String _getTime() {
    DateTime now = DateTime.now();

    return getFarsiNumber(DateFormat('kk:mm:ss').format(now));
  }
}

void _showSnackBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: Theme.of(context).textTheme.headlineLarge,
    ),
    backgroundColor: Colors.teal,
  ));
}

class MyItem extends StatelessWidget {
  int index;
  List<Currency> currency;
  MyItem({
    required this.index,
    required this.currency,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.9),
          borderRadius: BorderRadius.circular(30),
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 1.0, color: Colors.grey)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            currency[index].title!,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            getFarsiNumber(currency[index].price.toString()),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            getFarsiNumber(currency[index].changes.toString()),
            style: currency[index].status == 'n'
                ? Theme.of(context).textTheme.headlineSmall
                : Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}

class Add extends StatelessWidget {
  const Add({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(30),
          boxShadow: const <BoxShadow>[
            BoxShadow(blurRadius: 1.0, color: Colors.grey)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "تبلیغات",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}

String getFarsiNumber(String number) {
  const en = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const fa = ['۰', '‍۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹'];

  en.forEach((element) {
    number = number.replaceAll(element, fa[en.indexOf(element)]);
  });
  return number;
}
