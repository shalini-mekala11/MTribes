M-Tribes Assignment


Steps to build and launch


Build using Xcode 9 and run using only a device as iOS 11 simulator is very slow in running an app using MapKit. Please refer to the radar http://www.openradar.me/33563985


App displays cars feed received from the web service and persists using Realm framework. App always fetches latest feed from web service but uses caches data only if there was a failure in fetching the results from web service (example offline mode).

Included a simulated usergelocation.gpx file with location set to the center of the annotations
 <wpt lat="53.574581" lon="9.959278"><name>Eimsbuttel</name> for testing purpose. Please reset the userlocation under
xcode project scheme before running the app on the device to test the actual user location.
