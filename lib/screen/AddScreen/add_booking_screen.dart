import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hotelmanagement/components/AlertDialog.dart';
import 'package:hotelmanagement/components/input.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:uuid/uuid.dart';
import 'add_customer_screen.dart';

class AddBooking extends StatefulWidget {
  const AddBooking({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBookingState createState() => _AddBookingState();
}

class _AddBookingState extends State<AddBooking> {
  var bookingLastNameController = TextEditingController();
  var bookingFirstNameController = TextEditingController();
  var guestNumberController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var priceController = TextEditingController();
  var floorController = TextEditingController();
  var emailController = TextEditingController();
  var billingFirstNameController = TextEditingController();
  var billingLastNameController = TextEditingController();
  var billingAddressController = TextEditingController();
  var billingCityController = TextEditingController();
  var billingPostalCodeController = TextEditingController();
  var billingCountryController = TextEditingController();
  var taxCodeController = TextEditingController();
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final DateFormat nomeFormatter = DateFormat('MM/yyyy');

  DateTime dataInzio = DateTime.now();
  DateTime endDate = DateTime.now();
  String cognomeNonValido = "Cognome non valido";
  String parola = "";
  late String bookingCode;

  @override
  void initState() {
    super.initState();
    bookingCode = Uuid().v4(); // Genera un UUID casuale
  }

  @override
  void dispose() {
    bookingLastNameController.dispose();
    bookingFirstNameController.dispose();
    guestNumberController.dispose();
    phoneNumberController.dispose();
    priceController.dispose();
    floorController.dispose();
    emailController.dispose();
    billingFirstNameController.dispose();
    billingLastNameController.dispose();
    billingAddressController.dispose();
    billingCityController.dispose();
    billingPostalCodeController.dispose();
    billingCountryController.dispose();
    taxCodeController.dispose();
    super.dispose();
  }

  void _addBooking() async {
    if (_isFieldEmpty()) {
      return;
    }

    final User? user = FirebaseAuth.instance.currentUser;

    await addDataFamigli();

    for (int i = 0; i < int.parse(guestNumberController.text); i++) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) =>
              AddCustomer(bookingcode: bookingCode)));
    }

    _clearControllers();
  }

  bool _isFieldEmpty() {
    final fields = {
      "Booking Last Name": bookingLastNameController.text,
      "Phone Number": phoneNumberController.text,
      "Number of Guests": guestNumberController.text,
      "Stay Cost": priceController.text,
      "Floor or Room Number": floorController.text,
    };

    for (final field in fields.entries) {
      if (field.value.isEmpty) {
        alert(context, "${field.key} not entered");
        return true;
      }
    }

    return false;
  }

  void _clearControllers() {
    guestNumberController.clear();
    priceController.clear();
    phoneNumberController.clear();
    floorController.clear();
    bookingFirstNameController.clear();
  }

  Future<void> alertDataRange(BuildContext context, box) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.width / 1.5,
            width: MediaQuery.of(context).size.width / 2,
            child: SfDateRangePicker(
              onSelectionChanged: selectionChanged,
              selectionMode: DateRangePickerSelectionMode.range,
              initialSelectedRange: PickerDateRange(
                  DateTime.now().subtract(const Duration(days: 4)),
                  DateTime.now().add(const Duration(days: 3))),
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void selectionChanged(DateRangePickerSelectionChangedArgs args) {
    try {
      setState(() {
        dataInzio = args.value.startDate;
        endDate = args.value.endDate;
      });
      // ignore: empty_catches
    } catch (e) {}
  }

  addDataFamigli() {
    if (kDebugMode) {
      print(bookingCode.toString());
    }
    User? user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore.instance
        .collection('Date')
        .doc(user?.uid)
        .collection("booking")
        .doc(bookingCode)
        .set({
      'CognomePrenotazione': bookingLastNameController.text,
      'NomePrenotazione': bookingFirstNameController.text,
      'startDate': formatter.format(dataInzio),
      'endDate': formatter.format(endDate),
      'Npeople': int.parse(guestNumberController.text),
      'Price': int.parse(priceController.text),
      'Floor': floorController.text,
    });
  }

  Widget sectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gestione Hotel")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Aggiungi Ospiti",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              sectionHeader("Informazioni di Prenotazione"),
              defaultInputText(
                label: "Booking First Name",
                controller: bookingFirstNameController,
              ),
              defaultInputText(
                label: "Booking Last Name",
                controller: bookingLastNameController,
              ),
              defaultInputNumber(
                label: "Number of Guests",
                controller: guestNumberController,
              ),
              defaultInputNumber(
                label: "Stay Cost",
                controller: priceController,
              ),
              defaultInputNumber(
                label: "Phone Number",
                controller: phoneNumberController,
              ),
              defaultInputText(label: "Email", controller: emailController),
              defaultInputText(
                label: "Floor or Room Number",
                controller: floorController,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: OutlinedButton(
                  onPressed: () {
                    alertDataRange(
                        context, "Inserire data di inizio e fine soggiorno");
                  },
                  child: const Text("Date del soggiorno"),
                ),
              ),
              sectionHeader("Dati di Fatturazione"),
              defaultInputText(
                label: "Billing First Name",
                controller: billingFirstNameController,
              ),
              defaultInputText(
                label: "Billing Last Name",
                controller: billingLastNameController,
              ),
              defaultInputText(
                label: "Billing Address",
                controller: billingAddressController,
              ),
              defaultInputText(
                label: "Billing City",
                controller: billingCityController,
              ),
              defaultInputText(
                label: "Billing Postal Code",
                controller: billingPostalCodeController,
              ),
              defaultInputText(
                label: "Billing Country",
                controller: billingCountryController,
              ),
              defaultInputText(
                label: "Tax Code / VAT Number",
                controller: taxCodeController,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addBooking,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
