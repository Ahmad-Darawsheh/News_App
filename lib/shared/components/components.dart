import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/modules/web_view/web_view_screen.dart';

Widget buildArticleItem({article, context}) => InkWell(
      onTap: (){
        navigateTo(context, WebViewScreen(article['url'],));
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  10.0,
                ),
                image: DecorationImage(
                  image: NetworkImage('${article['urlToImage']}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
            Expanded(
              child: Container(
                height: 120.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        '${article['title']}',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '${article['publishedAt']}',
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),
          ],
        ),
      ),
    );

Widget defaultTextFormField({
  required TextEditingController,
  required TextInputType,
  required FormFieldValidator<String>? validator,
  required String label,
  required IconData prefix,
  Function()? onTap,
  IconData? suffix,
  bool isPassword = false,
  Function? iconFunction,
  Function(String)? onChange,
  Function(String)? onSubmit,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: TextEditingController,
      keyboardType: TextInputType,
      onTap: onTap ?? () {},
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        prefixIcon: Icon(prefix),
        enabled: isClickable,
        suffixIcon: suffix != null
            ? IconButton(
                icon: Icon(suffix),
                onPressed: () {
                  iconFunction!();
                },
              )
            : null,
      ),
      obscureText: isPassword,
      onChanged: onChange,
      onFieldSubmitted: onSubmit,
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 20.0,
      ),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget articleBuilder(article, context) => ConditionalBuilder(
  condition: article.length > 0,
  builder: (context) =>
      ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => buildArticleItem(context: context,article: article[index]),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: article.length,),
  fallback: (context) => const Center(child: CircularProgressIndicator()),
);

