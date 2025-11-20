## 0.1.4

* Add comprehensive documentation to all loaders (`ApiInfiniteList`, `LoadMore`, `FutureButton`, etc.).
* Fix missing `FutureButton.dart` and `ButtonUsageExample.dart` files in the package.

## 0.1.3

* Add `skeletonizer` support to loaders (`ApiSinglePage`, `ApiSingleWidget`, `ApiInfiniteList`).
* Add `useSkeleton` and `skeleton` parameters to enable skeleton loading state.

## 0.1.2

* Remove `Response` wrapper from API signatures.
* `requestFunction` now returns `Future<ResponseObj>` directly.
* Remove `dio` dependency from public API where possible.

## 0.1.1

* Auto-incremented version.

## 0.1.0

* Accept HTTP status codes 200-300 (2xx responses) as successful
* Migrate from retrofit to dio for HTTP response handling
* Improved error checking and null-safety
* Updated API error checker to support broader status code range

## 0.0.1

* Initial release.
