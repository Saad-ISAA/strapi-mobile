import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dropdown.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/apiTokensController.dart';
import 'package:strapi_flutter_cms/models/apiToken.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class APITokenDetailsScreen extends StatefulWidget {
  const APITokenDetailsScreen({Key key, this.apiTokenId}) : super(key: key);
  final int apiTokenId;

  @override
  _APITokenDetailsScreenState createState() => _APITokenDetailsScreenState();
}

var tokenTypes = {'read-only': 0, 'full-access': 1};

class _APITokenDetailsScreenState extends State<APITokenDetailsScreen> {
  var nameController = TextEditingController();
  var descriptionController = TextEditingController();

  int selectedTokenType = 0;

  ApiToken apiToken;
  bool loading = false;

  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });

    fetchApiTokenDetails(widget.apiTokenId).then((value) {
      setState(() {
        apiToken = value;
      });

      nameController.text = value.name;
      descriptionController.text = value.description;
      selectedTokenType = tokenTypes[value.type];
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Token Details'),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            margin: EdgeInsets.all(0),
            elevation: 2,
            child: Row(
              children: [
                Container(
                    height: 65,
                    width: 65,
                    decoration: BoxDecoration(
                        color: neutral150,
                        borderRadius: BorderRadius.circular(4)),
                    child: SvgPicture.asset('assets/icons/api_key.svg').p(8)),
                12.widthBox,
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "This token isn't accessible anymore."
                          .text
                          .sm
                          .semiBold
                          .make(),
                      6.heightBox,
                      "For security reasons, you can only see your token once."
                          .text
                          .color(neutral600)
                          .make()
                    ],
                  ),
                )
              ],
            ).p(12),
          ),
          24.heightBox,
          PrimaryTextField(
            controller: nameController,
            title: 'Name',
          ),
          PrimaryTextField(
            controller: descriptionController,
            title: 'Description',
          ).py(24),
          Text(
            'Token type',
            style: labelStyle,
          ),
          12.heightBox,
          StrapiDropdown(
            value: selectedTokenType,
            onChanged: (v) {
              setState(() {
                setState(() {
                  selectedTokenType = v;
                });
              });
            },
            items: [
              DropdownMenuItem(
                child: Text('Read-Only'),
                value: 0,
              ),
              DropdownMenuItem(
                child: Text('Full Access'),
                value: 1,
              ),
            ],
          ),
          16.heightBox,
          Spacer(),
          PrimarySquareButton(
            onPressed: () {},
            color: Theme.of(context).colorScheme.secondary,
            text: 'Save',
          ),
          PrimarySquareButton(
            onPressed: () {},
            color: Theme.of(context).colorScheme.error,
            text: 'Delete',
          ),
        ],
      ).p(24),
    );
  }
}
