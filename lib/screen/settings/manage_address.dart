import 'package:flutter/material.dart';
import '../sign_in/credential_sign_in.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ProfileDetailsPageState();
}

class _ProfileDetailsPageState extends State<ManageAddressPage> {
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
          },
          backgroundColor: Colors.grey[800],
          child: const Icon(Icons.add,color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text(
            'Address Details',
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
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.black,
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Row(
                children: [
                  Hero(
                    tag: 'userImage',
                    child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(
                        'assets/images/user.png',
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Samuel L Jackson',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'UID1232',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Jackson Estate \n1234 New York  \nUSA',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey[800],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text(
                            'Primary Address',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.white,
                            size: 15,
                          ),
                          onPressed: () {
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
