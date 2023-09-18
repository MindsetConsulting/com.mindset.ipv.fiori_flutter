import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ObjectDetailPage extends StatefulWidget {
  final Map<String, dynamic> item;
  final Function(Map<String, dynamic>) updateItemStatus;
  final Function(int) onQuantityChanged;

  const ObjectDetailPage({
    Key? key,
    required this.item,
    required this.updateItemStatus,
    required this.onQuantityChanged,
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

  void _editItem() async {
    final updatedItem = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditPage(item: widget.item),
      ),
    );

    if (updatedItem != null) {
      setState(() {
        widget.item.clear();
        widget.item.addAll(updatedItem);
      });
    }
  }

  void _updateItem(Map<String, dynamic> updatedItem) {
    setState(() {
      widget.item.clear();
      widget.item.addAll(updatedItem);
    });
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
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 70,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 0, horizontal: 16.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          key: ValueKey(widget.item[
                              'quantity']), // Define a ValueKey for the CircleAvatar widget
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
                        Column(
                          children: [
                            const SizedBox(
                              height: 12,
                            ),
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
                            const SizedBox(height: 8),
                            Text(
                              widget.item['priority']!,
                              style: TextStyle(
                                fontSize: 12,
                                color: widget.item['priority'] == 'Low'
                                    ? Colors.black
                                    : widget.item['priority'] == 'Medium'
                                        ? Colors.black
                                        : Colors.red,
                              ),
                            ),
                          ],
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
                        'Supplier Information',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
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
                      const SizedBox(height: 20),
                      Text(
                        '${widget.item['phone']}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${widget.item['email']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontStyle: FontStyle.italic,
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
              const SizedBox(height: 10),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Assigned Employee',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          widget.item['assignedEmployee'][0]['name'] != ''
                              ? const CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2amYoC3Sbo7zXr6dYH5hDE2_QyzGPO7Jd1w&usqp=CAU',
                                  ),
                                )
                              : const SizedBox(),
                          const SizedBox(width: 16),
                          widget.item['assignedEmployee'][0]['name'] != ''
                              ? Text(
                                  '${widget.item['assignedEmployee'][0]['name']}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                )
                              : const Text(
                                  'No employee currently assigned',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(height: 2),
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
                padding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
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
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            String noteText = '';
                            return AlertDialog(
                              title: const Text('Add Note'),
                              content: TextField(
                                maxLines: null,
                                onChanged: (value) {
                                  noteText = value;
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    final now = DateTime.now();
                                    final date =
                                        DateFormat('M/d/yyyy').format(now);
                                    final newNote = {
                                      'text': noteText,
                                      'date': date,
                                    };
                                    setState(() {
                                      widget.item['notes'].add(newNote);
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Add Note'),
                                ),
                              ],
                            );
                          },
                        );
                      },
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
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16.0),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.item['notes'].length,
                  itemBuilder: (BuildContext context, int index) {
                    final note = widget.item['notes'][index];
                    final date = DateFormat('MM/dd/yyyy')
                        .format(DateFormat('MM/dd/yyyy').parse(note['date']));
                    return Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: ListTile(
                                title: Text(
                                  note['text'],
                                  style: const TextStyle(fontSize: 12),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                date,
                                style: const TextStyle(
                                  fontSize: 12,
                                ),
                                textAlign: TextAlign.right,
                              ),
                            ),
                          ],
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
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPage(item: widget.item),
                  ),
                );
              },
              icon: const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
            ),
            IconButton(
              onPressed: () {
                final TextEditingController controller = TextEditingController(
                  text: widget.item['quantity'].toString(),
                );
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Quantity'),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              int quantity = int.parse(controller.text);
                              quantity--;
                              controller.text = quantity.toString();
                            },
                            icon: const Icon(Icons.remove),
                          ),
                          SizedBox(
                            width: 50,
                            child: Container(
                              child: TextField(
                                controller: controller,
                                textAlign: TextAlign.center,
                                keyboardType: TextInputType.number,
                                onChanged: (String value) {
                                  setState(() {
                                    widget.item['quantity'] = int.parse(value);
                                  });
                                },
                                style: const TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              int quantity = int.parse(controller.text);
                              quantity++;
                              controller.text = quantity.toString();
                            },
                            icon: const Icon(Icons.add),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            int newQuantity = int.parse(controller.text);
                            widget.item['quantity'] = newQuantity;
                            widget.onQuantityChanged(newQuantity);
                            setState(() {});
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.format_list_numbered,
                color: Colors.blue,
              ),
            ),
            _status == 'Approved' || _status == 'Rejected'
                ? const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      _showConfirmationDialog('Reject');
                    },
                    icon: const Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                  ),
            _status == 'Approved' || _status == 'Rejected'
                ? const IconButton(
                    onPressed: null,
                    icon: Icon(
                      Icons.check,
                      color: Colors.grey,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      _showConfirmationDialog('Approve');
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class EditPage extends StatefulWidget {
  final Map<String, dynamic> item;

  const EditPage({Key? key, required this.item}) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late Map<String, dynamic> item;
  final _formKey = GlobalKey<FormState>();
  late String _street;
  late String _city;
  late String _state;
  late String _zipCode;
  late String _country;
  late String _phone;
  late String _email;

  @override
  void initState() {
    super.initState();
    item = widget.item;
    _street = item['street'];
    _city = item['city'] ?? '';
    _state = item['state'] ?? '';
    _zipCode = item['zipCode'] ?? '';
    _country = item['country'];
    _phone = item['phone'];
    _email = item['email'];
  }

  void _saveItem() {
    item['street'] = _street;
    item['city'] = _city;
    item['state'] = _state;
    item['zipCode'] = _zipCode;
    item['country'] = _country;
    item['phone'] = _phone;
    item['email'] = _email;
    Navigator.pop(context, item);
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
          'Edit Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 0, horizontal: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            key: ValueKey(widget.item['quantity']),
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
                          Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              // Icon(
                              //   _status == 'Approved'
                              //       ? Icons.check_circle_outline_rounded
                              //       : _status == 'Pending'
                              //           ? Icons.pending_actions
                              //           : Icons.cancel_outlined,
                              //   color: _status == 'Approved'
                              //       ? Colors.green
                              //       : _status == 'Pending'
                              //           ? Colors.blue
                              //           : Colors.red,
                              // ),
                              const SizedBox(height: 8),
                              Text(
                                widget.item['priority']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: widget.item['priority'] == 'Low'
                                      ? Colors.black
                                      : widget.item['priority'] == 'Medium'
                                          ? Colors.black
                                          : Colors.red,
                                ),
                              ),
                            ],
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
                          'Supplier Information',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          initialValue: _street,
                          decoration: const InputDecoration(
                            labelText: 'Street',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a street';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _street = value!;
                          },
                        ),
                        const SizedBox(height: 2),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                initialValue: _city,
                                decoration: const InputDecoration(
                                  labelText: 'City',
                                ),
                                onSaved: (value) {
                                  _city = value!;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _state,
                                decoration: const InputDecoration(
                                  labelText: 'State',
                                ),
                                onSaved: (value) {
                                  _state = value!;
                                },
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: TextFormField(
                                initialValue: _zipCode,
                                decoration: const InputDecoration(
                                  labelText: 'Zip Code',
                                ),
                                onSaved: (value) {
                                  _zipCode = value!;
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        TextFormField(
                          initialValue: _country,
                          decoration: const InputDecoration(
                            labelText: 'Country',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a country';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _country = value!;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          initialValue: _phone,
                          decoration: const InputDecoration(
                            labelText: 'Phone',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _phone = value!;
                          },
                        ),
                        const SizedBox(height: 2),
                        TextFormField(
                          initialValue: _email,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
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
                const SizedBox(height: 10),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 16.0),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Assigned Employee',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            widget.item['assignedEmployee'][0]['name'] != ''
                                ? const CircleAvatar(
                                    backgroundImage: NetworkImage(
                                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2amYoC3Sbo7zXr6dYH5hDE2_QyzGPO7Jd1w&usqp=CAU',
                                    ),
                                  )
                                : const SizedBox(),
                            const SizedBox(width: 16),
                            widget.item['assignedEmployee'][0]['name'] != ''
                                ? Text(
                                    '${widget.item['assignedEmployee'][0]['name']}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                    ),
                                  )
                                : const Text(
                                    'No employee currently assigned',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                          ],
                        ),
                        const SizedBox(height: 2),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Cancel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Save',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            _saveItem();
          }
        },
      ),
    );
  }
}
