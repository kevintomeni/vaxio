import 'package:flutter/material.dart';

class PaymentOptionsPage extends StatefulWidget {
  const PaymentOptionsPage({Key? key}) : super(key: key);

  @override
  State<PaymentOptionsPage> createState() => _PaymentOptionsPageState();
}

class _PaymentOptionsPageState extends State<PaymentOptionsPage> {
  int selected = 0; // 0 = PayPal, 1 = Credit Card

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        leading: const BackButton(),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Payment Options', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
            const SizedBox(height: 32),
            _PaymentOptionTile(
              selected: selected == 0,
              onTap: () => setState(() => selected = 0),
              label: 'PayPal',
              logo: Image.asset('assets/images/paypal.png', height: 32),
            ),
            const SizedBox(height: 16),
            _PaymentOptionTile(
              selected: selected == 1,
              onTap: () => setState(() => selected = 1),
              label: 'Credit Card',
              logo: Row(
                children: [
                  Image.asset('assets/images/visa.png', height: 28),
                  const SizedBox(width: 8),
                  Image.asset('assets/images/mastercard.png', height: 28),
                ],
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () {
                  // Action de paiement
                },
                child: const Text('Pay', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add_circle, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
        currentIndex: 2,
        onTap: (i) {},
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

class _PaymentOptionTile extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  final String label;
  final Widget logo;

  const _PaymentOptionTile({
    required this.selected,
    required this.onTap,
    required this.label,
    required this.logo,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: selected ? Colors.blue : Colors.transparent, width: 2),
        ),
        child: Row(
          children: [
            Icon(
              selected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: selected ? Colors.blue : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 18)),
            const Spacer(),
            logo,
          ],
        ),
      ),
    );
  }
} 