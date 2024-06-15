import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:teresa_customer/screen/settings/payment_history/payment_details.dart';

class MyPaymentOrdersPage extends StatefulWidget {
  const MyPaymentOrdersPage({super.key});

  @override
  State<MyPaymentOrdersPage> createState() => _MyPaymentOrdersPageState();
}

class _MyPaymentOrdersPageState extends State<MyPaymentOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'My Order Payments',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 15,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ListView.separated(
                    separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                    itemCount: 7,
                    itemBuilder: (context, index) {
                      return OrderCard(
                        orderNumber: 'ACWE354FCW',
                        date: '20-Dec-2019, 3:00 PM',
                        status: 'Partially Paid',
                        image: 'assets/images/latest4.jpg',
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const PaymentDetails(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final String orderNumber;
  final String date;
  final String status;
  final String image;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.image,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(15),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Image.asset(
                    fit: BoxFit.fitHeight,
                    height: 100,
                    'assets/images/latest4.jpg',
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          'Order#: $orderNumber',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          date,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Rs 1000.00', style: TextStyle(
                              fontSize: 12,
                            )
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(color: status.contains('Paid')
                                  ? Colors.green
                                  : Colors.orange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                status,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
