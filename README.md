# AFNetworking
网络请求的工具类的
1.iOS 10以后的版本，如果配置了其他的key，那NSAllowsArbitraryLoads会被忽视，导致http请求失败
2.在header文件中设置相关的APPKey和SecretKey
3.使用了YYCache，需要导入sqlite3.tbd
