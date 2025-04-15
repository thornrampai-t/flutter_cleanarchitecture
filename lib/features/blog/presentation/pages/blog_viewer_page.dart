import 'package:flutter/material.dart';
import 'package:flutter_cleanarchitecture/core/theme/app_pallete.dart';
import 'package:flutter_cleanarchitecture/core/utils/calculate_reading_time.dart';
import 'package:flutter_cleanarchitecture/core/utils/format_date.dart';
import 'package:flutter_cleanarchitecture/features/blog/domain/entities/blog.dart';

class BlogViewerPage extends StatelessWidget {
  static route(Blog blog) =>
      MaterialPageRoute(builder: (context) => BlogViewerPage(blogs: blog));
  final Blog blogs;
  const BlogViewerPage({super.key, required this.blogs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blogs.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Text(
                  'By ${blogs.posterName}',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                ),
                Text(
                  '${formattDateBydMMMYYYY(blogs.updatedAt)} . ${calculateReadingTime(blogs.content)} min',
                  style: TextStyle(
                    color: AppPallete.greyColor,
                    fontSize: 16
                  ),
                ),
                 SizedBox(height: 20),
                 ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(blogs.imageUrl),
                 ),
                  SizedBox(height: 20),
                  Text(blogs.content ,style: 
                  TextStyle(fontSize: 16,
                  height: 2),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
