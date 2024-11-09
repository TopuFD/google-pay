import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<PaymentConfiguration> googlePayConfigFuture;

  @override
  void initState() {
    super.initState();
    googlePayConfigFuture = PaymentConfiguration.fromAsset('gpay.json');
  }

  void onGooglePayResult(paymentResult) {
    debugPrint(
        "===========================================${paymentResult.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<PaymentConfiguration>(
      future: googlePayConfigFuture,
      builder: (context, snapshot) => snapshot.hasData
          ? Center(
              child: GooglePayButton(
                paymentConfiguration: snapshot.data!,
                paymentItems: const [
                  PaymentItem(
                    label: 'Total',
                    amount: '10.00',
                    status: PaymentItemStatus.final_price,
                  ),
                ],
                type: GooglePayButtonType.buy,
                margin: const EdgeInsets.only(top: 15.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : Container(
              height: 50,
              width: 200,
              color: Colors.blue,
            ),
    ));
  }
}
