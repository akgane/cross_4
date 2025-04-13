import 'package:flutter/material.dart';
import 'package:rental/models/Category.dart';
import '../models/Estate.dart';

final List<Category> exampleCategories = [
  Category(title: "Home", icon: Icons.home),
  Category(title: "Office", icon: Icons.business),
  Category(title: "Apartment", icon: Icons.apartment),
  Category(title: "Villa", icon: Icons.villa),
];

final List<Estate> exampleEstates = [
  Estate(
      id: '1',
      title: "City Penthouse",
      category: "Apartment",
      address: "999 Skyline Avenue",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 300000
  ),
  Estate(
      id: '2',
      title: "Downtown Loft",
      category: "Apartment",
      address: "45 Arts District",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 185000
  ),
  Estate(
      id: '3',
      title: "Riverside Studio",
      category: "Apartment",
      address: "88 Riverwalk Lane",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 120000
  ),
  Estate(
      id: '4',
      title: "Historic District Flat",
      category: "Apartment",
      address: "22 Heritage Square",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 210000
  ),
  Estate(
      id: '5',
      title: "Modern High-Rise",
      category: "Apartment",
      address: "303 Glass Tower Road",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 275000
  ),

  // Homes
  Estate(
      id: '6',
      title: "Suburban Family Home",
      category: "Home",
      address: "123 Maple Street",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 350000
  ),
  Estate(
      id: '7',
      title: "Cozy Cottage",
      category: "Home",
      address: "7 Countryside Lane",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 195000
  ),
  Estate(
      id: '8',
      title: "Renovated Victorian",
      category: "Home",
      address: "500 Old Town Road",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 420000
  ),
  Estate(
      id: '9',
      title: "Modern Ranch House",
      category: "Home",
      address: "250 Prairie Avenue",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 310000
  ),
  Estate(
      id: '10',
      title: "Lakefront Property",
      category: "Home",
      address: "1 Waters Edge",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 550000
  ),

  // Offices
  Estate(
      id: '11',
      title: "Executive Suite",
      category: "Office",
      address: "100 Business Center",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 200000
  ),
  Estate(
      id: '12',
      title: "Tech Startup Space",
      category: "Office",
      address: "45 Innovation Drive",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 320000
  ),
  Estate(
      id: '13',
      title: "Medical Office",
      category: "Office",
      address: "78 Health Plaza",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 280000
  ),
  Estate(
      id: '14',
      title: "Law Firm Premises",
      category: "Office",
      address: "30 Justice Building",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 375000
  ),
  Estate(
      id: '15',
      title: "Retail Office Space",
      category: "Office",
      address: "200 Commerce Street",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 240000
  ),

  // Villas
  Estate(
      id: '16',
      title: "Luxury Beach Villa",
      category: "Villa",
      address: "5 Oceanfront Drive",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 1200000
  ),
  Estate(
      id: '17',
      title: "Mountain Retreat Villa",
      category: "Villa",
      address: "88 Alpine Way",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 850000
  ),
  Estate(
      id: '18',
      title: "Mediterranean Estate",
      category: "Villa",
      address: "22 Vineyard Lane",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 950000
  ),
  Estate(
      id: '19',
      title: "Private Island Villa",
      category: "Villa",
      address: "1 Paradise Island",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 2500000
  ),
  Estate(
      id: '20',
      title: "Gated Community Villa",
      category: "Villa",
      address: "500 Elite Circle",
      imageUrl: "https://placehold.jp/255x150.png",
      price: 680000
  ),
];