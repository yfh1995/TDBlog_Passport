<?php

use Illuminate\Http\Request;

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

//发放登录凭证
Route::post('/login','Api\AuthController@login');

//注册
Route::post('/register','Api\AuthController@register');

//通用邮件发送接口
Route::post('/sendEmail','Api\EmailController@sendEmail');