import 'package:flutter/material.dart';
import 'package:candi_1/models/candi.dart';
import 'package:candi_1/utils/favorite_manager.dart'; // Import the FavoriteManager
import 'package:candi_1/screens/detail_screen.dart'; // Import the DetailScreen

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<Candi> favoriteCandis = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  void _loadFavorites() async {
    List<Candi> favorites = await FavoriteManager.getFavorites();
    setState(() {
      favoriteCandis = favorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: ListView.builder(
        itemCount: favoriteCandis.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                favoriteCandis[index].imageAsset,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(favoriteCandis[index].name),
            subtitle: Text(favoriteCandis[index].location),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailScreen(candi: favoriteCandis[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}