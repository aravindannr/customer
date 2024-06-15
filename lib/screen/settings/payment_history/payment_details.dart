import 'package:flutter/material.dart';

import '../../../utils/custom_logo_spinner.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  List<StepModel> steps = [
    StepModel(
      title: 'Advance Payment',
      subtitle: 'We have received your advanced payment of \nRs. 400.00.',
      time: '10:04',
      isActive: true,
    ),
    StepModel(
      title: 'Partial Payment',
      subtitle: 'We have received your partial payment of \nRs. 300.00.',
      time: '10:06',
      isActive: true,
    ),
    StepModel(
      title: 'Final Payment',
      subtitle: 'Your final pending payment amount is \nRs. 300.00',
      time: '11:00',
      isActive: false,
    ),
  ];

  bool isLoading = true;

  _fnLoadingDelay() async {
    await Future.delayed(const Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    _fnLoadingDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Payment Details',
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
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Stack(
              children: [
                Image.asset(
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.3,
                  'assets/images/latest4.jpg',
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.1, 0.9],
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.black,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Wed, 12 Sep',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Order ID: #ACWE354FCW',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'Rs: 1000.00',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  child: isLoading
                      ? const CustomLogoSpinner(
                          oneSize: 10,
                          roundSize: 30,
                          color: Colors.white,
                        )
                      : CustomStepper(steps: steps),
                ),
                const Spacer(),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Delivery Address',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '  Home, Work & Other address',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '  House No: 1314, 2nd Floor, Sector 18,',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '  Gurugram, Haryana 122022, India. Near: Next to LIC',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StepModel {
  final String title;
  final String subtitle;
  final String time;
  final bool isActive;

  StepModel({
    required this.title,
    required this.subtitle,
    required this.time,
    this.isActive = false,
  });
}

class CustomStepper extends StatelessWidget {
  final List<StepModel> steps;

  const CustomStepper({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps
          .map((step) => StepWidget(
              step: step, buildLine: steps.indexOf(step) != steps.length - 1))
          .toList(),
    );
  }
}

class StepWidget extends StatelessWidget {
  final StepModel step;
  final bool buildLine;

  const StepWidget({
    super.key,
    required this.step,
    required this.buildLine,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              step.isActive ? Icons.check_circle : Icons.radio_button_unchecked,
              color: step.isActive ? Colors.green : Colors.grey,
            ),
            if (buildLine) _buildDottedLine(),
          ],
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                step.title,
                style: TextStyle(
                  fontWeight: step.isActive ? FontWeight.bold : FontWeight.w500,
                  color: step.isActive ? Colors.green : Colors.grey,
                ),
              ),
              Text(
                step.subtitle,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(
          step.time,
          style: const TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildDottedLine() {
    return Column(
      children: List.generate(
        8,
        (index) {
          return Container(
            width: 2,
            height: 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: step.isActive ? Colors.green : Colors.green.shade100,
            ),
            margin: const EdgeInsets.symmetric(vertical: 2),
          );
        },
      ),
    );
  }
}
