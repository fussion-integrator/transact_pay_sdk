import 'package:flutter/material.dart';
import 'package:transact_pay_sdk/src/common_widget/app_button.dart';
import 'package:transact_pay_sdk/src/common_widget/app_card_type_selection.dart';
import 'package:transact_pay_sdk/src/common_widget/app_header.dart';
import 'package:transact_pay_sdk/src/constant/app_colors.dart';
import 'package:transact_pay_sdk/src/constant/app_images.dart';
import 'package:transact_pay_sdk/src/ui/popup_dialog/card_payment_progress_popup.dart';

class SavedCardPaymentScreen extends StatefulWidget {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? amount;
  final String? description;

  const SavedCardPaymentScreen(
      {super.key,
      this.email,
      this.firstName,
      this.lastName,
      this.amount,
      this.phone,
      this.description});

  @override
  State<SavedCardPaymentScreen> createState() => _SavedCardPaymentScreenState();
}

class _SavedCardPaymentScreenState extends State<SavedCardPaymentScreen> {
  // final TextEditingController _cardNumberController = TextEditingController();
  // final TextEditingController _expiryDateController = TextEditingController();
  // final TextEditingController _cvvController = TextEditingController();

  bool isValid = false;

  // void _validateForm() {
  //   setState(() {
  //     isValid = _formKey.currentState?.validate() ?? false;
  //   });
  // }

  // To track the selected index
  int _selectedIndex = -1;

  // Callback to handle selection change
  void _onPaymentTypeSelected(int index) {
    setState(() {
      // Set selected index to the tapped index
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: AppHeader(),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.arrow_back,
                                color: AppColors.primaryColor),
                            Text(
                              " Back",
                              style: TextStyle(color: AppColors.primaryColor),
                            )
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            "${widget.email}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "NGN ${widget.amount} ",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 16),
                              ),
                              Icon(
                                Icons.copy_all,
                                color: AppColors.primaryColor,
                              )
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Divider(thickness: 0.5),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Pay with saved card",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  // The ListView displaying payment options
                  ListView(
                    padding: const EdgeInsets.all(8.0),
                    shrinkWrap: true,
                    children: [
                      AppCardTypeSelection(
                        cardType: 'Mastercard',
                        pan: "5901xxxxxxxxxx2340",
                        imageUrl: AppImages.mastercard,
                        isSelected: _selectedIndex == 0,
                        onChanged: (isSelected) {
                          if (isSelected) {
                            _onPaymentTypeSelected(0);
                          } else {
                            _onPaymentTypeSelected(-1);
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      AppCardTypeSelection(
                        cardType: 'Mastercard',
                        pan: "5902xxxxxxxxxx0032",
                        imageUrl: AppImages.mastercard,
                        isSelected: _selectedIndex == 1,
                        onChanged: (isSelected) {
                          if (isSelected) {
                            _onPaymentTypeSelected(1);
                          } else {
                            _onPaymentTypeSelected(-1);
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 50),
                  AppButton(
                    onPressed: _selectedIndex > -1
                        ? () {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  surfaceTintColor: Colors.white,
                                  child: IntrinsicHeight(
                                    child: IntrinsicWidth(
                                      child: const CardPaymentProgressPopup(),
                                    ),
                                  ),
                                );
                              },
                            );
                          }
                        : null,
                    text: "Pay NGN ${widget.amount}",
                  ),
                  const SizedBox(height: 30),
                  Center(child: Image.asset(AppImages.footer)),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
