import 'package:astrokit/src/Screens/astre_detail.dart';
import 'package:astrokit/src/class/astres.dart';
import 'package:flutter/material.dart';

class MyNotification extends Notification {
  final String title;

  const MyNotification({required this.title});
}

class ListAstres extends StatefulWidget {
  const ListAstres({Key? key}) : super(key: key);

  static const String routeName = '/list_astres';

  @override
  _ListAstresState createState() => _ListAstresState();
}

class _ListAstresState extends State<ListAstres> {
  late Future<List<Astre>> _astres;
  Icon _iconSearch = const Icon(Icons.search);
  Widget _searchBar = const Text('Liste des astres');
  Icon _favIcon = const Icon(Icons.favorite_outline_outlined);

  @override
  initState() {
    super.initState();
    _astres = Astre.getAstres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _searchBar,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: IconButton(
                icon: _iconSearch,
                onPressed: () {
                  setState(() {
                    if (_iconSearch.icon == Icons.search) {
                      _iconSearch = const Icon(Icons.close);
                      _searchBar = TextField(
                        autofocus: true,
                        style: const TextStyle(color: Colors.white),
                        decoration: const InputDecoration(
                          hintText: 'Rechercher un astre',
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                          labelStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _astres = Astre.getFilter(value);
                          });
                        },
                      );
                    } else {
                      _iconSearch = const Icon(Icons.search);
                      _searchBar = const Text('Liste des astres');
                      _astres = Astre.getAstres();
                    }
                  });
                }),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
                icon: _favIcon,
                onPressed: () {
                  setState(() {
                    if (_favIcon.icon == Icons.favorite_outline_outlined) {
                      _favIcon = const Icon(Icons.favorite);
                      _astres = Astre.getFav();
                    } else {
                      _astres = Astre.getAstres();
                      _favIcon = const Icon(Icons.favorite_outline_outlined);
                    }
                  });
                }),
          ),
        ],
      ),
      body: FutureBuilder<List<Astre>>(
        future: _astres,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                Astre astre = snapshot.data![index];
                return Container(
                  margin: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.amber,
                  ),
                  child: ListTile(
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(astre.fav
                              ? Icons.favorite_outlined
                              : Icons.favorite_outline_outlined),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _astres = Astre.updateFav(astre);
                            });
                          },
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: Colors.black),
                      ],
                    ),
                    leading: Hero(
                      tag: astre.nom,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.asset('assets/images/astres/moon.jpg'),
                      ),
                    ),
                    title: Text(astre.nom),
                    subtitle: Text(astre.constellation),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        AstreDetail.routeName,
                        arguments: astre.toJson(),
                      );
                    },
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class mytile extends StatelessWidget {
  const mytile({
    Key? key,
    required this.astre,
  }) : super(key: key);

  final Astre astre;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.amber,
      ),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            AstreDetail.routeName,
            arguments: astre.toJson(),
          );
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Hero(
                  tag: astre.nom,
                  child: Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10)),
                      image: DecorationImage(
                        image: AssetImage("assets/images/astres/moon.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: const SizedBox(
                      width: 60,
                      height: 60,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(astre.nom,
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      Text(astre.constellation,
                          style: const TextStyle(
                              color: Colors.black87, fontSize: 13)),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: IconButton(
                    icon: Icon(astre.fav
                        ? Icons.favorite_outlined
                        : Icons.favorite_outline_outlined),
                    color: Colors.black,
                    onPressed: () {},
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(Icons.chevron_right_rounded, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
