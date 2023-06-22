import 'package:dictionary/pages/home/dictionary_page.dart';
import 'package:dictionary/pages/home/favoritos/favoritos_page.dart';
import 'package:dictionary/pages/home/history/history_page.dart';
import 'package:dictionary/utils/prefs.dart';
import 'package:dictionary/widgets/drawer_list.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin<HomePage> {
  TabController? _tabController;
  late int tabIdx;

  @override
  void initState() {
    super.initState();

    _initTabs();
  }

  _initTabs() async {
    // Busca o índice nas prefs.
    tabIdx = await Prefs.getInt("tabIdx");

    _tabController = TabController(length: 3, vsync: this);

    // Agora que temos o TabController e o índice da tab,
    // chama o setState para redesenhar a tela
    setState(() {
      _tabController!.index = tabIdx;
    });

    _tabController!.addListener(() {
      Prefs.setInt("tabIdx", _tabController!.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerList(),
      appBar: AppBar(
        title: const Text("WordWise"),
        bottom: _tabController == null
            ? null
            : TabBar(
                controller: _tabController,
                tabs: const [
                  Tab(text: "Word list", icon: Icon(Icons.list_alt_rounded)),
                  Tab(text: "Favorites", icon: Icon(Icons.favorite_rounded)),
                  Tab(text: "History", icon: Icon(Icons.history_rounded)),
                ],
              ),
      ),
      body: _tabController == null
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : TabBarView(
              controller: _tabController,
              children: [
                DictionaryPage(),
                FavoritesPage(),
                HistoryPage(),
              ],
            ),
    );
  }
}
