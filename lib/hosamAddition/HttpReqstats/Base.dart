import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'ErrorLogic.dart';
import 'httpStats.dart'; // Ensure this import is correct

class ApiBase<ResponseObj> extends StatefulWidget {
  final Future<ResponseObj> Function() requestFunction;
  final HDMHttpRequestsStates<ResponseObj> httpRequestsStates;
  final Widget Function(BuildContext context) buildIdle;
  final Widget Function(BuildContext context) buildLoading;
  final Widget Function(BuildContext context, ResponseObj response) buildSuccess;
  final Widget Function(BuildContext context) buildError;
  final Widget Function(BuildContext context) buildEmptySuccess;
  final bool useSkeleton;
  final Widget? skeleton;

  ApiBase({
    Key? key,
    required this.requestFunction,
    HDMHttpRequestsStates<ResponseObj>? httpRequestsStates,
    required this.buildIdle,
    required this.buildLoading,
    required this.buildSuccess,
    required this.buildError,
    required this.buildEmptySuccess,
    this.useSkeleton = false,
    this.skeleton,
  })  : httpRequestsStates = httpRequestsStates ?? HDMHttpRequestsStates<ResponseObj>(),
        super(key: key);

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
    widget.httpRequestsStates.setLoading();
    try {
      var response = await widget.requestFunction();
      if (ApiErrorChecker.checkData(response)) {
        // Use the error checker
        if (response == null) {
          throw Exception("Response data is null");
        }
        widget.httpRequestsStates.setSuccess(response);
        return response;
      } else {
        throw Exception("API response error.");
      }
    } catch (e, s) {
      widget.httpRequestsStates.setErr(e.toString(), s);
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
          if (widget.useSkeleton && widget.skeleton != null) {
            return Skeletonizer(
              enabled: true,
              child: widget.skeleton!,
            );
          }
          return widget.buildLoading(context);
        } else if (snapshot.hasError) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.buildError(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => setState(() {
                    _future = _makeRequest(); // Retry request
                  }),
                  child: const Text('المحاوله مره اخري', style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
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
