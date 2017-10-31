<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/25
 * Time: 15:28
 */

namespace App\Http\Controllers\Api;


use App\Events\Register;
use App\Http\Controllers\Controller;
use App\Services\Email;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller {

    /**
     * 登录授权
     * @param Request $request
     * @return string
     */
    public function login(Request $request){
        $res = $this->loginValidation($request);
        if($res !== true) return $res;

        if(Auth::validate(['email'=>$request->get('email'),'password'=>$request->get('password')])){
            return Tool::apiOutput(Codes::SUCCESS,Tool::getSequenceAndVoucher($request->get('email')));
        }else{
            return Tool::apiOutput(Codes::NAME_OR_PASSWORD_ERROR);
        }
    }

    /**
     * 登录参数验证
     * @param $request
     * @return bool
     */
    private function loginValidation($request){

        $validator = Validator::make($request->all(), [
            'email'     =>  'required|email|max:'.$this->configs['email_min_length'],
            'password'  =>  'required|min:'.$this->configs['password_min_length'].'|max:'.$this->configs['password_max_length']
        ],[
            'email.required'    =>  multilingual('prompt.email').multilingual('prompt.valRequired'),
            'email.email'       =>  multilingual('prompt.email').multilingual('prompt.valEmail'),
            'email.max'         =>  multilingual('prompt.email').multilingual('prompt.valMax').$this->configs['email_min_length'],
            'password.required' =>  multilingual('prompt.password').multilingual('prompt.valRequired'),
            'password.min'      =>  multilingual('prompt.password').multilingual('prompt.valMin').$this->configs['password_min_length'],
            'password.max'      =>  multilingual('prompt.password').multilingual('prompt.valMax').$this->configs['password_max_length'],
        ]);

        if ($validator->fails()) {
            return Tool::apiOutput(Codes::PARAMS_ERROR,$validator->errors()->all());
        }
        return true;
    }

    /**
     * 注册
     * @param Request $request
     * @return bool|string
     */
    public function register(Request $request){
        $res = $this->registerValidation($request);
        if($res !== true) return $res;

        $params = $request->only(['email','password','verificationCode']);

        //验证验证码有效性
        if(!$this->registerCodeValidation($params['verificationCode'])){
            return Tool::apiOutput(Codes::VERIFICATION_CODE_INVALID_OR_ERROR);
        }

        //触发用户注册事件
        $res = Event::fire(new Register($request,$this->configs['default_avatar']));
        if($res[0] !== true) return $res;

        //返回登录凭证
        return Tool::apiOutput(Codes::SUCCESS,Tool::getSequenceAndVoucher($request->get('email')));
    }

    /**
     * 用户注册传参验证
     * @param $request
     * @return bool|string
     */
    private function registerValidation($request){

        $validator = Validator::make($request->all(),[
            'email'     =>  'required|email|max:'.$this->configs['email_min_length'],
            'password'  =>  'required|confirmed|min:'.$this->configs['password_min_length'].'|max:'.$this->configs['password_max_length'],
            'verificationCode'  =>  'required|min:'.$this->configs['sms_length'].'|max:'.$this->configs['sms_length']
        ],[
            'email.required'    =>  multilingual('prompt.email').multilingual('valRequired'),
            'email.email'       =>  multilingual('prompt.email').multilingual('prompt.valEmail'),
            'email.max'         =>  multilingual('prompt.email').multilingual('prompt.valMax').$this->configs['email_min_length'],
            'password.required' =>  multilingual('prompt.password').multilingual('prompt.valRequired'),
            'password.min'      =>  multilingual('prompt.password').multilingual('prompt.valMin').$this->configs['password_min_length'],
            'password.max'      =>  multilingual('prompt.password').multilingual('prompt.valMax').$this->configs['password_max_length'],
            'password.confirmed'=>  multilingual('prompt.valPasswordConfirmed'),
            'verificationCode.required' =>  multilingual('prompt.verificationCode').multilingual('prompt.valRequired'),
            'verificationCode.min'      =>  multilingual('prompt.verificationCode').multilingual('prompt.valMin').$this->configs['sms_length'],
            'verificationCode.max'      =>  multilingual('prompt.verificationCode').multilingual('prompt.valMax').$this->configs['sms_length'],
        ]);

        if ($validator->fails()) {
            return Tool::apiOutput(Codes::PARAMS_ERROR,$validator->errors()->all());
        }
        return true;
    }

    /**
     * 验证验证码正确性
     * @param $code
     * @return bool
     */
    private function registerCodeValidation($code){

        $cacheEmail = Cache::get(Email::$emailConfig[Email::REGISTER_EMAIL]['cacheKey']);
        if(!$cacheEmail || !isset($cacheEmail['code'])) return false;

        if($code == $cacheEmail['code']) return true;
        else return false;
    }

}