// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

#import <Flutter/Flutter.h>

@protocol FlutterBinaryMessenger;
@protocol FlutterMessageCodec;
@class FlutterError;
@class FlutterStandardTypedData;

@interface FLTPigeon : NSObject <FlutterPlugin>
@end

NS_ASSUME_NONNULL_BEGIN

@class Req;
@class Res;

@interface Req : NSObject
@property(nonatomic, copy, nullable) NSString *key;
@property(nonatomic, strong, nullable) NSDictionary *data;
@end

@interface Res : NSObject
@property(nonatomic, copy, nullable) NSString *key;
@property(nonatomic, strong, nullable) NSDictionary *data;
@end

/// The codec used by ReqApi.
NSObject <FlutterMessageCodec> *ReqApiGetCodec(void);

@protocol ReqApi
- (nullable Res

*)requestRequest:(Req *)
request error
:(
FlutterError *_Nullable
*_Nonnull)
error;
@end

extern void ReqApiSetup(id <FlutterBinaryMessenger> binaryMessenger, NSObject <ReqApi> *_Nullable api);

NS_ASSUME_NONNULL_END
