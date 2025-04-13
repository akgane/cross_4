import 'package:flutter/material.dart';
import '../models/Estate.dart';

class AllEstatesPage extends StatelessWidget {
  final String title;
  final List<Estate> estates;

  const AllEstatesPage({required this.title, required this.estates});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: estates.length,
        itemBuilder: (context, index) {
          final estate = estates[index];
          return EstateCard(estate: estate);
        },
      ),
    );
  }
}

class EstateCard extends StatefulWidget{
  final Estate estate;

  const EstateCard({required this.estate});
  @override
  State<StatefulWidget> createState() => _EstateCardState();
}

class _EstateCardState extends State<EstateCard>{
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.estate.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 12),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(12)),
                child: Image.network(
                  widget.estate.imageUrl,
                  width: 190,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.estate.address,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                    SizedBox(height: 8),
                    Text(
                      "\$${widget.estate.price}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: isFavorite ? Colors.red : Colors.grey
                ),
                onPressed: (){
                  setState((){
                    isFavorite = !isFavorite;
                  });
                  print(isFavorite
                      ? 'Added to favorites!'
                      : 'Removed from favorites');
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(Icons.visibility, size: 16, color: Colors.grey),
                SizedBox(width: 4),
                Text('${widget.estate.views} views',
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}