import 'package:flutter/material.dart';
import 'package:test_app/core/models/employee_model.dart';
import 'package:test_app/manager/font_manager.dart';
import 'package:test_app/manager/space_manger.dart';
import 'package:test_app/widgets/detail_tile.dart';

class DetailsScreen extends StatelessWidget {
  final EmployeeModel employee;
  const DetailsScreen({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          employee.name ?? '',
          style: appFont.f20w500Black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                  'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png'),
            ),
            appSpaces.spaceForHeight10,
            Text(
              employee.name ?? '',
              style: appFont.f17w500Primary,
            ),
            appSpaces.spaceForHeight10,
            DetailTile(
              icon: Icons.email,
              title: employee.email ?? '',
            ),
            DetailTile(
              icon: Icons.location_on,
              title: employee.address!.street ?? '',
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.address!.suite ?? ''),
                  Text(
                    '${employee.address!.city ?? ''}, ${employee.address!.zipcode ?? ''}',
                  ),
                ],
              ),
            ),
            DetailTile(icon: Icons.phone, title: employee.phone ?? ''),
            DetailTile(icon: Icons.web, title: employee.website ?? ''),
            DetailTile(
              icon: Icons.business,
              title: employee.company!.name ?? '',
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(employee.company!.bs ?? ''),
                  appSpaces.spaceForHeight5,
                  Text(employee.company!.catchPhrase ?? ''),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
