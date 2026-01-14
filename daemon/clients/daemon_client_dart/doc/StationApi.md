# owvision_daemon_client_dart.api.StationApi

## Load the API package
```dart
import 'package:owvision_daemon_client_dart/api.dart';
```

All URIs are relative to *http://127.0.0.1:7070/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**stationsAll**](StationApi.md#stationsall) | **GET** /stations | 
[**stationsConnect**](StationApi.md#stationsconnect) | **GET** /stations/{id}/live | 
[**stationsOne**](StationApi.md#stationsone) | **GET** /stations/{id} | 


# **stationsAll**
> List<Station> stationsAll()



Get all stations.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();

try {
    final response = api.stationsAll();
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationsAll: $e\n');
}
```

### Parameters
This endpoint does not need any parameter.

### Return type

[**List&lt;Station&gt;**](Station.md)

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

# **stationsConnect**
> Error stationsConnect(id)



Connect to a station's live websocket.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();
final int id = 789; // int | 

try {
    final response = api.stationsConnect(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationsConnect: $e\n');
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

# **stationsOne**
> StationAndSensors stationsOne(id)



Get one station and it's sensors.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getStationApi();
final int id = 789; // int | 

try {
    final response = api.stationsOne(id);
    print(response);
} on DioException catch (e) {
    print('Exception when calling StationApi->stationsOne: $e\n');
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

