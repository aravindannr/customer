import 'package:flutter/material.dart';

//trial page for showing selected itemcollection
class ItemCollectionPage extends StatefulWidget {
  const ItemCollectionPage({super.key});

  @override
  State<ItemCollectionPage> createState() => _ItemCollectionPageState();
}

class _ItemCollectionPageState extends State<ItemCollectionPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_back),
                  ),
                ],
              ),
              Expanded(
                child: GridView.builder(
                  itemCount: 8,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width * 1 / 2,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/churidhar test4.jpeg',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                                colors: [
                                  Colors.grey.shade300,
                                  Colors.grey.shade300.withOpacity(0.01),
                                ],
                              ),
                            ),
                            width: double.infinity,
                            height: double.infinity,
                            child: const Align(
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                "This is churithar",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
