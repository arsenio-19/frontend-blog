
import 'package:flutter/material.dart';
import 'artikelSayaPage.dart';
import 'buatartikelpage.dart';
import 'loginpage.dart';

class profilpage extends StatelessWidget {
  const profilpage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        SizedBox(height: 10),

        Center(
          child: CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.person,
              size: 55,
            ),
          ),
        ),

        SizedBox(height: 16),

        Center(
          child: Text(
            'Arsenio',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(height: 4),

        Center(
          child: Text(
            '@arsenio',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15,
            ),
          ),
        ),

        SizedBox(height: 8),

        Center(
          child: Text(
            'Suka berbagi cerita dan informasi.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),

        SizedBox(height: 24),

        Row(
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        '5',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text('Artikel'),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      Text(
                        '12',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                     SizedBox(height: 4),
                      Text('Dibaca'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 24),

        Text(
          'Menu',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 12),

        Card(
          child: ListTile(
            leading: Icon(Icons.article_outlined),
            title: Text('Artikel Saya'),
            subtitle: Text('Lihat artikel yang telah dibuat'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => artikelSayapage(),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Card(
          child: ListTile(
            leading: Icon(Icons.add_circle_outline),
            title: Text('Buat Artikel'),
            subtitle: Text('Tulis dan publikasikan artikel baru'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => buatartikelpage(),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 10),

        Card(
          child: ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Pengaturan'),
            subtitle: Text('Atur preferensi aplikasi'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Pengaturan belum tersedia'),
                ),
              );
            },
          ),
        ),

        const SizedBox(height: 24),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => loginpage(),
                ),
                (route) => false,
              );
            },
            icon: Icon(Icons.logout),
            label: Text('Logout'),
          ),
        ),

         SizedBox(height: 20),
      ],
    );
  }
}