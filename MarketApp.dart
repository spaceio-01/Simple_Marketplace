import 'package:flutter/material.dart';

class MarketApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatelessWidget {
  final List<Map<String, String>> products = List.generate(
    25,
    (i) => {
      'title': 'Product ${i + 1}',
      'desc': 'Description for product ${i + 1}',
      'image': 'https://picsum.photos/seed/item$i/200/140',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return Card(
            child: ListTile(
              leading: Image.network(
                item['image']!,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(item['title']!),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductDetailPage(
                      title: item['title']!,
                      desc: item['desc']!,
                      imageUrl: item['image']!,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final String title;
  final String desc;
  final String imageUrl;

  ProductDetailPage({
    required this.title,
    required this.desc,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(imageUrl, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 12),
            Text(desc),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Buy Now'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => OrderPage(productTitle: title),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OrderPage extends StatelessWidget {
  final String productTitle;

  OrderPage({required this.productTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Order:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(productTitle),
            const SizedBox(height: 24),
            const Text(
              'Payment Method',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const ListTile(
              leading: Icon(Icons.credit_card),
              title: Text('Credit Card'),
            ),
            const ListTile(
              leading: Icon(Icons.account_balance_wallet),
              title: Text('Digital Wallet'),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                child: const Text('Pay Now'),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Payment successful')),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          ConfirmationPage(productTitle: productTitle),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationPage extends StatelessWidget {
  final String productTitle;

  ConfirmationPage({required this.productTitle});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 80),
              const SizedBox(height: 16),
              const Text(
                'Order successfully placed',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                productTitle,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text('Back to Catalog'),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
