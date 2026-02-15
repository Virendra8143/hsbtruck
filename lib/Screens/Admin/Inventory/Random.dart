import 'package:flutter/material.dart';

class Inventoryboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Getting MediaQuery data
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;

    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Inventory Dashboard"),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            // Top Stats Section
            Card(
              margin: EdgeInsets.all(screenWidth * 0.04), // Margin relative to screen width
              child: Padding(
                padding: EdgeInsets.all(screenWidth * 0.04), // Padding relative to screen width
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildStatItem("Products", "5", screenWidth),
                    _buildStatItem("Low Stock", "2", screenWidth),
                    _buildStatItem("Today's Sales", "₹80,000", screenWidth),
                    IconButton(
                      icon: const Icon(Icons.file_download),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),

            // TabBar
            TabBar(
              labelColor: Colors.red,
              unselectedLabelColor: Colors.blue,
              tabs: const [
                Tab(text: "All Products"),
                Tab(text: "Low Stock"),
                Tab(text: "Sales"),
                Tab(text: "Products"),
              ],
            ),

            // Product List
            Expanded(
              child: TabBarView(
                children: [
                  _buildProductList(),
                  Center(child: Text("Low Stock Items")),
                  Center(child: Text("Sales Data")),
                  Center(child: Text("Product Management")),
                ],
              ),
            ),
          ],
        ),

        // Floating Action Button
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, String value, double screenWidth) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: screenWidth * 0.045, // Responsive font size
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: screenWidth * 0.035, // Responsive font size
          ),
        ),
      ],
    );
  }

  Widget _buildProductList() {
    final products = [
      {"id": "#56425896", "name": "MSE20", "stock": "9KL"},
      {"id": "#56496245", "name": "Power", "stock": "5KL"},
      {"id": "#56783325", "name": "Diesel", "stock": "5KL"},
      {"id": "#56783325", "name": "Lube", "stock": "50UT"},
    ];

    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          margin: const EdgeInsets.all(8.0), // Keep margins small for list items
          child: ListTile(
            leading: CircleAvatar(
              child: Text(product["name"]![0]),
            ),
            title: Text(product["name"]!),
            subtitle: Text("Stock: ${product["stock"]}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.visibility),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}