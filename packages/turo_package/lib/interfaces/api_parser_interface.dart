import 'package:dio/dio.dart';
import 'package:turo_package/models/api/api_response.dart';
import 'package:turo_package/models/article.dart';
import 'package:turo_package/models/blog_models/blog_articles_data.dart';
import 'package:turo_package/models/blog_models/blog_comments_data.dart';
import 'package:turo_package/models/blog_models/blog_tags_data.dart';
import 'package:turo_package/models/blog_models/blogs_categories_data.dart';
import 'package:turo_package/models/notifications/check_notifications.dart';
import 'package:turo_package/models/notifications/notifications.dart';
import 'package:turo_package/models/partner.dart';
import 'package:turo_package/models/property_meta_data.dart';
import 'package:turo_package/models/realtor_model.dart';
import 'package:turo_package/models/saved_search.dart';
import 'package:turo_package/models/user.dart';
import 'package:turo_package/models/user_membership_package.dart';

abstract class ApiParserInterface {
  Article parseArticle(Map<String, dynamic> json);
  Term parseMetaDataMap(Map<String, dynamic> json);
  Agent parseAgentInfo(Map<String, dynamic> json);
  Agency parseAgencyInfo(Map<String, dynamic> json);
  SavedSearch parseSavedSearch(Map<String, dynamic> json);
  User parseUserInfo(Map<String, dynamic> json);
  ApiResponse<String> parseNonceResponse(Response response);
  Partner parsePartnerJson(Map<String, dynamic> json);
  ApiResponse<String> parsePaymentResponse(Response response);
  ApiResponse<String> parseNormalApiResponse(Response response);
  ApiResponse<String> parseFeaturedResponse(Response response);
  ApiResponse<String> parse500ApiResponse(Response response);
  UserMembershipPackage parseUserMembershipPackageResponse(
      Map<String, dynamic> json);
  BlogArticlesData parseBlogArticlesJson(Map<String, dynamic> json);
  BlogCategoriesData parseBlogCategoriesJson(Map<String, dynamic> json);
  BlogTagsData parseBlogTagsJson(Map<String, dynamic> json);
  BlogCommentsData parseBlogCommentsJson(Map<String, dynamic> json);
  AllNotifications parseAllNotificationsResponse(Map<String, dynamic> json);
  CheckNotifications parseCheckNotificationsResponse(Map<String, dynamic> json);
}
