import 'package:flutter/material.dart';
import '../model_class/category_model.dart';

final List<String> collectionNames = [
  'Dopamine',
  'AI',
  'Ramadan',
  'Rain',
  'Space',
  'Gaming',
  'Coffee & Nature',
  'Technology',
  'Water',
];


final List<String> collectionBackgroundImage = [
  'https://plus.unsplash.com/premium_photo-1671019820530-728527dec7e4?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
  'https://plus.unsplash.com/premium_photo-1682824038225-834e4244f1e6?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTB8SUVGVXlQb1EwMXd8fGVufDB8fHx8fA%3D%3D',
  'https://plus.unsplash.com/premium_photo-1676929390415-5f40fdcfc3e9?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8Nnw2MVljLTluQ1NhMHx8ZW58MHx8fHx8',
  'https://images.unsplash.com/photo-1648135267176-7f6d09e26e40?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXw5OTA2MjAwfHxlbnwwfHx8fHw%3D',
  'https://images.unsplash.com/photo-1456154875099-97a3a56074d3?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXw0MzMyNTgwfHxlbnwwfHx8fHw%3D',
  'https://images.unsplash.com/photo-1581199451876-013a48e36f1c?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXwxMDQ5NDg5NHx8ZW58MHx8fHx8',
  'https://images.unsplash.com/photo-1530595663417-ff662189249a?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8NXwyOTA1NjQ2N3x8ZW58MHx8fHx8',
  'https://plus.unsplash.com/premium_photo-1661421687248-7bb863c60723?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MTB8SW8wNmREMklOTWd8fGVufDB8fHx8fA%3D%3D',
  'https://images.unsplash.com/photo-1643635267782-22c52d3b03db?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxjb2xsZWN0aW9uLXBhZ2V8MXw5MTg0MzN8fGVufDB8fHx8fA%3D%3D',
];


final List<String> categoryName = [
  'Food',
  'Nature',
  'Animal',
  'Sea',
  'Human',
  'Bike',
  'Car',
  'Home',
  'Moon',
  'Flower',
];

final List<String> categoryImage = [
  'https://plus.unsplash.com/premium_photo-1663858367001-89e5c92d1e0e?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1586348943529-beaae6c28db9?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fG5hdHVyZXxlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1484406566174-9da000fda645?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8QW5pbWFsfGVufDB8fDB8fHww',
  'https://images.unsplash.com/photo-1439405326854-014607f694d7?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8c2VhfGVufDB8fDB8fHww',
  'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SHVtYW58ZW58MHx8MHx8fDA%3D',
  'https://images.unsplash.com/photo-1558981403-c5f9899a28bc?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8QmlrZXxlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1568605117036-5fe5e7bab0b7?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FyfGVufDB8fDB8fHww',
  'https://images.unsplash.com/photo-1501183638710-841dd1904471?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8SG9tZXxlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1532693322450-2cb5c511067d?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8bW9vbnxlbnwwfHwwfHx8MA%3D%3D',
  'https://images.unsplash.com/photo-1606041008023-472dfb5e530f?w=1000&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8N3x8Rmxvd2VyfGVufDB8fDB8fHww',
];


final List<String> colorName = [
  'Black_and_White',
  'Red',
  'Green',
  'Blue',
  'Black',
  'White',
  'Yellow',
  'Teal',
  'Purple',
  'Orange',
  'Magenta'
];

final List<Category> items = [
  Category(
    title: 'Edit Profile',
    subtitle: 'You can Edit your profile details here',
    image: 'assets/icons/Edit.png',
  ),
  Category(
    title: 'Contributor',
    subtitle: 'All your creativity pays you off',
    image: 'assets/icons/Contributor.png',
  ),
  Category(
    title: 'Subscription',
    subtitle: 'Subscribe for Ad Block',
    image: 'assets/icons/Wallet.png',
  ),
  Category(
    title: 'Security',
    subtitle: 'Check out the details here',
    image: 'assets/icons/Security.png',
  ),
  Category(
    title: 'Language',
    subtitle: 'You can change language here',
    image: 'assets/icons/Language.png',
  ),
  Category(
    title: 'About',
    subtitle: 'Know more about the app',
    image: 'assets/icons/About.png',
  ),
  Category(
    title: 'Logout',
    subtitle: 'Logout your app',
    image: 'assets/icons/Logout.png',
  ),
];

String capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}

