import 'package:flutter/cupertino.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logo,
            package: "transact_pay_sdk",
          ),
          const SizedBox(height: 10),
          const Text(
            "Merchant Name",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}
