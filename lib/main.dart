import 'package:flutter/material.dart';
import 'data.dart';
import 'object_detail.dart';

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
    int quantity = 1;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Add Item',
            style: TextStyle(
              fontFamily: 'SAP72',
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Item',
                  ),
                  onChanged: (value) {
                    item = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Description',
                  ),
                  onChanged: (value) {
                    description = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Additional Information',
                  ),
                  onChanged: (value) {
                    additionalInfo = value;
                  },
                ),
                DropdownButtonFormField<int>(
                  value: quantity,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                  ),
                  items: List.generate(10, (index) => index + 1)
                      .map((value) => DropdownMenuItem<int>(
                            value: value,
                            child: Text(value.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    quantity = value!;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.blue,
                  fontFamily: 'SAP72',
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  items.add({
                    'id': items.length.toString(),
                    'item': item,
                    'description': description,
                    'additionalInfo': additionalInfo,
                    'status': 'Pending',
                    'priority': 'Low',
                    'street': '',
                    'city': '',
                    'state': '',
                    'zipCode': '',
                    'country': ' ',
                    'quantity': quantity.toString(),
                    'notes': '[]',
                  });
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Add Item',
                style: TextStyle(
                  color: Colors.white,
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
        title: const Text(
          'Product List',
          style: TextStyle(
            fontFamily: 'SAP72',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
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
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _searchController,
              style: const TextStyle(
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
          const SizedBox(height: 8),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (BuildContext context, int index) {
                return Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                  height: 0,
                );
              },
              itemBuilder: (BuildContext context, int index) {
                if (_searchText.isNotEmpty &&
                    !(items[index]['item']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        items[index]['description']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()) ||
                        items[index]['additionalInfo']!
                            .toLowerCase()
                            .contains(_searchText.toLowerCase()))) {
                  return const SizedBox.shrink();
                }
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  leading: isEditing
                      ? Checkbox(
                          value: items[index]['isChecked'] == 'true',
                          onChanged: (value) {
                            setState(() {
                              items[index]['isChecked'] = value.toString();
                            });
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${items[index]['quantity']}',
                            style: const TextStyle(
                              fontFamily: 'SAP72',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              items[index]['item']!,
                              style: const TextStyle(
                                fontFamily: 'SAP72',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              items[index]['description']!,
                              style: const TextStyle(
                                fontFamily: 'SAP72',
                              ),
                            ),
                            Text(
                              items[index]['additionalInfo']!,
                              style: const TextStyle(
                                  fontFamily: 'SAP72',
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            items[index]['status'] == 'Approved'
                                ? Icons.check_circle_outline_rounded
                                : items[index]['status'] == 'Pending'
                                    ? Icons.pending_actions
                                    : Icons.cancel_outlined,
                            color: items[index]['status'] == 'Approved'
                                ? Colors.green
                                : items[index]['status'] == 'Pending'
                                    ? Colors.blue
                                    : Colors.red,
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            iconSize: 20,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey[300],
                            ),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ObjectDetailPage(
                                    item: items[index],
                                    onQuantityChanged: (int newQuantity) {
                                      setState(() {
                                        items[index]['quantity'] =
                                            newQuantity;
                                      });
                                    },
                                    updateItemStatus: (updatedItem) {
                                      setState(() {
                                        int index = items.indexWhere((item) =>
                                            item['id'] == updatedItem['id']);
                                        items[index] = updatedItem;
                                      });
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
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
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Color.fromARGB(161, 224, 224, 224),
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
                  style: const TextStyle(
                    color: Colors.blue,
                    fontFamily: 'SAP72',
                    fontSize: 16,
                  ),
                ),
              ),
              !isEditing
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          isEditing = !isEditing;
                        });
                      },
                      child: const Text(
                        'Edit',
                        style: TextStyle(
                          color: Colors.blue,
                          fontFamily: 'SAP72',
                          fontSize: 16,
                        ),
                      ),
                    )
                  : TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text(
                                  'Are you sure you want to delete the item?'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      items.removeWhere((item) =>
                                          item['isChecked'] == 'true');
                                      isEditing = false;
                                    });
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text(
                        'Delete',
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
