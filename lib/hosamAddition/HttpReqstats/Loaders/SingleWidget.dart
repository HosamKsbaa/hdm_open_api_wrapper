import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Base.dart';
import '../ErrorLogic.dart';
import '../httpStats.dart';

/// A StatelessWidget that handles API requests and displays different states (idle, loading, success, error, empty success).
class ApiSingleWidget<ResponseObj> extends StatelessWidget {
  /// Function to make the API request.
  final Future<ResponseObj> Function() requestFunction;

  /// State management for HTTP requests.
  final HDMHttpRequestsStates<ResponseObj> httpRequestsStates;

  /// Widget builder for success state.
  final Widget Function(BuildContext context, ResponseObj response) child;

  /// Fake data to be used for skeleton loading.
  final ResponseObj? fakeData;

  /// Creates an instance of ApiSinglePageSmall.
  ApiSingleWidget({Key? key, required this.requestFunction, HDMHttpRequestsStates<ResponseObj>? httpRequestsStates, required this.child, this.fakeData}) : httpRequestsStates = httpRequestsStates ?? HDMHttpRequestsStates<ResponseObj>(), super(key: key);

  @override
  Widget build(BuildContext context) {
    if (ResponseObj == dynamic) {
      HdmLogger.log("Warning: ApiSingleWidget ResponseObj is dynamic", HdmLoggerMode.warning);
    }
    return ApiBase(requestFunction: requestFunction, httpRequestsStates: httpRequestsStates, buildIdle: _buildIdle, buildLoading: _buildLoading, buildSuccess: child, buildError: _buildError, buildEmptySuccess: _buildEmptySuccess, fakeData: fakeData);
  }

  Widget _buildIdle(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2.0)));
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
    return const SizedBox.shrink();
  }
}
