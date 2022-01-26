import 'package:flutter/material.dart';
import 'package:strapi_flutter_cms/Customwidgets/buttons.dart';
import 'package:strapi_flutter_cms/Customwidgets/dialogs.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/controllers/settingsControllers/apiTokensController.dart';
import 'package:strapi_flutter_cms/models/apiToken.dart';
import 'package:strapi_flutter_cms/pages/comming_soon_page.dart';
import 'package:strapi_flutter_cms/pages/settings_pages/api_details_screen.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class APITokensScreen extends StatefulWidget {
  const APITokensScreen({Key key}) : super(key: key);

  @override
  _APITokensScreenState createState() => _APITokensScreenState();
}

class _APITokensScreenState extends State<APITokensScreen> {
  List<ApiToken> apiTokens = [];
  bool loading = false;
  void initState() {
    super.initState();

    setState(() {
      loading = true;
    });
    fetchApiTokens().then((value) {
      setState(() {
        apiTokens = value;
      });
    }).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          'API Tokens'.text.xl2.semiBold.make(),
          'List of generated tokens to consume the API'
              .text
              .medium
              .color(neutral600)
              .semiBold
              .make(),
          16.heightBox,
          Expanded(
              child: loading
                  ? CustomSpinner()
                  : apiTokens.length > 0
                      ? TokensCard(
                          apiTokens: apiTokens,
                        )
                      : CommingSoonPage(
                          message: 'No Tokens found',
                          showAppBar: false,
                        )),
          24.heightBox,
          PrimarySquareButton(
            color: primary600,
            text: '+ Add Entry',
            onPressed: () {
              showAddAPITokenDialog(context);
            },
          ),
          16.heightBox,
        ],
      ),
    ).p(16);
  }
}

class TokensCard extends StatelessWidget {
  final List<ApiToken> apiTokens;
  const TokensCard({
    Key key,
    this.apiTokens,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(0),
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              APITokensCustomText(
                text: 'NAME',
                color: neutral600,
              ),
              APITokensCustomText(
                text: 'DESCRIPTION',
                color: neutral600,
              ),
              APITokensCustomText(
                text: 'TOKEN TYPE',
                color: neutral600,
              ),
              APITokensCustomText(
                text: 'CREATED AT',
                color: neutral600,
              ),
            ],
          ),
          Divider(
            thickness: 1,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: apiTokens.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    height: 40,
                    child: APITokensRow(
                      token: apiTokens[index],
                    ),
                  );
                }),
          ),
        ],
      ).p(12),
    );
  }
}

class APITokensCustomText extends StatelessWidget {
  const APITokensCustomText({Key key, @required this.text, this.color})
      : super(key: key);
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Flexible(
        flex: 1,
        child: (color == null)
            ? text.text.color(neutral800).size(12).make()
            : text.text.color(neutral600).semiBold.size(12).make());
  }
}

class APITokensRow extends StatelessWidget {
  const APITokensRow({
    Key key,
    @required this.token,
  }) : super(key: key);

  final ApiToken token;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => APITokenDetailsScreen(
                  apiTokenId: token.id,
                )));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          APITokensCustomText(
            text: token.name,
          ),
          APITokensCustomText(
            text: token.description,
          ),
          APITokensCustomText(
            text: token.type,
          ),
          APITokensCustomText(
            text: '${token.createdAt.toString()}',
          ),
        ],
      ),
    );
  }
}
