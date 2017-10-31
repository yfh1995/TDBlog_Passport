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

    //注册邮件类型编号
    const REGISTER_EMAIL = 1;

    public static $emailConfig = [

        //一组邮件发送类型的配置
        //  cacheKey        邮件在缓存中的键
        //  effectiveTime   验证码有效时间，单位：s
        self::REGISTER_EMAIL => [
            'cacheKey'      =>  CacheKey::SendEmailForRegister,
            'effectiveTime' =>  60,
        ],
    ];

    public $configs;

    /**
     * 邮件发送
     * @param $request
     * @param $configs
     * @return array|bool|string
     */
    public function sendEmail($request, $configs){
        $this->configs = $configs;
        $res = $this->sendEmailValidation($request);
        if($res !== true) return $res;

        $res = Tool::apiOutput(Codes::UNKNOWN_ERROR);
        $params = $request->only(['email','emailType']);

        // 单位时间内只能发送一次邮件
        if($cacheEmail = Cache::get(self::$emailConfig[$params['emailType']]['cacheKey'])){
            if(time() - $cacheEmail['time'] <= self::$emailConfig[$params['emailType']]['effectiveTime']) {
                return $this->returnData(Codes::CANNOT_SEND_EMAIL_WITHIN_TIME, self::$emailConfig[$params['emailType']]['effectiveTime'].multilingual('prompt.cannotSendEmailWithinUnitTime'));
            }
        }

        //刷新cache
        $code = Tool::getVerificationCode();
        Cache::put(self::$emailConfig[$params['emailType']]['cacheKey'],['time'=>time(),'code'=>$code],self::$emailConfig[$params['emailType']]['effectiveTime']/60);

        // 1.用户注册时获取验证码邮件

        switch ($params['emailType']){
            case self::REGISTER_EMAIL:
                $isSend = $this->sendRegisterEmail($params['email'],$code);
                if($isSend) $res = $this->returnData(Codes::SUCCESS);
                else{
                    Log::error('\api\sendEmail接口用户注册邮件发送失败，目标email：'.$params['email']);
                    $res = $this->returnData(Codes::FAIL);
                }
                break;
            default:
                Log::error('\api\sendEmail接口emailType参数非法，emailType：'.$params['emailType']);
                break;
        }

        return $res;
    }

    /**
     * 规定服务返回数据格式
     * @param $code
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
     * @param $email
     * @param string $code
     * @return bool
     */
    private function sendRegisterEmail($email, $code = ''){
        if($code == '') $code = Tool::getVerificationCode();

        Mail::to($email)->queue(new RegisterEmail($code));
        return true;
    }
}