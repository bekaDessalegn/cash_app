import 'dart:convert';
import 'dart:io';

import 'package:cash_app/core/global.dart';
import 'package:cash_app/core/services/auth_service.dart';
import 'package:cash_app/core/services/shared_preference_service.dart';
import 'package:cash_app/features/affiliate_profile/data/datasources/local/local_affiliate_datasource.dart';
import 'package:cash_app/features/affiliate_profile/data/models/affiliates.dart';
import 'package:cash_app/features/affiliate_profile/data/models/avatar.dart';
import 'package:cash_app/features/affiliate_profile/data/models/children.dart';
import 'package:cash_app/features/affiliate_profile/data/models/local_affiliate.dart';
import 'package:cash_app/features/affiliate_profile/data/models/parent_affiliate.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AffiliatesDataSource {
  AuthService authService = AuthService();
  final _prefs = PrefService();
  AffiliateLocalDb affiliateLocalDb = AffiliateLocalDb();

  var refreshToken;
  var accessToken;
  var userId;
  var verificationToken;

  Future getNewAccessToken() async {
    await getRefreshTokens().then((value) {
      refreshToken = value;
    });

    await getAccessTokens().then((value) {
      accessToken = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Refresh-Token': '$refreshToken',
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/sessions/refresh');

    var res = await http.get(url, headers: headersList);
    final resBody = res.body;

    var data = json.decode(resBody);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print("Meneshet mneshet");
      print(data);
      await authService.setAccessToken(accessToken: data["newAccessToken"]);
    } else if (data["message"] == "Invalid_Refresh_Token") {
      print(data);
      print("IT has entered");
      _prefs.removeCache();
      _prefs.removeAffiliateId();
      authService.logOut();
      print("The entered has ended");
    } else {
      print(data);
      throw Exception();
    }
  }

  Future getAffiliate() async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    print("User Id : ${userId}");

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        await _prefs.createUserId(data["userId"]);
        final affiliate = Affiliates.fromJson(data);

        await affiliateLocalDb.addAffiliate(LocalAffiliate(
            userId: data["userId"],
            fullName: data["fullName"],
            phone: data["phone"],
            email: data["email"],
            totalRequests: data["affiliationSummary"]["totalRequests"],
            acceptedRequests: data["affiliationSummary"]["acceptedRequests"],
            rejectedRequests: data["affiliationSummary"]["rejectedRequests"],
            totalMade: data["wallet"]["totalMade"],
            currentBalance: data["wallet"]["currentBalance"],
            canWithdrawAfter: data["wallet"]["canWithdrawAfter"],
            memberSince: data["memberSince"]));

        final updated = await affiliateLocalDb.updateAffiliate(
            data["userId"],
            LocalAffiliate(
                userId: data["userId"],
                fullName: data["fullName"],
                phone: data["phone"],
                email: data["email"],
                totalRequests: data["affiliationSummary"]["totalRequests"],
                acceptedRequests: data["affiliationSummary"]["acceptedRequests"],
                rejectedRequests: data["affiliationSummary"]["rejectedRequests"],
                totalMade: data["wallet"]["totalMade"],
                currentBalance: data["wallet"]["currentBalance"],
                canWithdrawAfter: data["wallet"]["canWithdrawAfter"],
                memberSince: data["memberSince"])
                .toJson());
        return affiliate;
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await getAffiliate();
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        throw Exception("api");
      }
    } on SocketException {
      final affiliate = await affiliateLocalDb.getAffiliate();
      return affiliate;
    }
  }

  Future<ParentAffiliate> getParentAffiliate(String parentId) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    print("Parent Id : $parentId");

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$parentId');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(
            "TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTt");
        print(data);
        final affiliate = ParentAffiliate.fromJson(data);
        print(affiliate);
        return affiliate;
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await getParentAffiliate(parentId);
      } else {
        print(data);
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<Avatar> putAvatar(Avatar avatar, List imageType) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/avatar');

    try {
      var req = http.MultipartRequest('PUT', url);
      req.headers.addAll(headersList);
      if (avatar.path != "[0, 0, 0, 0, 0, 0, 0, 0]") {
        req.files.add(await http.MultipartFile.fromBytes(
            'avatar', json.decode(avatar.path!).cast<int>(),
            contentType: MediaType("${imageType[0]}", "${imageType[1]}"),
            filename: "Any_name"));
      }

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print("The response is : ");
        print(data);
        print(data["avatar"]["path"]);
        final avatar = Avatar(path: data["avatar"]["path"]);
        return avatar;
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await putAvatar(avatar, imageType);
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future<List<Children>> getChildren() async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/children');

    try {
      var res = await http.get(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        List content = json.decode(resBody);
        List<Children> children =
            content.map((child) => Children.fromJson(child)).toList();
        print(data);
        return children;
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await getChildren();
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future patchFullName(String fullName) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/full-name');

    var body = {"newFullName": fullName};

    try {
      var res =
          await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await patchFullName(fullName);
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future patchPhone(String phone) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/phone');

    var body = {"newPhone": phone};

    try {
      var res =
          await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await patchPhone(phone);
      } else if (data["message"] == "Affiliate_Phone_Already_Exist" ||
          data["message"] == "Invalid_Phone") {
        print(data);
        return data["message"];
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future patchEmail(String email) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/email');

    var body = {"newEmail": email};

    try {
      var res =
          await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
        verificationToken = data["verificationToken"];
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await patchEmail(email);
      } else if (data["message"] == "Affiliate_Email_Already_Exist") {
        print(data);
        throw const HttpException("Affiliate_Email_Already_Exist");
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future verifyEmail(String verificationCode) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/verify-email');

    var body = {
      "verificationToken": verificationToken,
      "verificationCode": verificationCode
    };

    try {
      var res =
          await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await verifyEmail(verificationCode);
      } else if (data["message"] == "Wrong_Verification_Code" ||
          data["message"] == "Expired_Token") {
        print(data);
        throw const HttpException("Invalid Verification Code");
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future patchPassword(String oldPasswordHash, String newPasswordHash) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/password');

    var body = {
      "oldPasswordHash": oldPasswordHash,
      "newPasswordHash": newPasswordHash
    };

    try {
      var res =
          await http.patch(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await patchPassword(oldPasswordHash, newPasswordHash);
      } else if (data["message"] == "Wrong_Password_Hash") {
        print(data);
        throw const HttpException("Wrong_Password_Hash");
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future deleteAvatar() async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId/avatar');

    try {
      var res = await http.delete(url, headers: headersList);
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await deleteAvatar();
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else {
        print(data);
        throw Exception();
      }
    } catch (e) {
      print(e);
      throw Exception();
    }
  }

  Future deleteAffiliate(String passwordHash) async {
    await getAccessTokens().then((value) {
      accessToken = value;
    });

    await getUserId().then((value) {
      userId = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Authorization': 'Bearer $accessToken',
      'Content-Type': 'application/json'
    };
    var url = Uri.parse('$baseUrl/affiliates/$userId');

    var body = {"passwordHash": passwordHash};

    try {
      var res =
          await http.delete(url, headers: headersList, body: json.encode(body));
      final resBody = res.body;

      var data = json.decode(resBody);

      if (res.statusCode >= 200 && res.statusCode < 300) {
        print(data);
      } else if (data["message"] == "Not_Authorized") {
        print("ON 401 : $data");
        await getNewAccessToken();
        return await deleteAffiliate(passwordHash);
      } else if (data["message"] == "User_Not_Found") {
        _prefs.removeCache();
        _prefs.removeAffiliateId();
        authService.logOut();
        throw Exception();
      } else if (data["message"] == "Wrong_Password_Hash") {
        print(data);
        throw const HttpException("404");
      } else {
        print(data);
        throw Exception();
      }
    } on SocketException {
      throw Exception();
    }
  }

  Future signout() async {
    await getRefreshTokens().then((value) {
      refreshToken = value;
    });

    await getAccessTokens().then((value) {
      accessToken = value;
    });

    var headersList = {
      'Accept': '*/*',
      'Api-Key': apiKey,
      'Refresh-Token': '$refreshToken',
      'Authorization': 'Bearer $accessToken'
    };
    var url = Uri.parse('$baseUrl/sessions/sign-out');

    var res = await http.delete(url, headers: headersList);
    final resBody = res.body;

    var data = json.decode(resBody);
    print(refreshToken);

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(data);
    } else if (data["message"] == "Not_Authorized") {
      print("ON 401 : $data");
      await getNewAccessToken();
      return await signout();
    } else {
      print(data);
      throw Exception();
    }
  }
}
