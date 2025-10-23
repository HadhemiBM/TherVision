import 'package:flutter/material.dart';

class ListeAnalysesScreen extends StatefulWidget {
  const ListeAnalysesScreen({Key? key}) : super(key: key);

  @override
  State<ListeAnalysesScreen> createState() => _ListeAnalysesScreenState();
}

class _ListeAnalysesScreenState extends State<ListeAnalysesScreen> {
  final List<String> images = List.generate(8, (i) => 'assets/thermal.jpg');
  int currentPage = 1;
  final int totalPages = 3;
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   title: Row(
      //     children: [
      //       Image.asset('assets/LogoBig.png', width: 32, height: 32),
      //       const SizedBox(width: 8),
      //       const Text('THERVISION', style: TextStyle(color: Colors.black)),
      //     ],
      //   ),
      //   centerTitle: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher un fichier ...',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) => setState(() => search = val),
              ),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 24,
                  mainAxisSpacing: 24,
                  childAspectRatio: 1.2,
                ),
                itemCount: images.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(images[index], fit: BoxFit.cover),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed:
                      currentPage > 1
                          ? () => setState(() => currentPage--)
                          : null,
                ),
                ...List.generate(
                  totalPages,
                  (i) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: InkWell(
                      onTap: () => setState(() => currentPage = i + 1),
                      child: Text(
                        '${i + 1}',
                        style: TextStyle(
                          fontWeight:
                              currentPage == i + 1
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                          decoration:
                              currentPage == i + 1
                                  ? TextDecoration.underline
                                  : null,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.arrow_forward),
                  onPressed:
                      currentPage < totalPages
                          ? () => setState(() => currentPage++)
                          : null,
                ),
              ],
            ),
            // const SizedBox(height: 24),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: const [
            //     Text('← Retour', style: TextStyle(fontSize: 16)),
            //     Text(
            //       '@4inaTechnology',
            //       style: TextStyle(fontSize: 16, color: Colors.grey),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
