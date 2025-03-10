import 'package:intl/intl.dart';

String formatDateTime(DateTime createdAt) {
  final now = DateTime.now();
  final difference = now.difference(createdAt);

  if (difference.inMinutes < 1) {
    return "Just now";
  } else if (difference.inMinutes < 60) {
    return "${difference.inMinutes}m";
  } else if (difference.inHours < 24) {
    return DateFormat("h:mm a").format(createdAt);
  } else if (difference.inDays < 7) {
    return "${difference.inDays}d";
  } else if (createdAt.year == now.year) {
    return DateFormat("MMM d").format(createdAt);
  } else {
    return DateFormat("MMM d, yyyy").format(createdAt);
  }
}
