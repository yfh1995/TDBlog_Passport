<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/11/13
 * Time: 17:26
 */

namespace App\Services;


use App\Util\CacheKey;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;

class VerificationCode {

    //用户注册
    const REGISTER_CODE = 1;

    public static $verificationCodeConfig = [

        //一组验证码的配置
        //  cacheKey        验证码在缓存中的键
        //  cacheTime       缓存时间，单位：s

        //用户注册配置
        self::REGISTER_CODE => [
            'cacheKey'      =>  CacheKey::CodeRegister,
            'cacheTime'     =>  60,
        ],
    ];

    /**
     * 获取验证码（校验是否获取合法）
     * @param int $codeType     验证码类型
     * @param string $unique    唯一标识（邮件发送为邮箱，短信发送为手机号）
     * @return array   [
     *                      'code'  =>  错误码,
     *                      'vCode' =>  验证码
     *                  ]
     */
    public static function getVerificationCode($codeType, $unique){

        $allCodeType = array_keys(self::$verificationCodeConfig);
        if(!in_array($codeType,$allCodeType)){
            Log::error('App\Services\VerificationCode获取验证码失败,未知codeType参数，codeType：'.$codeType);
            return ['code'=>Codes::PARAMS_ERROR];
        }

        // 单位时间内只能发送一次验证码
        if(Cache::get($unique.self::$verificationCodeConfig[$codeType]['cacheKey'])){
            return ['code' => Codes::CANNOT_SEND_EMAIL_WITHIN_TIME];
        }

        //刷新cache
        $code = Tool::getVerificationCode();
        Cache::put($unique.self::$verificationCodeConfig[$codeType]['cacheKey'],$code,self::$verificationCodeConfig[$codeType]['cacheTime']/60);

        return ['code' => Codes::SUCCESS,'vCode'=>$code];
    }

    /**
     * 验证验证码正确与否
     * @param int $codeType     验证码类型
     * @param string $code      验证码
     * @param string $unique    唯一标识（邮件发送为邮箱，短信发送为手机号）
     * @return int 错误码
     */
    public static function checkVerificationCode($codeType, $code, $unique){

        $allCodeType = array_keys(self::$verificationCodeConfig);
        if(!in_array($codeType,$allCodeType)){
            Log::error('App\Services\VerificationCode,未知codeType参数，codeType：'.$codeType);
            return Codes::PARAMS_ERROR;
        }

        // 验证时间
        if(!($realCode = Cache::get($unique.self::$verificationCodeConfig[$codeType]['cacheKey']))){
            return Codes::VERIFICATION_CODE_INVALID_OR_ERROR;
        }

        if($code == $realCode){
            Cache::forget($unique.self::$verificationCodeConfig[$codeType]['cacheKey']);
            return Codes::SUCCESS;
        }
        else return Codes::FAIL;
    }
}