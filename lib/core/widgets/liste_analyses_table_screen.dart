import 'package:flutter/material.dart';
import 'package:thervision/component/footer.dart';

class ListeAnalysesTableScreen extends StatefulWidget {
  const ListeAnalysesTableScreen({Key? key}) : super(key: key);

  @override
  State<ListeAnalysesTableScreen> createState() =>
      _ListeAnalysesTableScreenState();
}

class _ListeAnalysesTableScreenState extends State<ListeAnalysesTableScreen> {
  final List<Map<String, dynamic>> analyses = [
    {
      'image': 'assets/thermal.jpg',
      'nom': 'thermal_engine_001.jpg',
      'date': '2025-09-01',
      'anomalie': '',
      'recommandation': '',
      'statut': 'Analysé',
    },
    {
      'image': 'assets/thermal.jpg',
      'nom': 'thermal_engine_002.jpg',
      'date': '2025-09-02',
      'anomalie': '',
      'recommandation': '',
      'statut': 'En attente',
    },
    {
      'image': 'assets/thermal.jpg',
      'nom': 'thermal_engine_003.jpg',
      'date': '2025-09-03',
      'anomalie': '',
      'recommandation': '',
      'statut': 'Analysé',
    },
  ];

  int currentPage = 1;
  final int totalPages = 3;
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 16, top: 16),
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Rechercher un fichier ...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onChanged: (val) => setState(() => search = val),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: DataTable(
                    columnSpacing: 16,
                    headingRowHeight: 48,
                    dataRowHeight: 64,
                    columns: const [
                      DataColumn(label: Text('Image')),
                      DataColumn(label: Text('Nom')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Anomalie')),
                      DataColumn(label: Text('Recommandation')),
                      DataColumn(label: Text('Statut')),
                      DataColumn(label: Text('Action')),
                    ],
                    rows:
                        analyses.map((a) {
                          return DataRow(
                            cells: [
                              DataCell(
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.asset(
                                    a['image'],
                                    width: 48,
                                    height: 48,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              DataCell(Text(a['nom'])),
                              DataCell(Text(a['date'])),
                              DataCell(Text(a['anomalie'])),
                              DataCell(Text(a['recommandation'])),
                              DataCell(
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        a['statut'] == 'Analysé'
                                            ? Colors.blue.shade50
                                            : Colors.orange.shade50,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    a['statut'],
                                    style: TextStyle(
                                      color:
                                          a['statut'] == 'Analysé'
                                              ? Colors.blue
                                              : Colors.orange,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              DataCell(
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.person_outline),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.email_outlined),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit_outlined),
                                      onPressed: () {},
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.delete_outline),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                  ),
                ),
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
            const SizedBox(height: 24),
            const Footer(),
          ],
        ),
      ),
    );
  }
}
