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
  final List<Map<String, dynamic>> _items = [
    {
      'id': '0',
      'item': 'Stuff',
      'description': 'my stuff',
      'additionalInfo': 'don\'t touch my stuff',
      'status': 'Approved',
      'street': '123 Main St',
      'city': 'Anytown',
      'state': 'CA',
      'zipCode': '12345',
      'country': 'USA',
      'quantity': 1,
      'notes': [
        {'text': 'This is a note'},
        {'text': 'This is another note'},
      ],
    },
    {
      'id': '1',
      'item': 'Things',
      'description': 'your things',
      'additionalInfo': 'all your things are belong to us',
      'status': 'Rejected',
      'street': '456 Main St',
      'city': 'Anytown',
      'state': 'CA',
      'zipCode': '12345',
      'country': 'USA',
      'quantity': 5,
      'notes': [
        {'text': 'This is a note'},
      ],
    },
    {
      'id': '2',
      'item': 'Product',
      'description': 'our product',
      'additionalInfo': 'this is the best product',
      'status': 'Pending',
      'street': '789 Main St',
      'city': 'Anytown',
      'state': 'CA',
      'zipCode': '12345',
      'country': 'USA',
      'quantity': 10,
      'notes': [
        {'text': 'This is a note'},
      ],
    },
  ];

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
                  _items.add({
                    'id': _items.length.toString(),
                    'item': item,
                    'description': description,
                    'additionalInfo': additionalInfo,
                    'status': 'Pending',
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
                  return const SizedBox.shrink();
                }
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  leading: isEditing
                      ? Checkbox(
                          value: _items[index]['isChecked'] == 'true',
                          onChanged: (value) {
                            setState(() {
                              _items[index]['isChecked'] = value.toString();
                            });
                          },
                        )
                      : CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${_items[index]['quantity']}',
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
                              _items[index]['item']!,
                              style: const TextStyle(
                                fontFamily: 'SAP72',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _items[index]['description']!,
                              style: const TextStyle(
                                fontFamily: 'SAP72',
                              ),
                            ),
                            Text(
                              _items[index]['additionalInfo']!,
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
                            _items[index]['status'] == 'Approved'
                                ? Icons.check_circle_outline_rounded
                                : _items[index]['status'] == 'Pending'
                                    ? Icons.pending_actions
                                    : Icons.cancel_outlined,
                            color: _items[index]['status'] == 'Approved'
                                ? Colors.green
                                : _items[index]['status'] == 'Pending'
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
                                    item: _items[index],
                                    updateItemStatus: (updatedItem) {
                                      setState(() {
                                        int index = _items.indexWhere((item) =>
                                            item['id'] == updatedItem['id']);
                                        _items[index] = updatedItem;
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
                                      _items.removeWhere((item) =>
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

class ObjectDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) updateItemStatus;

  const ObjectDetailPage({
    Key? key,
    required this.item,
    required this.updateItemStatus,
  }) : super(key: key);

  @override
  _ObjectDetailPageState createState() => _ObjectDetailPageState();
}

class _ObjectDetailPageState extends State<ObjectDetailPage> {
  String _status = '';

  @override
  void initState() {
    super.initState();
    _status = widget.item['status']!;
  }

  void _updateStatus(String newStatus) {
    setState(() {
      _status = newStatus;
    });
    widget.updateItemStatus({...widget.item, 'status': newStatus});
  }

  void _showConfirmationDialog(String action) {
    String title = '';
    String message = '';
    String confirmText = '';

    if (action == 'Approve') {
      title = 'Confirm Approval';
      message = 'Are you sure you want to approve this item?';
      confirmText = 'Approve';
    } else if (action == 'Reject') {
      title = 'Confirm Rejection';
      message = 'Are you sure you want to reject this item?';
      confirmText = 'Reject';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (action == 'Approve') {
                  _updateStatus('Approved');
                } else if (action == 'Reject') {
                  _updateStatus('Rejected');
                }
                Navigator.of(context).pop();
              },
              child: Text(confirmText),
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
        leading: IconButton(
          icon: const Row(
            children: [
              Icon(
                Icons.arrow_back_ios,
                color: Colors.blue,
              ),
            ],
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontFamily: 'SAP72',
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              'Edit',
              style: TextStyle(
                fontFamily: 'SAP72',
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: Center(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          '${widget.item['quantity']}',
                          style: const TextStyle(
                            fontFamily: 'SAP72',
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.item['item']}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.item['description']}',
                              style: const TextStyle(
                                fontSize: 14,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${widget.item['additionalInfo']}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Icon(
                        _status == 'Approved'
                            ? Icons.check_circle_outline_rounded
                            : _status == 'Pending'
                                ? Icons.pending_actions
                                : Icons.cancel_outlined,
                        color: _status == 'Approved'
                            ? Colors.green
                            : _status == 'Pending'
                                ? Colors.blue
                                : Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              height: 30,
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.item['street']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.item['city']?.isNotEmpty ?? false ? '${widget.item['city']}, ' : ''}${widget.item['state']?.isNotEmpty ?? false ? '${widget.item['state']}, ' : ''}${widget.item['zipCode']?.isNotEmpty ?? false ? '${widget.item['zipCode']}' : ''}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${widget.item['country']}',
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Notes',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.add),
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              height: 2,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.item['notes'].length,
                itemBuilder: (BuildContext context, int index) {
                  final note = widget.item['notes'][index];
                  return Column(
                    children: [
                      ListTile(
                        title: Text(
                          note['text'],
                          style: const TextStyle(fontSize: 14),
                        ),
                      ),
                      if (index != widget.item['notes'].length - 1)
                        const Divider(
                          color: Color.fromARGB(255, 226, 225, 225),
                          height: 1,
                          thickness: 1,
                        ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              color: Colors.grey[200],
              height: 30,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _status == 'Approved' || _status == 'Rejected'
                ? const TextButton(
                    onPressed: null,
                    child: Text(
                      'Reject',
                      style: TextStyle(
                        fontFamily: 'SAP72',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _showConfirmationDialog('Reject');
                    },
                    child: const Text(
                      'Reject',
                      style: TextStyle(
                        fontFamily: 'SAP72',
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ),
            _status == 'Approved' || _status == 'Rejected'
                ? const TextButton(
                    onPressed: null,
                    child: Text(
                      'Approve',
                      style: TextStyle(
                        fontFamily: 'SAP72',
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : TextButton(
                    onPressed: () {
                      _showConfirmationDialog('Approve');
                    },
                    child: const Text(
                      'Approve',
                      style: TextStyle(
                        fontFamily: 'SAP72',
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
