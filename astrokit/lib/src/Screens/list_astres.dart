import 'package:astrokit/src/Screens/astre_detail.dart';
import 'package:astrokit/src/Shared/app_bar.dart';
import 'package:astrokit/src/class/astres.dart';
import 'package:astrokit/src/utils/capitalize.dart';
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
  dynamic _searchBar = 'Liste des astres';
  Icon _favIcon = const Icon(Icons.favorite_outline_outlined);

  @override
  initState() {
    super.initState();
    _astres = Astre.getAstres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(
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
        context: context,
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
                  child: ListTile(
                    style: ListTileStyle.drawer,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: const BorderSide(color: Colors.white, width: 1),
                    ),
                    tileColor: const Color(0xffA6885C),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(astre.fav
                              ? Icons.favorite
                              : Icons.favorite_outline_outlined),
                          color: Colors.black,
                          onPressed: () {
                            setState(() {
                              _astres = Astre.updateFav(astre,
                                  fav: _favIcon.icon == Icons.favorite);
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
                    title: Text(
                      astre.nom.toString().capitalize(),
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    subtitle: Text(astre.categorie.toString().capitalize(),
                        style: Theme.of(context).textTheme.bodyText2),
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
