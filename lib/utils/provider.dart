import 'dart:convert';
import 'dart:io';

import 'package:MyDenox/login/bloc/bloc.dart';
import 'package:MyDenox/modals/user.dart';
import 'package:connectivity/connectivity.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' show Response;
import 'package:logger/logger.dart';

class ProviderFatal extends Error {
  final String error;
  final StackTrace stack;

  ProviderFatal(this.error, this.stack);
}

class ProviderError extends Error {
  final String error;
  final StackTrace stack;

  ProviderError(this.error, this.stack);
}

class Provider {
  static Client client = Client();
  static const _production = "https://api-test.denox.com.br/";
  static const _baseUrl = _production;

  final bool hasToken;

  final Map<String, String> _headers = {
    "Content-type": "application/json",
  };

  Future<bool> get verifications async {
    try {
      await _checkWifi();
      if (hasToken) {
        _headers['Authorization'] = "Bearer " + await _getAuthToken();
      }
      return true;
    } catch (e, stack) {
      _traceError(e, stack, response: null, body: null);
      return false;
    }
  }

  Provider({this.hasToken = true});

  _traceError(ex, stack, {Response? response, String? endpoint, Map? body}) {
    var logger = Logger();
    logger.e(
        "finalUrl => ${response?.request?.url ?? endpoint ?? ""}\n"
        "body => ${body ?? ""}\n"
        "header: ${response?.request?.headers ?? ""}\n"
        "req => ${response?.request ?? ""}\n"
        "statusCode => ${response?.statusCode ?? ""}\n"
        "response => ${response?.body ?? ""}\n"
        "Error na ...",
        ex,
        stack);
  }

  Future<String> _getAuthToken() async {
    var token = await User.getAuthToken();
    if (token == null) {
      // todo:  alert token
      Logger().e(" User não possui token");
      throw ProviderFatal("User não possui token", StackTrace.current);
    } else {
      return token;
    }
  }

  _checkWifi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      // todo:  alert connect
      throw ProviderFatal(
          "User não está conectado a internet", StackTrace.current);
    }
  }

  _responseStatus(Response response) async {
    dynamic body;
    try {
      body = jsonDecode(utf8.decode(response.bodyBytes));
    } catch (ex) {
      Logger().e(
          "finalUrl => ${response.request?.url ?? ""}\nHouve um error ao fazer o parse do bodyBytes => $ex");
      return {};
    }

    switch (response.statusCode) {
      case 200:
        return body;
      case 400:
        // if (body is String)
        // Alert(body);
        // else
        // Alert("Houve algum error, tente mais tarde");
        throw ProviderError("Error 400", StackTrace.current);
      case 401:
        _traceError("Error na resposta do servidor", null,
            response: response, body: null);
        BlocLogin.logOut();
        return {};
      default:
        _traceError("Error na resposta do servidor", null,
            response: response, body: null);
        return {};
    }
  }

  _mountQuery(Map<dynamic, dynamic> query) {
    if (query.isEmpty) return "";
    String queryStr = "?";

    for (var i in query.keys) {
      if (queryStr.length != 1) {
        queryStr += "&";
      }
      queryStr += i + "=" + query[i].toString();
    }
    return queryStr;
  }

  post(endpoint, {Map query = const {}, Map body = const {}}) async {
    try {
      if (!(await verifications)) return {};

      Response response = await client.post(
          Uri.parse(_baseUrl + endpoint + _mountQuery(query)),
          body: jsonEncode(body),
          headers: _headers);

      return _responseStatus(response);
    } on SocketException catch (e, stack) {
      //todo: alertNoServer();
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    } catch (e, stack) {
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    }
  }

  put(endpoint, {Map query = const {}, Map body = const {}}) async {
    try {
      if (!(await verifications)) return {};

      Response response = await client.put(
          Uri.parse(_baseUrl + endpoint + _mountQuery(query)),
          body: jsonEncode(body),
          headers: _headers);

      return _responseStatus(response);
    } on SocketException catch (e, stack) {
      //todo: alertNoServer();
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    } catch (e, stack) {
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    }
  }

  delete(endpoint, {Map query = const {}}) async {
    try {
      if (!(await verifications)) return {};

      Response response = await client.delete(
          Uri.parse(_baseUrl + endpoint + _mountQuery(query)),
          headers: _headers);

      return _responseStatus(response);
    } on SocketException catch (e, stack) {
      //todo: alertNoServer();
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    } catch (e, stack) {
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    }
  }

  get(endpoint,
      {Map query = const {}, Map<String, String> header = const {}}) async {
    if (!(await verifications)) return {};

    if (header.isNotEmpty) _headers.addAll(header);
    try {
      Response response = await client.get(
          Uri.parse(_baseUrl + endpoint + _mountQuery(query)),
          headers: _headers);

      return _responseStatus(response);
    } on SocketException catch (e, stack) {
      //todo: alertNoServer();
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    } catch (e, stack) {
      _traceError(e, stack,
          response: null, endpoint: endpoint + _mountQuery(query), body: null);
      return {};
    }
  }
}
