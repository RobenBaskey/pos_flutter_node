import 'package:flutter/material.dart';
import 'package:pos/core/constants/app_sizes.dart';
import 'package:pos/presentations/widgets/custom_button.dart';
import 'package:pos/presentations/widgets/custom_text_field.dart';

import '../../widgets/custom_container_shape.dart';
import '../../widgets/custom_divider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: CustomContainerShape(
          padding: 0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 14,
                ),
                child: Text(
                  "Company Information",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                ),
              ),
              CustomDivider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Comapany Name *"),
                                  SizedBox(height: 4),
                                  CustomTextField(
                                    hintText: "",
                                    borderRadius: 8,
                                    borderColor: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Email "),
                                  SizedBox(height: 4),
                                  CustomTextField(
                                    hintText: "",
                                    borderRadius: 8,
                                    borderColor: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Phone *"),
                                  SizedBox(height: 4),
                                  CustomTextField(
                                    hintText: "",
                                    borderRadius: 8,
                                    borderColor: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Address"),
                                  SizedBox(height: 4),
                                  CustomTextField(
                                    hintText: "",
                                    borderRadius: 8,
                                    borderColor: Theme.of(
                                      context,
                                    ).colorScheme.outline,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Description"),
                            SizedBox(height: 4),
                            CustomTextField(
                              hintText: "",
                              maxLines: 4,
                              borderRadius: 8,
                              borderColor: Theme.of(
                                context,
                              ).colorScheme.outline,
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  height: getWidth(80),
                                  width: getWidth(80),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.outline,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Icon(Icons.image),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      onPressed: () {},
                                      label: Text("Change Logo"),
                                      icon: Icon(Icons.upload_outlined),
                                    ),
                                    SizedBox(width: 10),
                                    TextButton.icon(
                                      onPressed: () {},
                                      label: Text(
                                        "Delete Logo",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                    height: getWidth(80),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.outline,
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Icon(Icons.image),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed: () {},
                                        label: Text("Change Banner"),
                                        icon: Icon(Icons.upload_outlined),
                                      ),
                                      SizedBox(width: 10),
                                      TextButton.icon(
                                        onPressed: () {},
                                        label: Text(
                                          "Delete Banner",
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40),
                        Align(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: getWidth(60),
                            child: CustomButton(
                              onTap: () {},
                              title: "Save Changes",
                              borderRadius: 8,
                            ),
                          ),
                        ),
                        SizedBox(height: 60),
                      ],
                    ),
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
