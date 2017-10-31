<?php

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::group(['namespace'=>'Api'],function(){

    //发放登录凭证
    Route::post('/login','AuthController@login');

    //注册
    Route::post('/register','AuthController@register');

    //通用邮件发送接口
    Route::post('/sendEmail','EmailController@sendEmail');

    //============================工具方法=========================
    Route::group(['prefix'=>'tool'],function(){

        //强制更新后台configs缓存
        Route::get('/updateBackendConfigsCache','ToolController@updateBackendConfigsCache');

    });

});