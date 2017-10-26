<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/26
 * Time: 13:08
 */

if (! function_exists('app_name')) {
    /**
     * Helper to grab the application name
     *
     * @return mixed
     */
    function app_name()
    {
        $app_name = \App\Configs::select('value')->where(['key'=>'app_name'])->first();
        return $app_name ? $app_name->value : config('app.name');
    }
}

if (! function_exists('user')) {
    /**
     * Helper to grab the application name
     *
     * @return mixed
     */
    function user()
    {
        return \App\User::user();
    }
}

if (! function_exists('multilingual')) {
    /**
     * 获取多语言句子
     *
     * @param $word
     *
     * @return string
     */
    function multilingual($word)
    {
        return \App\Util\Tool::multilingual($word);
    }
}