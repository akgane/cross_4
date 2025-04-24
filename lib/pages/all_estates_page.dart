import 'package:flutter/material.dart';
import 'package:rental/utils/sort_utils.dart';
import '../models/Estate.dart';
import '../widgets/category_estates_list/estate_card.dart';

class AllEstatesPage extends StatefulWidget {
  final String title;
  final List<Estate> estates;

  const AllEstatesPage({required this.title, required this.estates});

  @override
  _AllEstatesPageState createState() => _AllEstatesPageState();
}

class _AllEstatesPageState extends State<AllEstatesPage>{

  late List<Estate> _sortedEstates;
  String _currentSort = "title";
  bool _isAscending = true;

  @override
  void initState(){
    super.initState();
    _sortedEstates = [...widget.estates];
  }

  void _sortEstates(String sortBy){
    setState(() {
      _currentSort = sortBy;
      _isAscending = !_isAscending;
      _sortedEstates = SortUtils.sortBy(sortBy, _sortedEstates, _isAscending);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSortButton("Price", Icons.attach_money, "price"),
                _buildSortButton("Title", Icons.sort_by_alpha, "title"),
                _buildSortButton("Date", Icons.calendar_today, "date"),
                _buildSortButton("Views", Icons.visibility, "views")
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _sortedEstates.length,
              itemBuilder: (context, index) {
                final estate = _sortedEstates[index];
                return Column(
                  children: [
                    EstateCard(estate: estate),
                    if(index < _sortedEstates.length - 1)
                      Column(
                        children: [
                          SizedBox(height: 8,),

                          Divider(
                              height: 1,
                              thickness: 0.5,
                              color: Colors.grey[300]
                          ),

                          SizedBox(height: 8,)
                        ]
                      )
                  ]
                );
              },
            )
          )
        ],
      ),
    );
  }

  Widget _buildSortButton(String label, IconData icon, String sortBy) {
    return ElevatedButton.icon(
      onPressed: () => _sortEstates(sortBy),
      style: ElevatedButton.styleFrom(
        backgroundColor: _currentSort == sortBy ? Colors.orange : Colors.grey[800],
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        elevation: 4,
      ),
      icon: Icon(icon, size: 18),
      label: Text(
        _currentSort == sortBy
            ? (_isAscending ? "$label ↑" : "$label ↓")
            : label,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
    );
  }
}