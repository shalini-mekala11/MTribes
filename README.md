M-Tribes Assignment


Steps to build and launch


Build using Xcode 9 and run using only a device as iOS 11 simulator is very slow in running an app using MapKit. Please refer to the radar http://www.openradar.me/33563985

Included a simulated usergelocation.gpx file with location set to the center of the annotations
 <wpt lat="53.574581" lon="9.959278"><name>Eimsbuttel</name> for testing purpose. Please set the userlocation to none under
xcode project scheme before running the app on the device to test the actual user location.

Functionality

App displays cars feed received from the web service and persists using Realm framework. App always fetches latest feed from web service but uses caches data only if there was a failure in fetching the results from web service (example offline mode).

Tapping on a car annotation in the map displays the callout view with the name and address of the car and hides the car annotations for all the other cars available.

Scheduled pickup overlay view for the selected car is also displayed on the mapview at the bottom that shows additional details of the car such as engine type , condition etc. 

User can choose to select a time for pickup using the overlay view and confirm by clicking on the schedule button. A successfully scheduled pickup is shown on the callout view with scheduled time for the selected car annotion. 

A User notification will be locally delivered to the device at the scheduled time reminding the user about the pickup of the car.

Functionality to schedule a pickup is only available on the mapview and not the listview at the moment. 







