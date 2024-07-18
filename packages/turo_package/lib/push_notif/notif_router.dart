import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:turo_package/files/hive_storage_files/hive_storage_manager.dart';
import 'package:turo_package/files/generic_methods/utility_methods.dart';
import 'package:turo_package/pages/crm_pages/crm_activities/activities_from_board.dart';
import 'package:turo_package/pages/home_screen_drawer_menu_pages/properties.dart';
import 'package:turo_package/pages/home_screen_drawer_menu_pages/saved_searches.dart';
import 'package:turo_package/pages/notifications_page/all_notifications.dart';
import 'package:turo_package/push_notif/one_singal_config.dart';
import 'package:turo_package/widgets/review_related_widgets/all_reviews_page.dart';

class NotificationRouter {
  static initNotificationRouter(BuildContext context, Function setState) {
    Map data =
        HiveStorageManager.readData(key: oneSignalNotificationData) ?? {};
    notificationRouterFunc(context, data);
    OneSignalConfig.clearNotificationData();
  }

  static void notificationRouterFunc(BuildContext context, Map data,
      {bool? fromAllNotifications}) {
    if (data.isEmpty) {
      return;
    }

    switch (data['type']) {
      case notificationSavedSearches:
        UtilityMethods.navigateToRoute(
          context: context,
          builder: (context) => SavedSearches(
            showAppBar: true,
            url: data['search_url'],
          ),
        );
        break;

      case notificationNewReview:
        log(data.toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AllReviews(
              id: data['listing_id'] is int
                  ? data['listing_id']
                  : data['listing_id'] is String
                      ? int.parse(data['listing_id'])
                      : null,
              fromProperty:
                  data['review_post_type'] == "property" ? true : false,
              reviewPostType: data['review_post_type'],
              title: data['listing_title'],
              listingTitle: data['listing_title'],
            ),
          ),
        );
        break;

      case notificationListingExpired:
      case notificationListingDisapproved:
      case notificationListingApproved:
      case notificationNewListingSubmission:
      case notificationUpdatedListingSubmission:
        navigateToProperties(context);
        break;

      case notificationScheduleTour:
      case notificationAgentContact:
      case notificationNewInquiry:
      case notificationContactRealtor:
        navigateToActivities(context);
        break;

      default:
        if (fromAllNotifications == true) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AllNotificationsPage(),
          ),
        );
        break;
    }
  }

  static void navigateToProperties(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Properties(),
      ),
    );
  }

  static void navigateToActivities(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ActivitiesFromBoard(),
      ),
    );
  }
}
