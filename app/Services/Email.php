<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/30
 * Time: 11:41
 */

namespace App\Services;


use App\Mail\RegisterEmail;
use App\Util\CacheKey;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class Email {

    //账号注册邮件
    const REGISTER_EMAIL = 1;

    //邮件发送配置
    public static $emailConfig = [
        //一组验证码的配置
        //  cacheKey        邮件在缓存中的键
        //  cacheTime       缓存时间，单位：s

        //用户注册配置
        self::REGISTER_EMAIL    =>  [
            'cacheKey'  =>  CacheKey::EmailRegister,
            'cacheTime' =>  60,
        ],
    ];

    //配置表信息
    public $configs;

    /**
     * 邮件发送
     * @param $request
     * @param $configs
     * @return array
     */
    public function sendEmail($request, $configs){
        $this->configs = $configs;
        $res = $this->sendEmailValidation($request);
        if($res !== true) return $res;

        //获取参数
        $params = $request->only(['email','emailType']);

        //防止重复发送
        if(Cache::get($params['email'].self::$emailConfig[$params['emailType']]['cacheKey'])){
            return $this->returnData(Codes::CANNOT_SEND_EMAIL_WITHIN_TIME,Codes::$MSG[Codes::CANNOT_SEND_EMAIL_WITHIN_TIME]);
        }

        //刷新缓存
        Cache::put($params['email'].self::$emailConfig[$params['emailType']]['cacheKey'],true,self::$emailConfig[$params['emailType']]['cacheTime']/60);

        switch ($params['emailType']){
            // 1.用户注册时获取验证码邮件
            case self::REGISTER_EMAIL:
                $code = $this->sendRegisterEmail($params['email']);
                $res = $this->returnData($code,Codes::$MSG[$code]);
                break;
            default:
                $res = $this->returnData(Codes::PARAMS_ERROR,Codes::$MSG[Codes::PARAMS_ERROR]);
                break;
        }

        //记录错误日志
        if($res['code'] != Codes::SUCCESS){
            Log::error('\api\sendEmail接口用户注册邮件发送失败，目标email：'.$params['email'].'，错误code：'.$res['code'].'，错误信息：'.$res['data']);
        }

        return $res;
    }

    /**
     * 规定服务返回数据格式
     * @param int $code
     * @param string $data
     * @return array
     */
    private function returnData($code, $data = ''){

        return [
            'code'  =>  $code,
            'data'  =>  $data
        ];
    }

    /**
     * 验证邮件发送参数
     * @param $request
     * @return bool|array
     */
    private function sendEmailValidation($request){

        $validator = Validator::make($request->all(),[
            'email'     =>  'required|email|max:'.$this->configs['email_min_length'],
            'emailType'      =>  ['required','numeric',Rule::in(array_keys(self::$emailConfig))]
        ],[
            'email.required'    =>  multilingual('prompt.email').multilingual('prompt.valRequired'),
            'email.email'       =>  multilingual('prompt.email').multilingual('prompt.valEmail'),
            'email.max'         =>  multilingual('prompt.email').multilingual('prompt.valMax').$this->configs['email_min_length'],
            'emailType.required'=>  multilingual('prompt.emailType').multilingual('prompt.valRequired'),
            'emailType.numeric' =>  multilingual('prompt.emailType').multilingual('prompt.valNumeric'),
            'emailType.in'      =>  multilingual('prompt.emailType').multilingual('prompt.valIn')
        ]);

        if ($validator->fails()) {
            return $this->returnData(Codes::PARAMS_ERROR,$validator->errors()->all());
        }
        return true;
    }

    /**
     * 发送注册邮件
     * @param string $email
     * @return int
     */
    private function sendRegisterEmail($email){
        $code = VerificationCode::getVerificationCode(VerificationCode::REGISTER_CODE, $email);
        if($code['code'] != Codes::SUCCESS) return $code['code'];

        Mail::to($email)->queue(new RegisterEmail($code['vCode']));
        return $code['code'];
    }
}