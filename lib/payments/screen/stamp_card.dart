import 'package:flutter/material.dart';

class StampCard extends StatelessWidget {
  final String title;
  final String description;
  final int earnedStamps;
  final int totalStamps;
  final Color backgroundColor;
  final Color textColor;
  final String imageUrl;

  const StampCard({
    Key? key,
    required this.title,
    required this.description,
    required this.earnedStamps,
    required this.totalStamps,
    required this.backgroundColor,
    required this.textColor,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // কার্ড হেডার
            Row(
              children: [
                // বিজনেস লোগো/ইমেজ
                if (imageUrl.isNotEmpty)
                  CircleAvatar(
                    backgroundImage: NetworkImage(imageUrl),
                    radius: 20,
                  )
                else
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: textColor.withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: textColor,
                      size: 20,
                    ),
                  ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12),

            // বিবরণ
            Text(
              description,
              style: TextStyle(
                color: textColor.withOpacity(0.9),
                fontSize: 14,
              ),
            ),

            SizedBox(height: 24),

            // স্ট্যাম্প গ্রিড
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: totalStamps,
              itemBuilder: (context, index) {
                bool isFilled = index < earnedStamps;
                return Container(
                  decoration: BoxDecoration(
                    color: isFilled ? textColor : textColor.withOpacity(0.3),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: textColor.withOpacity(0.5),
                      width: 2,
                    ),
                  ),
                  child: isFilled
                      ? Icon(
                    Icons.check,
                    color: backgroundColor,
                    size: 16,
                  )
                      : null,
                );
              },
            ),

            SizedBox(height: 16),

            // প্রোগ্রেস টেক্সট
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stamps',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '$earnedStamps / $totalStamps',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // প্রোগ্রেস বার
            SizedBox(height: 8),
            LinearProgressIndicator(
              value: earnedStamps / totalStamps,
              backgroundColor: textColor.withOpacity(0.3),
              valueColor: AlwaysStoppedAnimation<Color>(textColor),
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
      ),
    );
  }
}