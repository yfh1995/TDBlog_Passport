<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/30
 * Time: 11:41
 */

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Mail\RegisterEmail;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Session;
use Illuminate\Support\Facades\Validator;
use Illuminate\Validation\Rule;

class EmailController extends Controller {

    // 邮件发送单位时间，单位：s
    const UNIT_TIME = 60;

    const REGISTER_EMAIL = 1;

    public static $emailType = [
        self::REGISTER_EMAIL,
    ];

    /**
     * 统一邮件发送接口
     * @param Request $request
     * @return bool|string
     */
    public function sendEmail(Request $request){
        $res = $this->sendEmailValidation($request);
        if($res !== true) return $res;

        $res = Tool::apiOutput(Codes::UNKNOWN_ERROR);
        $params = $request->only(['email','emailType']);

        // 单位时间内只能发送一次邮件
        if(Session::has('sendEmail_'.$params['emailType'])){
            $lastTime = Session::pull('sendEmail_'.$params['emailType']);
            if(time() - $lastTime <= self::UNIT_TIME) {
                return Tool::apiOutput(Codes::CANNOT_SEND_EMAIL_WITHIN_TIME,self::UNIT_TIME.multilingual('prompt.cannotSendEmailWithinUnitTime'));
            }else{
                Session::put('sendEmail_'.$params['emailType'],time());
            }
        }
        else{
            Session::put('sendEmail_'.$params['emailType'],time());
        }

        // 1.用户注册时获取验证码邮件

        switch ($params['emailType']){
            case self::REGISTER_EMAIL:
                $isSend = $this->sendRegisterEmail($params['email']);
                if($isSend) $res = Tool::apiOutput(Codes::SUCCESS);
                else{
                    Log::error('\api\sendEmail接口用户注册邮件发送失败，目标email：'.$params['email']);
                    $res = Tool::apiOutput(Codes::FAIL);
                }
                break;
            default:
                Log::error('\api\sendEmail接口emailType参数非法，emailType：'.$params['emailType']);
                break;
        }

        return $res;
    }

    /**
     * 验证邮件发送参数
     * @param $request
     * @return bool|string
     */
    private function sendEmailValidation($request){

        $validator = Validator::make($request->all(),[
            'email'     =>  'required|email|max:'.$this->configs['email_min_length'],
            'emailType'      =>  ['required','numeric',Rule::in(self::$emailType)]
        ],[
            'email.required'    =>  multilingual('prompt.email').multilingual('prompt.valRequired'),
            'email.email'       =>  multilingual('prompt.email').multilingual('prompt.valEmail'),
            'email.max'         =>  multilingual('prompt.email').multilingual('prompt.valMax').$this->configs['email_min_length'],
            'emailType.required'=>  multilingual('prompt.emailType').multilingual('prompt.valRequired'),
            'emailType.numeric' =>  multilingual('prompt.emailType').multilingual('prompt.valNumeric'),
            'emailType.in'      =>  multilingual('prompt.emailType').multilingual('prompt.valIn')
        ]);

        if ($validator->fails()) {
            return Tool::apiOutput(Codes::PARAMS_ERROR,$validator->errors()->all());
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