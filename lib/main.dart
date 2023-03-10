import 'package:app_theme/theme_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeNotifier>.value(
          value: ThemeNotifier(),
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: context.watch<ThemeNotifier>().theme,
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  TabController _tabController;
  int _currentTabIndex = 0;
  bool _isLoading = false;
  List<Map<String, Object>> _chips = [
    {'name': 'News', 'isSelect': false},
    {'name': 'Book', 'isSelect': true},
    {'name': 'Games', 'isSelect': true},
    {'name': 'Messages', 'isSelect': false},
    {'name': 'People', 'isSelect': false}
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme app'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeNotifier>().changeTheme();
            },
            icon: Icon(Icons.save_alt),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (currentIndex) {
          _tabController.index = currentIndex;
          setState(() {
            _currentTabIndex = currentIndex;
            _tabController.animateTo(_currentTabIndex);
          });
        },
        currentIndex: _currentTabIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          )
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '???????????? ??????????????',
                style: Theme.of(context).textTheme.headline4,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: '?????????? ??????????????',
                          suffixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    TextButton(
                      child: Text('???????????????? ??????????'),
                      onPressed: () async {
                        setState(() => _isLoading = true);
                        await Future.delayed(Duration(seconds: 1));
                        setState(() => _isLoading = false);
                      },
                    ),
                  ],
                ),
              ),
              if (_isLoading)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: CircularProgressIndicator(),
                ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: List.generate(
                    8,
                    (index) => Card(
                      child: Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Container(
                              width: double.infinity,
                              child: Image.asset(
                                'assets/images/img_${index + 1}.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('?????????????? ???????????????? ????????????????'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).toList(),
                ),
              ),
            ],
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 12,
                children: [
                  ..._chips
                      .map(
                        (item) => FilterChip(
                          onSelected: (v) {
                            setState(() {
                              item['isSelect'] = v;
                            });
                          },
                          selected: item['isSelect'],
                          label: Text(item['name']),
                        ),
                      )
                      .toList(),
                  FilterChip(
                    onSelected: null,
                    label: Text('City'),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          actions: [
                            TextButton(
                              child: Text('????'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text('??????'),
                              onPressed: () async {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                          title: Text('?????????????? ????????????'),
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: 40,
                    child: Text('AB'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
