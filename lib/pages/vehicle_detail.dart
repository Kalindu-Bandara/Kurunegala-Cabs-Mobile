import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:table_calendar/table_calendar.dart'; // Import the package
import 'package:sofrwere_project/services/constant.dart';
import 'package:sofrwere_project/services/database.dart';
import 'package:sofrwere_project/services/shared_pref.dart';
import 'package:sofrwere_project/widget/support_widget.dart';

class VehicleDetail extends StatefulWidget {
  final String image;
  final String name;
  final String detail;
  final String price;

  VehicleDetail({
    required this.detail,
    required this.image,
    required this.name,
    required this.price,
  });

  @override
  State<VehicleDetail> createState() => _VehicleDetailState();
}

class _VehicleDetailState extends State<VehicleDetail> {
  String? name, mail, image;
  DateTime? startDate, endDate;
  int totalAmount = 0;

  final Set<DateTime> _selectedDays = {}; // Track selected days

  @override
  void initState() {
    super.initState();
    _getSharedPref();
  }

  Future<void> _getSharedPref() async {
    name = await SharedPreferenceHelper().getUserName();
    mail = await SharedPreferenceHelper().getUserEmail();
    image = await SharedPreferenceHelper().getUserImage();
    setState(() {});
  }

  Map<String, dynamic>? paymentIntent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFfef5f1),
      body: Container(
        padding: const EdgeInsets.only(top: 50.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    left: 20,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.arrow_back_ios_outlined),
                      ),
                    ),
                  ),
                  Center(
                    child: Image.network(
                      widget.image,
                      height: 400,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: AppWidget.boldTextFeildStyle(),
                        ),
                        Text(
                          "\$" + widget.price,
                          style: TextStyle(
                            color: Color(0xFFfd6f3e),
                            fontSize: 23.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20.0),
                    Text(
                      "Details",
                      style: AppWidget.semiboldTextFeildStyle(),
                    ),
                    const SizedBox(height: 20),
                    Text(widget.detail),
                    const SizedBox(height: 30),

                    // Calendar for selecting dates
                    TableCalendar(
                      firstDay: DateTime.now(),
                      lastDay: DateTime(2101),
                      focusedDay: DateTime.now(),
                      selectedDayPredicate: (day) {
                        return _selectedDays.contains(day); // Highlight selected days
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        setState(() {
                          if (_selectedDays.contains(selectedDay)) {
                            _selectedDays.remove(selectedDay); // Deselect
                          } else {
                            _selectedDays.add(selectedDay); // Select
                          }
                          _calculateTotal();
                        });
                      },
                      calendarStyle: CalendarStyle(
                        selectedDecoration: BoxDecoration(
                          color: Colors.orange,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // Display Total Amount
                    Text("Total Amount: \$${totalAmount}"),

                    SizedBox(height: 60.0),
                    GestureDetector(
                      onTap: () {
                        if (totalAmount > 0) {
                          _makePayment(totalAmount.toString());
                        } else {
                          // Show an error or warning message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Please select valid dates to calculate total.")),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.0),
                        decoration: BoxDecoration(
                          color: Color(0xfffd6f3e),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: Text(
                            "Book Now",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateTotal() {
    if (_selectedDays.isNotEmpty) {
      totalAmount = _selectedDays.length * double.parse(widget.price).toInt(); // Calculate total
    } else {
      totalAmount = 0; // Reset if no days are selected
    }
  }

  Future<void> _makePayment(String amount) async {
    try {
      paymentIntent = await _createPaymentIntent(amount, 'LKR');
      await Stripe.instance.initPaymentSheet(paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent?['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'Kalindu',
      )).then((value) {});

      _displayPaymentSheet();
    } catch (e, s) {
      print('Exception: $e$s');
    }
  }

  Future<void> _displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // Convert selected days to a list of string dates
        List<String> selectedDaysList = _selectedDays
    .map((day) => day.toIso8601String().split('T').first) // Extract YYYY-MM-DD part
    .toList();

        Map<String, dynamic> orderInfoMap = {
          "Vehicle": widget.name,
          "Price": totalAmount.toString(),
          "Name": name,
          "Email": mail,
          "Image": image,
          "VehicleImage": widget.image,
          "Status": "Wait for confirmation",
          "Selected Days": selectedDaysList, 
        };

        // Save the order details to the database
        await DatabaseMethods().orderDetails(orderInfoMap);

        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.green),
                    Text("Payment Successful"),
                  ],
                ),
              ],
            ),
          ),
        );
        paymentIntent = null;
      }).onError((error, stackTrace) {
        print("Error is: $error $stackTrace");
      });
    } on StripeException catch (e) {
      print("Error is: $e");
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: Text("Cancelled"),
        ),
      );
    } catch (e) {
      print('$e');
    }
  }

  Future<Map<String, dynamic>> _createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': _calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretkey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );
      return jsonDecode(response.body);
    } catch (err) {
      print('Error charging user: ${err.toString()}');
      rethrow;
    }
  }

  String _calculateAmount(String amount) {
    double baseAmount = double.parse(amount) * 100; // Convert to cents
    return baseAmount.toInt().toString(); // Return as string
  }
}
