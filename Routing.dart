main.dart

import 'package:flutter/material.dart';
import 'product.dart';
import 'order.dart';
import 'confirm.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/product', // Specify the initial route
      routes: {
        '/product': (context) => ProductPage(),
        '/order': (context) => OrderPage(),
        '/confirm': (context) => ConfirmPage(),
      },
    );
  }
}








product.dart

import 'package:flutter/material.dart';
import 'order.dart'; // Import the OrderPage
import 'confirm.dart'; // Import the ConfirmPage

void main() {
  runApp(ProductPage());
}

class ProductPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ProductForm(),
    );
  }
}

class ProductForm extends StatefulWidget {
  @override
  _ProductFormState createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {
  String productName = '';
  double price = 0.0;
  String selectedType = '';
  List<String> types = ['Type 1', 'Type 2', 'Type 3'];

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPage()), // Navigate to OrderPage
    );
  }

  void navigateBackToProductPage() {
    Navigator.popUntil(context, ModalRoute.withName('/product')); // Navigate back to ProductPage
  }

  void navigateToOrderPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => OrderPage()), // Navigate to OrderPage
    );
  }

  void navigateToConfirmPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmPage()), // Navigate to ConfirmPage
    );
  }

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: openDrawer,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Product Name'),
              onChanged: (value) {
                setState(() {
                  productName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Price'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  price = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Select Type:'),
            Column(
              children: types
                  .map(
                    (type) => RadioListTile(
                      title: Text(type),
                      value: type,
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value as String;
                        });
                      },
                    ),
                  )
                  .toList(),
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Back' button logic
                    // You can navigate back or perform any other action here
                    navigateBackToProductPage();
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Next' button logic
                    // You can navigate to the next screen or perform any other action here
                    navigateToNextPage();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Product Page'),
              onTap: () {
                navigateBackToProductPage();
              },
            ),
            ListTile(
              title: Text('Order Page'),
              onTap: () {
                navigateToOrderPage();
              },
            ),
            ListTile(
              title: Text('Confirmation Page'),
              onTap: () {
                navigateToConfirmPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}



order.dart

import 'package:flutter/material.dart';
import 'confirm.dart'; // Import the ConfirmPage

void main() {
  runApp(OrderPage());
}

class OrderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyForm(),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  int quantity = 0;
  DateTime? orderDate;
  String address = '';

  void navigateToNextPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ConfirmPage()), // Navigate to ConfirmPage
    );
  }

  void navigateBackToProductPage() {
    Navigator.popUntil(context, ModalRoute.withName('/product')); // Navigate back to ProductPage
  }

  void openDrawer() {
    Scaffold.of(context).openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Form'),
        actions: [
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: openDrawer,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Quantity:'),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Quantity'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  quantity = int.tryParse(value) ?? 0;
                });
              },
            ),
            SizedBox(height: 16.0),
            Text('Order Date:'),
            InkWell(
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null && pickedDate != orderDate) {
                  setState(() {
                    orderDate = pickedDate;
                  });
                }
              },
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(8),
                child: orderDate != null
                    ? Text(
                        "${orderDate!.toLocal()}".split(' ')[0],
                      )
                    : Text("Select Date"),
              ),
            ),
            SizedBox(height: 16.0),
            Text('Address:'),
            TextField(
              decoration: InputDecoration(labelText: 'Enter Address'),
              onChanged: (value) {
                setState(() {
                  address = value;
                });
              },
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Back' button logic
                    // You can navigate back or perform any other action here
                    navigateBackToProductPage();
                  },
                  child: Text('Back'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle 'Next' button logic
                    // You can navigate to the next screen or perform any other action here
                    navigateToNextPage();
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Menu Options',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Product Page'),
              onTap: () {
                navigateBackToProductPage();
              },
            ),
            ListTile(
              title: Text('Order Page'),
              onTap: () {
                // Handle Option 2
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              title: Text('Confirmation Page'),
              onTap: () {
                navigateToNextPage();
              },
            ),
          ],
        ),
      ),
    );
  }
}




confirm.dart
import 'package:flutter/material.dart';
import 'order.dart'; // Import the OrderPage

void main() {
  runApp(ConfirmPage());
}

class ConfirmPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Confirmation Page'),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu Options',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                title: Text('Product Page'),
                onTap: () {
                  Navigator.popUntil(context, ModalRoute.withName('/product')); // Navigate back to ProductPage
                },
              ),
              ListTile(
                title: Text('Order Page'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
              ListTile(
                title: Text('Confirmation Page'),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                },
              ),
            ],
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('This is the confirmation page'),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrderPage()),
                  );
                },
                child: Text('Back to Order'),
              ),
              Spacer(),
              ElevatedButton(
                onPressed: () {
                  // Handle submit logic
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
