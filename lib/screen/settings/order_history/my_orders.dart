import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'order_details.dart';

class MyOrdersPage extends StatefulWidget {
  const MyOrdersPage({super.key});

  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'My Orders',
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
                        orderNumber: '999012',
                        date: '20-Dec-2019, 3:00 PM',
                        status: 'Arriving Today',
                        rating: 0,
                        image: 'assets/images/latest4.jpg',
                        onTap: () {
                          Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => const OrderDetails(),
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
  final int rating;
  final String image;
  final VoidCallback onTap;

  const OrderCard({
    super.key,
    required this.orderNumber,
    required this.date,
    required this.status,
    required this.rating,
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
                    padding: const EdgeInsets.symmetric(horizontal: 25),
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
                        Text(
                          status,
                          style: TextStyle(
                            color: status.contains('Delivered')
                                ? Colors.orange
                                : Colors.green,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Row(
                              children: List.generate(
                                5,
                                (index) {
                                  return Icon(
                                    index < rating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 16,
                                  );
                                },
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                              size: 16,
                            )
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
