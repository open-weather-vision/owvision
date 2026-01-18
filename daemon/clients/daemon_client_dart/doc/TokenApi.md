# owvision_daemon_client_dart.api.TokenApi

## Load the API package
```dart
import 'package:owvision_daemon_client_dart/api.dart';
```

All URIs are relative to *http://127.0.0.1:7070/api/v1*

Method | HTTP request | Description
------------- | ------------- | -------------
[**tokenGenerate**](TokenApi.md#tokengenerate) | **POST** /tokens | 


# **tokenGenerate**
> String tokenGenerate(role)



Generates a new token. Only succeeds if you are authenticated using an admin token, or once using the init token `%12345678%`.

### Example
```dart
import 'package:owvision_daemon_client_dart/api.dart';

final api = OwvisionDaemonClientDart().getTokenApi();
final TokenRole role = ; // TokenRole | 

try {
    final response = api.tokenGenerate(role);
    print(response);
} on DioException catch (e) {
    print('Exception when calling TokenApi->tokenGenerate: $e\n');
}
```

### Parameters

Name | Type | Description  | Notes
------------- | ------------- | ------------- | -------------
 **role** | [**TokenRole**](.md)|  | 

### Return type

**String**

### Authorization

[BearerAuth](../README.md#BearerAuth)

### HTTP request headers

 - **Content-Type**: Not defined
 - **Accept**: text/plain, application/json

[[Back to top]](#) [[Back to API list]](../README.md#documentation-for-api-endpoints) [[Back to Model list]](../README.md#documentation-for-models) [[Back to README]](../README.md)

