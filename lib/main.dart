import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ListReportPage(),
    );
  }
}

class ListReportPage extends StatefulWidget {
  const ListReportPage({Key? key}) : super(key: key);

  @override
  _ListReportPageState createState() => _ListReportPageState();
}

class _ListReportPageState extends State<ListReportPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchText = '';
  List<Map<String, String>> _items = [];
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {
        _searchText = _searchController.text;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _showAddItemDialog() {
    String item = '';
    String description = '';
    String additionalInfo = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Add Item',
            style: TextStyle(
              fontFamily: 'SAP72',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Item',
                ),
                onChanged: (value) {
                  item = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Description',
                ),
                onChanged: (value) {
                  description = value;
                },
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Additional Information',
                ),
                onChanged: (value) {
                  additionalInfo = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'SAP72',
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _items.add({
                    'item': item,
                    'description': description,
                    'additionalInfo': additionalInfo,
                  });
                });
                Navigator.pop(context);
              },
              child: Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'SAP72',
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'List Report',
          style: TextStyle(
            fontFamily: 'SAP72',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 32,
              color: Colors.blue,
            ),
            onPressed: () {
              _showAddItemDialog();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                fontFamily: 'SAP72',
                fontStyle: FontStyle.italic,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[300],
              ),
            ),
          ),
          SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: _items.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 0,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                if (_searchText.isNotEmpty &&
                    !(_items[index]['item']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        _items[index]['description']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        _items[index]['additionalInfo']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))) {
                  return SizedBox.shrink();
                }
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Text(
                      '$index',
                      style: TextStyle(
                        fontFamily: 'SAP72',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _items[index]['item']!,
                        style: TextStyle(
                          fontFamily: 'SAP72',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _items[index]['description']!,
                        style: TextStyle(
                          fontFamily: 'SAP72',
                        ),
                      ),
                      Text(
                        _items[index]['additionalInfo']!, // Modified line
                        style: TextStyle(
                            fontFamily: 'SAP72',
                            fontSize: 12,
                            color: Colors.grey,
                            fontStyle: FontStyle.italic),
                      ),
                    ],
                  ),
                  trailing: IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.grey[300],
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ObjectDetailPage(index: index),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: const Color.fromARGB(161, 224, 224, 224),
                width: 1.0,
              ),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  if (isEditing) {
                    setState(() {
                      isEditing = !isEditing;
                    });
                  } else {
                    // Filter button functionality here
                  }
                },
                child: Text(
                  isEditing ? 'Cancel' : 'Filter',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'SAP72',
                    fontSize: 16,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },
                child: Text(
                  isEditing ? 'Delete' : 'Edit',
                  style: TextStyle(
                    color: Colors.blue,
                    fontFamily: 'SAP72',
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ObjectDetailPage extends StatelessWidget {
  final int index;

  const ObjectDetailPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
              // Text(
              //   'Back',
              //   style: TextStyle(
              //     fontFamily: 'SAP72',
              //     fontWeight: FontWeight.bold,
              //     color: Colors.blue,
              //   ),
              // ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Object $index Details',
          style: TextStyle(
            fontFamily: 'SAP72',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              size: 32,
              color: Colors.blue,
            ),
            onPressed: () {
              // Add button functionality here
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Details for Object $index',
          style: TextStyle(
            fontFamily: 'SAP72',
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
