import 'package:cloud_firestore/cloud_firestore.dart';

class Restaurant {
  final String id;
  final String name;
  final String address;
  final String phone;
  final String image;
  final String description;
  final String rating;
  final String hours;
  final double price;
  final bool favourite;
  final List<dynamic> tags;

  Restaurant({
    required this.id,
    required this.name,
    required this.address,
    required this.phone,
    required this.image,
    required this.description,
    required this.rating,
    required this.hours,
    required this.price,
    required this.tags,
    required this.favourite,
  });

  static List<Restaurant> restaurantList = [
    Restaurant(
      id: '1',
      name: 'McDonalds',
      address: '123 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://www.tasteofhome.com/wp-content/uploads/2018/05/shutterstock_243788887.jpg?fit=700%2C700',
      description:
          'McDonald\'s is an American corporation that operates one of the largest chains of fast food restaurants in the world.',
      rating: '4.4',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Burger', 'Fast Food'],
      favourite: false,
    ),
    Restaurant(
      id: '2',
      name: 'Burger King',
      address: '456 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://media-assets.swiggy.com/swiggy/image/upload/f_auto,q_auto,fl_lossy/e33e1d3ba7d6b2bb0d45e1001b731fcf',
      description:
          'Burger King is an American multinational chain of hamburger fast food restaurants.',
      rating: '4.5',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Burger', 'Fast Food'],
      favourite: false,
    ),
    Restaurant(
      id: '3',
      name: 'KFC',
      address: '789 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://tb-static.uber.com/prod/image-proc/processed_images/5c3e89117e503ae58c4aa5dbed6bbd5b/3ac2b39ad528f8c8c5dc77c59abb683d.jpeg',
      description:
          'KFC is an American fast food restaurant chain that specializes in fried chicken.',
      rating: '4.5',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Chicken', 'Fast Food'],
      favourite: false,
    ),
    Restaurant(
      id: '4',
      name: 'Pizza Hut',
      address: '101 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://media-cdn.tripadvisor.com/media/photo-p/15/34/be/4d/photo0jpg.jpg',
      description:
          'Pizza Hut is an American restaurant chain and international franchise which was founded in 1958 in Wichita, Kansas by Dan and Frank Carney.',
      rating: '4.5',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Pizza', 'Fast Food'],
      favourite: false,
    ),
    Restaurant(
      id: '5',
      name: 'Subway',
      address: '202 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNqTpXxohbL9Jq_3teKnIceR4m6SHpKewTFyRKOgeroRkzwoy11PtCL_b2D8-HOsZPWJY&usqp=CAU',
      description:
          'Subway is an American privately held restaurant franchise that primarily sells submarine sandwiches and salads.',
      rating: '4.5',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Sandwich', 'Fast Food'],
      favourite: false,
    ),
    Restaurant(
      id: '6',
      name: 'Starbucks',
      address: '303 Main St, New York, NY 10001',
      phone: '123-456-7890',
      image:
          'https://recipes.net/wp-content/uploads/2024/02/what-is-a-starbucks-frappuccino-1707748159.jpg',
      description:
          'Starbucks Corporation is an American multinational chain of coffeehouses and roastery reserves headquartered in Seattle, Washington.',
      rating: '4.5',
      hours: 'Open 24 hours',
      price: 5.0,
      tags: ['Coffee'],
      favourite: false,
    ),
  ];

  factory Restaurant.fromDocument(DocumentSnapshot doc) {
    return Restaurant(
      id: doc.id,
      name: doc['name'],
      address: doc['address'],
      phone: doc['phone'],
      image: doc['image'],
      description: doc['description'],
      rating: doc['rating'],
      hours: doc['hours'],
      price: doc['price'],
      tags: List<String>.from(doc['tags']),
      favourite: doc['favourite'],
    );
  }
}
