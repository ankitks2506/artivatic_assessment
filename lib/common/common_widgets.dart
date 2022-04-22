import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

Widget contents(
  BuildContext context,
  String url,
  String description,
  String title,
) {
  return Card(
    elevation: 2,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        url != "No Image Provided"
            ? SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.4,
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  imageUrl: url,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              )
            : const Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  "No Image Provided",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Title : $title",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            "Description : $description",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ),
  );
}
