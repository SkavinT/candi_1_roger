import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:candi_1/models/candi.dart';
import 'package:candi_1/data/favorite_data.dart'; // Import the shared list
import 'package:candi_1/utils/favorite_manager.dart'; // Import the FavoriteManager

class DetailScreen extends StatefulWidget {
  final Candi candi;

  const DetailScreen({super.key, required this.candi});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  void _checkFavoriteStatus() async {
    List<Candi> favorites = await FavoriteManager.getFavorites();
    setState(() {
      isFavorite = favorites.any((item) => item.name == widget.candi.name);
    });
  }

  void toggleFavorite(Candi candi) async {
    if (isFavorite) {
      await FavoriteManager.removeFavorite(candi);
    } else {
      await FavoriteManager.addFavorite(candi);
    }
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              // Detail Header
              Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        widget.candi.imageAsset,
                        width: double.infinity,
                        height: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  // Custom Back Button
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.deepPurple[100]?.withOpacity(0.8),
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back),
                      ),
                    ),
                  ),
                ],
              ),
              // Detail Info
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Info
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.candi.name,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          onPressed: () {
                            toggleFavorite(widget.candi);
                          },
                          icon: Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Colors.red : null,
                          ),
                        ),
                      ],
                    ),
                    // Middle Info
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            'Di bangun',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.candi.built}')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.house,
                          color: Colors.green,
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            'Tipe',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.candi.type}')
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.place,
                          color: Colors.red,
                        ),
                        const SizedBox(
                          width: 0,
                        ),
                        const SizedBox(
                          width: 70,
                          child: Text(
                            'Lokasi',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(': ${widget.candi.location}')
                      ],
                    ),
                    // Separator
                    const SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: Colors.deepPurple.shade100,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    // Bottom Info
                    const Text(
                      'Deskripsi',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      widget.candi.description,
                    )
                  ],
                ),
              ),
              // Detail Gallery
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 8,
                    ),
                    Divider(
                      color: Colors.deepPurple.shade100,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Text(
                      'Galeri',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 100,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.candi.imageUrls.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () {},
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.deepPurple.shade100,
                                    width: 2,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl: widget.candi.imageUrls[index],
                                    height: 120,
                                    width: 120,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      width: 120,
                                      height: 120,
                                      color: Colors.deepPurple[50],
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Text(
                      'Tap Untuk Memperbesar',
                      style: TextStyle(fontSize: 12, color: Colors.black54),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}