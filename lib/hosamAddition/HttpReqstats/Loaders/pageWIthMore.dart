import 'package:flutter/material.dart';
import 'package:hdm_open_api_wrapper/hosamAddition/HttpReqstats/Loaders/sorce.dart';
import '../httpStats.dart';

//todo add the error message logic to the rest of the apis
class ApiInfiniteList<ResponseObj, RepetedDate> extends StatefulWidget {
  final Future<ResponseObj> Function(int pageNumber, int pageSize) requestFunction;
  final HDMHttpRequestsStates<List<RepetedDate>>? httpRequestsStates;
  final List<RepetedDate> Function(ResponseObj responseObj) extractTheLIst;
  final Widget Function(BuildContext context, List<RepetedDate> items) listViewBuilder;
  final bool Function(List<RepetedDate> response) isFinished;
  final int initialPageNumber;
  final int pageSize;
  final List<RepetedDate> data = [];

  ApiInfiniteList({Key? key, required this.requestFunction, this.httpRequestsStates, required this.listViewBuilder, required this.isFinished, this.initialPageNumber = 1, this.pageSize = 20, required this.extractTheLIst}) : super(key: key);

  @override
  _ApiInfiniteListState<ResponseObj, RepetedDate> createState() => _ApiInfiniteListState<ResponseObj, RepetedDate>();
}

class _ApiInfiniteListState<ResponseObj, RepetedDate> extends State<ApiInfiniteList<ResponseObj, RepetedDate>> {
  late int pageNumber;
  late HDMHttpRequestsStates<List<RepetedDate>> httpRequestsStates;
  bool isFinished = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pageNumber = widget.initialPageNumber;
    httpRequestsStates = widget.httpRequestsStates ?? HDMHttpRequestsStates<List<RepetedDate>>();
    httpRequestsStates.set = () {
      if (mounted) {
        setState(() {});
      }
    };
    _makeRequest();
  }

  @override
  void dispose() {
    // Clear the callback to prevent memory leaks
    httpRequestsStates.set = null;
    super.dispose();
  }

  Future<void> _makeRequest() async {
    if (isLoading || !mounted) return;
    if (mounted) {
      setState(() => isLoading = true);
    }
    httpRequestsStates.setLoading();
    try {
      ResponseObj response = await widget.requestFunction(pageNumber, widget.pageSize);
      if (response != null) {
        widget.data.addAll(widget.extractTheLIst(response));
        if (widget.isFinished(widget.extractTheLIst(response))) {
          isFinished = true;
        } else {
          if (mounted) {
            setState(() {
              pageNumber++;
            });
          }
        }
      }
      httpRequestsStates.setSuccess(widget.data);
    } catch (e, s) {
      httpRequestsStates.setErr(e.toString(), s);
    } finally {
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  Future<bool> _loadMore() async {
    if (!mounted || isFinished) {
      return false;
    }
    if (!isFinished) {
      await _makeRequest();
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return _buildContent();
  }

  Widget _buildContent() {
    if (httpRequestsStates.states == HDMHttpRequestsStatesEnum.loading && (pageNumber == 1)) {
      return _buildLoading();
    } else if (httpRequestsStates.states case HDMHttpRequestsStatesEnum.fail) {
      return _buildError();
    } else if (httpRequestsStates.states case HDMHttpRequestsStatesEnum.success || HDMHttpRequestsStatesEnum.loading) {
      return _buildSuccess(context, widget.data);
    } else if (httpRequestsStates.states case HDMHttpRequestsStatesEnum.successButEmpty) {
      return _buildEmptySuccess();
    } else {
      return _buildIdle();
    }
  }

  Widget _buildIdle() {
    return Center(child: Icon(Icons.error));
  }

  Widget _buildLoading() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildError() {
    return Center(child: Icon(Icons.error));
  }

  Widget _buildEmptySuccess() {
    return Center(child: CircularProgressIndicator());
  }

  Widget _buildSuccess(BuildContext context, List<RepetedDate> data) {
    return NotificationListener<ScrollNotification>(
      onNotification: (ScrollNotification scrollInfo) {
        if (!isLoading && scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
          _loadMore();
        }
        return false;
      },
      child: LoadMore(isFinish: isFinished, onLoadMore: _loadMore, child: widget.listViewBuilder(context, widget.data)),
    );
  }
}
