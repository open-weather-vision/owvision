# owvision_daemon_client_dart.api.StationApi

## Load the API package
```dart
import 'package:owvision_daemon_client_dart/api.dart';
```

All URIs are relative to *http://127.0.0.1:7070/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**stationAll**](StationApi.md#stationall) | **GET** /stations | 
[**stationConnect**](StationApi.md#stationconnect) | **GET** /stations/{id}/live | 
[**stationHistory**](StationApi.md#stationhistory) | **GET** /stations/{id}/history | 
[**stationOne**](StationApi.md#stationone) | **GET** /stations/{id} | 


# **stationAll**
> List<WeatherStation> stationAll()



Get all stations.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();

try {
    final response = api.stationAll();
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;WeatherStation&gt;**](WeatherStation.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stationConnect**
> Error stationConnect(id)



Connect to a station's live websocket.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();
final int id = 789; // int | 

try {
    final response = api.stationConnect(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationConnect: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**Error**](Error.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stationHistory**
> List<SensorHistory> stationHistory(id, from, to, sensors)



Get the history of one ore more sensors (in a specific interval).

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();
final int id = 789; // int | 
final DateTime from = 2013-10-20T19:20:30+01:00; // DateTime | 
final DateTime to = 2013-10-20T19:20:30+01:00; // DateTime | 
final List<String> sensors = ; // List<String> | 

try {
    final response = api.stationHistory(id, from, to, sensors);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationHistory: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 
 **from** | **DateTime**|  | [optional] 
 **to** | **DateTime**|  | [optional] 
 **sensors** | [**List&lt;String&gt;**](String.md)|  | [optional] 

### Return type

[**List&lt;SensorHistory&gt;**](SensorHistory.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stationOne**
> StationAndSensors stationOne(id)



Get one station and it's sensors.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();
final int id = 789; // int | 

try {
    final response = api.stationOne(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationOne: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **id** | **int**|  | 

### Return type

[**StationAndSensors**](StationAndSensors.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

