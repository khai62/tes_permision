import 'package:flutter/material.dart';

class Pesan extends StatefulWidget {
  @override
  _PesanState createState() => _PesanState();
}

class _PesanState extends State<Pesan> {
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedStartTime = TimeOfDay.now();
  TimeOfDay _selectedEndTime = TimeOfDay.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != _selectedDate) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedStartTime,
    );
    if (pickedTime != null && pickedTime != _selectedStartTime) {
      setState(() {
        _selectedStartTime = pickedTime;
        // Reset _selectedEndTime to ensure end time is always after start time
        if (_selectedEndTime.hour < _selectedStartTime.hour ||
            (_selectedEndTime.hour == _selectedStartTime.hour &&
                _selectedEndTime.minute < _selectedStartTime.minute)) {
          _selectedEndTime = _selectedStartTime;
        }
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedEndTime,
    );
    if (pickedTime != null &&
        (pickedTime.hour > _selectedStartTime.hour ||
            (pickedTime.hour == _selectedStartTime.hour &&
                pickedTime.minute > _selectedStartTime.minute))) {
      setState(() {
        _selectedEndTime = pickedTime;
      });
    } else {
      // Show error if end time is before start time
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Jam berakhir tidak boleh kurang dari jam mulai'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jadwal Penjualan'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              'Tanggal: ${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            ),
            SizedBox(height: 20),
            Text(
              'Jam Mulai: ${_selectedStartTime.hour}:${_selectedStartTime.minute}',
            ),
            SizedBox(height: 20),
            Text(
              'Jam Berakhir: ${_selectedEndTime.hour}:${_selectedEndTime.minute}',
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Pilih Tanggal'),
            ),
            ElevatedButton(
              onPressed: () => _selectStartTime(context),
              child: Text('Pilih Jam Mulai'),
            ),
            ElevatedButton(
              onPressed: () => _selectEndTime(context),
              child: Text('Pilih Jam Berakhir'),
            ),
          ],
        ),
      ),
    );
  }
}
