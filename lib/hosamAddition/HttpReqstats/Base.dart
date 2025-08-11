import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrofit/retrofit.dart' as retrofit;
import 'ErrorLogic.dart';
import 'httpStats.dart'; // Ensure this import is correct

class ApiBase<ResponseObj> extends StatefulWidget {
  final Future<retrofit.HttpResponse<ResponseObj>> Function() requestFunction;
  late  HDMHttpRequestsStates<ResponseObj>? httpRequestsStates;
  final Widget Function(BuildContext context) buildIdle;
  final Widget Function(BuildContext context) buildLoading;
  final Widget Function(BuildContext context, ResponseObj response) buildSuccess;
  final Widget Function(BuildContext context) buildError;
  final Widget Function(BuildContext context) buildEmptySuccess;

   ApiBase({
    Key? key,
    required this.requestFunction,
     this.httpRequestsStates,
    required this.buildIdle,
    required this.buildLoading,
    required this.buildSuccess,
    required this.buildError,
    required this.buildEmptySuccess,
  }) : super(key: key){
    httpRequestsStates ??= HDMHttpRequestsStates<ResponseObj>();
  }

  @override
  State<ApiBase> createState() => _ApiBaseState<ResponseObj>();
}

class _ApiBaseState<ResponseObj> extends State<ApiBase<ResponseObj>> {
  late Future<ResponseObj> _future;

  @override
  void initState() {
    super.initState();
    _future = _makeRequest();
  }

  Future<ResponseObj> _makeRequest() async {
    widget.httpRequestsStates!.setLoading();
    try {
      var response = await widget.requestFunction();
      if (ApiErrorChecker.checkResponse(response)) { // Use the error checker
        widget.httpRequestsStates!.setSuccess(response.data);
        return response.data;
      } else {
        throw Exception("API response error.");
      }
    } catch (e,s) {
      widget.httpRequestsStates!.setErr(e.toString(),s);
      throw e;
    }
  }
// chalet_reservations_list_response
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ResponseObj>(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.buildLoading(context);
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.buildError(context),
              ElevatedButton(
                onPressed: () => setState(() {
                  _future = _makeRequest(); // Retry request
                }),
                child: const Text('Retry'),
              ),
            ],
          );
        } else if (snapshot.hasData) {
          return widget.buildSuccess(context, snapshot.data!);
        } else {
          return widget.buildIdle(context);
        }
      },
    );
  }
}

