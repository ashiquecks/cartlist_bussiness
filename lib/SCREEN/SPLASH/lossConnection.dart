import 'package:flutter/material.dart';

class LossConnection extends StatelessWidget {
  const LossConnection({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 1.2,
            child: Image.asset('assets/images/no_internet.png'),
          ),
        ),
      ),
    );
  }
}
