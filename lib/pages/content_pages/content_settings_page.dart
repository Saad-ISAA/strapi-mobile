import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/on_off_button.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class ContentPageSettings extends StatefulWidget {
  const ContentPageSettings({Key key}) : super(key: key);

  @override
  _ContentPageSettingsState createState() => _ContentPageSettingsState();
}

class _ContentPageSettingsState extends State<ContentPageSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neutral100,
      appBar: AppBar(
        title: Text('Configure Content View'),
      ),
      body: Container(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              'Define the settings of the list view.'
                  .text
                  .xl
                  .color(neutral600)
                  .make(),
              Card(
                margin: EdgeInsets.all(0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    'Settings'.text.xl2.semiBold.make(),
                    24.heightBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Enable Search'.text.medium.make(),
                        StrapiSwitch(),
                      ],
                    ),
                    24.widthBox,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        'Enable Filters'.text.medium.make(),
                        StrapiSwitch(),
                      ],
                    ),
                    12.heightBox,
                    'Enable Bulk Actions'.text.medium.make(),
                    StrapiSwitch(),
                    12.heightBox,
                    'Entries per page'.text.medium.make().py(4),
                    StrapiDropdown(
                      value: 5,
                      onChanged: (v) {},
                      items: [
                        DropdownMenuItem(
                          child: Text('1'),
                          value: 1,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('2'),
                          value: 2,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('3'),
                          value: 3,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('4'),
                          value: 4,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('5'),
                          value: 5,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('6'),
                          value: 6,
                          onTap: () {},
                        ),
                      ],
                    ),
                    4.heightBox,
                    'Note: You can override this value in the Collection Type settings page.'
                        .text
                        .sm
                        .make(),
                    16.heightBox,
                    'Default sort attribute'.text.medium.make().py(4),
                    StrapiDropdown(
                      value: 1,
                      onChanged: (v) {},
                      items: [
                        DropdownMenuItem(
                          child: Text('Username'),
                          value: 1,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('ID'),
                          value: 2,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('Paassword'),
                          value: 3,
                          onTap: () {},
                        ),
                      ],
                    ),
                    16.heightBox,
                    'Default sort order'.text.medium.make().py(4),
                    StrapiDropdown(
                      value: 1,
                      onChanged: (v) {},
                      items: [
                        DropdownMenuItem(
                          child: Text('ASC'),
                          value: 1,
                          onTap: () {},
                        ),
                        DropdownMenuItem(
                          child: Text('DESC'),
                          value: 2,
                          onTap: () {},
                        ),
                      ],
                    ),
                    12.heightBox,
                    'View'.text.xl2.semiBold.make().py(8),
                    DottedBorder(
                        color: neutral500,
                        radius: Radius.circular(8),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          height: 55,
                          child: Row(
                            children: [
                              Flexible(
                                child: ReorderableListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      CustomViewChip(
                                        key: Key('1'),
                                        text: 'Id',
                                      ),
                                      CustomViewChip(
                                        key: Key('2'),
                                        text: 'Username',
                                      ),
                                      CustomViewChip(
                                        key: Key('3'),
                                        text: 'Email',
                                      ),
                                      CustomViewChip(
                                        key: Key('4'),
                                        text: 'Confirmed',
                                      ),
                                    ],
                                    onReorder: (i, f) {}),
                              ),
                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  border:
                                      Border.all(width: 0.3, color: neutral400),
                                ),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(4),
                                  onTap: () {},
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: neutral600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                  ],
                ).p(12),
              ).py(16),
              16.heightBox,
              PrimarySquareButton(
                onPressed: () {},
                color: Theme.of(context).colorScheme.secondary,
                text: 'Save',
              ),
            ],
          ).p(16),
        ),
      ),
    );
  }
}

class CustomViewChip extends StatelessWidget {
  final String text;
  const CustomViewChip({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 8),
      height: 35,
      decoration: BoxDecoration(
          border: Border.all(width: 0.3, color: neutral400),
          color: neutral100,
          borderRadius: BorderRadius.circular(4)),
      child: Row(
        children: [
          Icon(
            Icons.drag_indicator_outlined,
            size: 18,
          ).px(6),
          Container(
            decoration: BoxDecoration(
              color: neutral500,
            ),
            height: 35,
            width: 0.5,
          ),
          12.widthBox,
          text.text.xl.make(),
          SizedBox(
            width: 22,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.edit),
              iconSize: 17,
            ),
          ),
          SizedBox(
            width: 22,
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.close),
              iconSize: 20,
            ),
          ),
          8.widthBox,
        ],
      ),
    );
  }
}
