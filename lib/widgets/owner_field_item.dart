// ignore_for_file: prefer_const_constructors, deprecated_member_use, avoid_print, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/field_edit.dart';
import '../providers/fields.dart';

class FieldItem extends StatelessWidget {
  final int id;
  final String name;
  final String adresse;
  final String type;
  final String isNotAvailable;
  final String services;
  final double price;
  final String period;
  final String surface;
  final String description;
  final int idProprietaire;

  FieldItem(
      this.id,
      this.name,
      this.adresse,
      this.type,
      this.isNotAvailable,
      this.services,
      this.price,
      this.period,
      this.surface,
      this.description,
      this.idProprietaire);

  @override
  Widget build(BuildContext context) {
    final scaffold = Scaffold.of(context);
    print(id);
    return ListTile(
      title: Text(name),
      // leading: const CircleAvatar(
      //   backgroundImage: NetworkImage("https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.istockphoto.com%2Ffr%2Fphotos%2Ftennis-court&psig=AOvVaw04ePjMLsUDoC5QPP7h_07Z&ust=1649552904800000&source=images&cd=vfe&ved=0CAoQjRxqFwoTCNDC3MrlhfcCFQAAAAAdAAAAABAD"),
      // ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditFieldList.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                try {
                  await Provider.of<Fields>(context, listen: false)
                      .deleteField(id);
                } catch (error) {
                  scaffold.showSnackBar(
                    SnackBar(
                      content: Text(
                        'Deleting failed!',
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
