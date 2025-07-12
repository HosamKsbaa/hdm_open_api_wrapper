import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../Base.dart';
import '../httpStats.dart';
import 'package:retrofit/retrofit.dart'as retrofit ;


/// A StatelessWidget that handles API requests and displays different states (idle, loading, success, error, empty success).
class ApiSinglePageSmall<ResponseObj> extends StatelessWidget {
  /// Function to make the API request.
  final Future<retrofit.HttpResponse<ResponseObj>> Function() requestFunction;

  /// State management for HTTP requests.
  final HDMHttpRequestsStates<ResponseObj> httpRequestsStates;

  /// Widget builder for success state.
  final Widget Function(BuildContext context, ResponseObj response) child;

  /// Creates an instance of ApiSinglePageSmall.
  ApiSinglePageSmall({
    Key? key,
    required this.requestFunction,
    HDMHttpRequestsStates<ResponseObj>? httpRequestsStates,
    required this.child,
  })  : httpRequestsStates =
            httpRequestsStates ?? HDMHttpRequestsStates<ResponseObj>(),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ApiBase(
      requestFunction: requestFunction,
      httpRequestsStates: httpRequestsStates,
      buildIdle: _buildIdle,
      buildLoading: _buildLoading,
      buildSuccess: child,
      buildError: _buildError,
      buildEmptySuccess: _buildEmptySuccess,
    );
  }

  Widget _buildIdle(BuildContext context) {
    return const SizedBox.shrink();
  }

  Widget _buildLoading(BuildContext context) {
    return const Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ),
      ),
    );
  }

  Widget _buildError(BuildContext context) {
    return const Center(
      child: Icon(
        Icons.error,
        size: 20,
        color: Colors.red,
      ),
    );
  }

  Widget _buildEmptySuccess(BuildContext context) {
    return const SizedBox.shrink();
  }
}
