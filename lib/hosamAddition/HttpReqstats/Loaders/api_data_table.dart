import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:data_table_2/data_table_2.dart';

class ApiDataTable<TResponse, TItem> extends StatefulWidget {
  final List<DataColumn> columns;
  final DataRow Function(TItem item) rowBuilder;
  final double minWidth;
  final Widget? empty;

  // Customization
  final Color? loadingColor;
  final Color? errorColor;
  final Color? hintColor;
  final Decoration? tableDecoration;
  final String? loadingText;
  final String? noMoreDataText;
  final String? errorText;

  // Api params
  final Future<TResponse> Function(int page, int size) requestFunction;
  final TResponse fakeData;
  final List<TItem> Function(TResponse response) extractTheList;
  final bool Function(List<TItem> items) isFinished;
  final int pageSize;
  final void Function(int columnIndex, String action)? onColumnAction;

  const ApiDataTable({
    super.key,
    required this.columns,
    required this.rowBuilder,
    required this.requestFunction,
    required this.fakeData,
    required this.extractTheList,
    required this.isFinished,
    this.minWidth = 1000,
    this.empty,
    this.pageSize = 20,
    this.loadingColor,
    this.errorColor,
    this.hintColor,
    this.tableDecoration,
    this.loadingText,
    this.noMoreDataText,
    this.errorText,
    this.onColumnAction,
  });

  @override
  State<ApiDataTable<TResponse, TItem>> createState() => ApiDataTableState<TResponse, TItem>();
}

class ApiDataTableState<TResponse, TItem> extends State<ApiDataTable<TResponse, TItem>> {
  int _pageNumber = 1;
  bool _isLoading = false;
  bool _isFinished = false;
  bool _isInitialLoading = true;
  List<TItem> _data = [];
  final List<TItem> _originalData = [];
  List<TItem> _filteredData = [];
  bool _isLocalFiltered = false;
  int? _lastSortColumnIndex;
  int? _filteredColumnIndex;
  bool _isAscending = true;

  bool get isFinishedData => _isFinished;

  void sortLocal(int Function(TItem a, TItem b) compareHandler, {int? columnIndex, bool? forceAscending}) {
    setState(() {
      if (forceAscending != null) {
        _isAscending = forceAscending;
        _lastSortColumnIndex = columnIndex;
      } else if (columnIndex != null) {
        if (_lastSortColumnIndex == columnIndex) {
          _isAscending = !_isAscending;
        } else {
          _lastSortColumnIndex = columnIndex;
          _isAscending = true;
        }
      }

      final comparator = _isAscending ? compareHandler : (TItem a, TItem b) => compareHandler(b, a);

      if (_isLocalFiltered) {
        _filteredData.sort(comparator);
      } else {
        _data.sort(comparator);
      }
    });
  }

  void filterLocal(bool Function(TItem item) queryHandler, {int? columnIndex}) {
    setState(() {
      _filteredData = _data.where(queryHandler).toList();
      _isLocalFiltered = true;
      _filteredColumnIndex = columnIndex;
    });
  }

  void clearLocalFilter() {
    setState(() {
      _isLocalFiltered = false;
      _filteredData = [];
      _filteredColumnIndex = null;
    });
  }

  void clearLocalSortAndFilter() {
    setState(() {
      _isLocalFiltered = false;
      _filteredData = [];
      _data = List.from(_originalData);
      _lastSortColumnIndex = null;
      _filteredColumnIndex = null;
      _isAscending = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchPage();
  }

  Future<void> _fetchPage() async {
    if (_isLoading || _isFinished || !mounted) return;
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await widget.requestFunction(_pageNumber, widget.pageSize);
      final newItems = widget.extractTheList(response);

      if (!mounted) return;

      setState(() {
        if (_isInitialLoading) {
          _data = newItems;
          _originalData.clear();
          _originalData.addAll(newItems);
          _isInitialLoading = false;
        } else {
          _data.addAll(newItems);
          _originalData.addAll(newItems);
        }

        if (widget.isFinished(newItems)) {
          _isFinished = true;
        } else {
          _pageNumber++;
        }
      });
    } catch (e) {
      if (mounted) {
        setState(() {
          _isInitialLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(widget.errorText ?? 'حدث خطأ أثناء تحميل البيانات', style: const TextStyle(color: Colors.white)),
            backgroundColor: widget.errorColor ?? Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultLoadingColor = widget.loadingColor ?? Theme.of(context).primaryColor;

    if (_isInitialLoading) {
      return Center(child: CircularProgressIndicator(color: defaultLoadingColor));
    }

    return Container(
      padding: EdgeInsets.zero,
      decoration: widget.tableDecoration,
      child: Stack(
        children: [
          NotificationListener<ScrollNotification>(
            onNotification: (ScrollNotification scrollInfo) {
              if (!_isLoading && !_isFinished && scrollInfo.metrics.pixels >= scrollInfo.metrics.maxScrollExtent * 0.9) {
                _fetchPage();
              }
              return false;
            },
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Theme.of(context).dividerColor,
                dataTableTheme: DataTableThemeData(
                  headingRowColor: WidgetStateProperty.all(defaultLoadingColor.withValues(alpha: 0.05)),
                  dataRowColor: WidgetStateProperty.resolveWith((states) {
                    if (states.contains(WidgetState.hovered)) {
                      return defaultLoadingColor.withValues(alpha: 0.03);
                    }
                    return Colors.transparent;
                  }),
                  headingTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontWeight: FontWeight.bold, fontSize: 14.sp),
                  dataTextStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface, fontSize: 13.sp),
                ),
              ),
              child: DataTable2(
                minWidth: widget.minWidth,
                columnSpacing: 16.w,
                horizontalMargin: 16.w,
                empty:
                    widget.empty ??
                    Center(
                      child: Text('لا يوجد بيانات', style: TextStyle(color: widget.hintColor ?? Colors.grey)),
                    ),
                showCheckboxColumn: false,
                columns: _buildColumns(context),
                rows: (_isLocalFiltered ? _filteredData : _data).map((item) => widget.rowBuilder(item)).toList(),
              ),
            ),
          ),

          // Pagination Status Overlays
          if (_isLoading && !_isInitialLoading)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: BorderRadius.circular(20.r),
                    boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 4))],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 14.sp,
                        height: 14.sp,
                        child: CircularProgressIndicator(strokeWidth: 2, color: defaultLoadingColor),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        widget.loadingText ?? 'جاري التحميل...',
                        style: TextStyle(fontSize: 12.sp, color: defaultLoadingColor, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            ),

          if (_isFinished && _data.isNotEmpty)
            Positioned(
              bottom: 16.h,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
                  decoration: BoxDecoration(color: (widget.hintColor ?? Colors.grey).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(20.r)),
                  child: Text(
                    widget.noMoreDataText ?? 'لا يوجد المزيد من البيانات',
                    style: TextStyle(fontSize: 12.sp, color: widget.hintColor ?? Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  List<DataColumn> _buildColumns(BuildContext context) {
    return widget.columns.asMap().entries.map((entry) {
      final DataColumn col = entry.value;

      if (col is DataColumn2) {
        return DataColumn2(
          label: col.label,
          tooltip: col.tooltip,
          numeric: col.numeric,
          onSort: col.onSort,
          size: col.size,
          fixedWidth: col.fixedWidth,
        );
      }
      return DataColumn(
        label: col.label,
        tooltip: col.tooltip,
        numeric: col.numeric,
        onSort: col.onSort,
      );
    }).toList();
  }
}
