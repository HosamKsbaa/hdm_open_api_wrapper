import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Base.dart';
import '../httpStats.dart';

/// A StatelessWidget that handles API requests and displays different states (idle, loading, success, error, empty success).
class ApiSinglePage<ResponseObj> extends StatelessWidget {
  /// Function to make the API request.
  final Future<ResponseObj> Function() requestFunction;

  /// State management for HTTP requests.
  final HDMHttpRequestsStates<ResponseObj> httpRequestsStates;

  /// Widget builder for success state.
  final Widget Function(BuildContext context, ResponseObj response) child;

  /// Creates an instance of ApiSinglePage.
  ApiSinglePage({
    Key? key,
    required this.requestFunction,
    required this.child,
    HDMHttpRequestsStates<ResponseObj>? httpRequestsStates,
  })  : httpRequestsStates = httpRequestsStates ?? HDMHttpRequestsStates<ResponseObj>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApiBase(requestFunction: requestFunction, httpRequestsStates: httpRequestsStates, buildIdle: _buildIdle, buildLoading: _buildLoading, buildSuccess: child, buildError: _buildError, buildEmptySuccess: _buildEmptySuccess);
  }

  Widget _buildIdle(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Center(child: Icon(Icons.error))],
        ),
      ),
    );
  }

  Widget _buildLoading(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const Center(child: Icon(Icons.error, size: 20, color: Colors.red)),
          Text('حدث خطأ ما..', style: const TextStyle(fontSize: 16, color: Colors.red)),
        ],
      ),
    );
  }

  Widget _buildEmptySuccess(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: SizedBox(height: 50, width: 50, child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
