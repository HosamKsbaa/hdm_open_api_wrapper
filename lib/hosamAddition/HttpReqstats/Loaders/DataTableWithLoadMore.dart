// import 'package:account_gold/hosamAddition/HttpReqstats/Loaders/sorce.dart';
// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_datagrid/datagrid.dart';
// import '../httpStats.dart';
// import 'package:retrofit/retrofit.dart' as retrofit;
//
// class ApiInfiniteList<ResponseObj, RepetedDate> extends StatefulWidget {
//   final Future<retrofit.HttpResponse<ResponseObj>> Function(int pageNumber, int pageSize) requestFunction;
//   final ProductDataSource<ResponseObj, RepetedDate> dataSource;
//   final HDMHttpRequestsStates<List<RepetedDate>>? httpRequestsStates;
//
//   ApiInfiniteList({
//     Key? key,
//     required this.requestFunction,
//     this.httpRequestsStates,
//     required this.dataSource,
//   }) : super(key: key);
//
//   @override
//   _ApiInfiniteListState<ResponseObj, RepetedDate> createState() => _ApiInfiniteListState<ResponseObj, RepetedDate>();
// }
//
// class _ApiInfiniteListState<ResponseObj, RepetedDate> extends State<ApiInfiniteList<ResponseObj, RepetedDate>> {
//   late HDMHttpRequestsStates<List<RepetedDate>> httpRequestsStates;
//   bool isFinished = false;
//   bool isLoading = false;
//   int pageNumber = 1;
//
//   @override
//   void initState() {
//     super.initState();
//     httpRequestsStates = widget.httpRequestsStates ?? HDMHttpRequestsStates<List<RepetedDate>>();
//     httpRequestsStates.set = () {
//       if (mounted) {
//         setState(() {});
//       }
//     };
//     _makeRequest();
//   }
//
//   Future<void> _makeRequest() async {
//     if (isLoading) return;
//     setState(() => isLoading = true);
//     httpRequestsStates.setLoading();
//     try {
//       retrofit.HttpResponse<ResponseObj> req = await widget.requestFunction(pageNumber, widget.dataSource.pageSize);
//       ResponseObj response = req.data;
//       widget.dataSource.data.addAll(widget.dataSource.extractTheLIst(response));
//       if (widget.dataSource.isFinished(widget.dataSource.extractTheLIst(response))) {
//         isFinished = true;
//       } else {
//         setState(() {
//           pageNumber++;
//         });
//       }
//       httpRequestsStates.setSuccess(widget.dataSource.data);
//     } catch (e) {
//       httpRequestsStates.setErr(e.toString());
//     } finally {
//       setState(() => isLoading = false);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return _buildContent();
//   }
//
//   Widget _buildContent() {
//     switch (httpRequestsStates.states) {
//       case HDMHttpRequestsStatesEnum.fail:
//         return _buildError();
//       case HDMHttpRequestsStatesEnum.success:
//       case HDMHttpRequestsStatesEnum.loading:
//         return _buildSuccess(context, widget.dataSource.data);
//       case HDMHttpRequestsStatesEnum.successButEmpty:
//         return _buildEmptySuccess();
//       default:
//         return _buildIdle();
//     }
//   }
//
//   Widget _buildIdle() {
//     return Center(child: Icon(Icons.error));
//   }
//
//   Future<String> _loadMoreRows(LoadMoreRows loadMoreRows) async {
//     await loadMoreRows();
//     return Future<String>.value('Completed');
//   }
//
//   Widget _buildError() {
//     return Center(child: Icon(Icons.error));
//   }
//
//   Widget _buildLoadMoreView(BuildContext context, LoadMoreRows loadMoreRows) {
//     return FutureBuilder<String>(
//       initialData: 'loading',
//       future: _loadMoreRows(loadMoreRows),
//       builder: (context, snapshot) {
//         if (snapshot.data == 'loading') {
//           return Container(
//             height: 98.0,
//             color: Colors.white,
//             width: double.infinity,
//             alignment: Alignment.center,
//             child: CircularProgressIndicator(
//               valueColor: AlwaysStoppedAnimation(Colors.deepPurple),
//             ),
//           );
//         } else {
//           return SizedBox.fromSize(size: Size.zero);
//         }
//       },
//     );
//   }
//
//   Widget _buildEmptySuccess() {
//     return Center(child: CircularProgressIndicator());
//   }
//
//   Container _buildFooter(int productCount) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       alignment: Alignment.centerRight,
//       child: Text(
//         'عدد المنتجات: $productCount  اسحب للتسفل للحصول علي باقي المنتجات و لتفعيل خاصية الفلترة والترتيب',
//         textAlign: TextAlign.right,
//       ),
//     );
//   }
//
//   Widget _buildSuccess(BuildContext context, List<RepetedDate> data) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SfDataGrid(
//         source: widget.dataSource,
//         defaultColumnWidth: 200.0,
//         columnResizeMode: ColumnResizeMode.onResize,
//         columnWidthCalculationRange: ColumnWidthCalculationRange.allRows,
//         gridLinesVisibility: GridLinesVisibility.both,
//         shrinkWrapColumns: true,
//         footerFrozenRowsCount: 1,
//         footer: _buildFooter(widget.dataSource.data.length),
//         columnWidthMode: ColumnWidthMode.auto,
//         allowColumnsResizing: true,
//         shrinkWrapRows: false,
//         showColumnHeaderIconOnHover: true,
//         allowFiltering: true,
//         allowSorting: true,
//         loadMoreViewBuilder: _buildLoadMoreView,
//         columns: widget.dataSource.buildGridColumns(),
//       ),
//     );
//   }
// }
//
// class CustomCells<DataPointType> extends DataGridCell<DataPointType> {
//   final String columnName;
//   final DataPointType value;
//   final Widget Function(DataPointType value) widgetBuilder;
//
//   CustomCells({
//     required this.columnName,
//     required this.value,
//     required this.widgetBuilder,
//   }) : super(columnName: columnName, value: value);
//
//   Widget buildWidget() {
//     return widgetBuilder(value);
//   }
// }
//
// class ProductDataSource<jsonData, RepeatedData> extends DataGridSource {
//   final List<RepeatedData> data;
//   final List<CustomCells> Function(RepeatedData repeatedData) extractTheList;
//   List<DataGridRow> dataGridRows = [];
//   final int initialPageNumber;
//   final bool Function(List<jsonData> response) isFinished;
//   final int pageSize;
//   final Future<retrofit.HttpResponse<jsonData>> Function(int pageNumber, int pageSize) requestFunction;
//   final List<RepeatedData> Function(jsonData responseObj) extractTheLIst;
//
//   Future<List<RepeatedData>> fetchProductData(int index) {
//     return requestFunction(index, pageSize).then((value) => extractTheLIst(value.data));
//   }
//
//   ProductDataSource({
//     required this.initialPageNumber,
//     required this.requestFunction,
//     required this.isFinished,
//     required this.pageSize,
//     required this.extractTheLIst,
//     required this.data,
//     required this.extractTheList,
//   }) {
//     buildDataGridRows();
//   }
//
//   void buildDataGridRows() {
//     dataGridRows = data.map((element) {
//       List<CustomCells> dataPoints = extractTheList(element);
//
//       return DataGridRow(cells: dataPoints);
//     }).toList();
//   }
//
//   List<GridColumn> buildGridColumns() {
//     return extractTheList(data.first).map((e) => _buildGridColumn(e.columnName, e.columnName)).toList();
//   }
//
//   GridColumn _buildGridColumn(String columnName, String label) {
//     return GridColumn(
//       columnWidthMode: ColumnWidthMode.lastColumnFill,
//       columnName: columnName,
//       label: Container(
//         padding: EdgeInsets.all(8.0),
//         alignment: Alignment.centerRight,
//         child: Text(
//           label,
//           style: TextStyle(fontWeight: FontWeight.bold),
//           textAlign: TextAlign.right,
//         ),
//       ),
//     );
//   }
//
//   @override
//   List<DataGridRow> get rows => dataGridRows;
//
//   @override
//   DataGridRowAdapter buildRow(DataGridRow row) {
//     return DataGridRowAdapter(
//       cells: row.getCells().map<Widget>((cell) {
//         // Cast the cell to CustomCells if it is a subclass of DataGridCell
//         final customCell = cell as CustomCells;
//         return customCell.buildWidget();
//       }).toList(),
//     );
//   }
//
//   @override
//   Future<void> handleLoadMoreRows() async {
//     await Future.delayed(Duration(seconds: 2));
//     List<RepeatedData> newProducts = await fetchProductData(initialPageNumber);
//     data.addAll(newProducts);
//     buildDataGridRows();
//     notifyListeners();
//   }
// }
