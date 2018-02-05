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
use App\Services\EmailService;
use App\Services\VerificationCodeService;
use App\Util\Codes;
use App\Util\TablesName;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\Event;
use Illuminate\Support\Facades\Validator;

class AuthController extends Controller {


    /**
     * @SWG\Post(
     *     path="/api/login",
     *     tags={"Auth"},
     *     summary="用户登录授权接口",
     *     description="",
     *     operationId="base-auth-login",
     *     produces={"application/xml", "application/json"},
     *     @SWG\Parameter(
     *         name="email",
     *         description="邮箱",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Parameter(
     *         name="password",
     *         description="密码",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Response(
     *         response=200,
     *         description="请求成功",
     *         @SWG\Schema(ref="#/definitions/login")
     *     )
     * )
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
     * @SWG\Post(
     *     path="/api/register",
     *     tags={"Auth"},
     *     summary="用户注册接口",
     *     description="",
     *     operationId="base-auth-register",
     *     produces={"application/xml", "application/json"},
     *     @SWG\Parameter(
     *         name="email",
     *         description="邮箱",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Parameter(
     *         name="password",
     *         description="密码",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Parameter(
     *         name="verificationCode",
     *         description="验证码",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Response(
     *         response=200,
     *         description="请求成功"
     *     )
     * )
     */
    public function register(Request $request){
        $res = $this->registerValidation($request);
        if($res !== true) return $res;

        $params = $request->only(['email','password','verificationCode']);

        //验证验证码有效性
        $code = VerificationCodeService::checkVerificationCode(VerificationCodeService::REGISTER_CODE,$params['verificationCode'],$params['email']);
        if($code != Codes::SUCCESS){
            return Tool::apiOutput($code,Codes::$MSG[$code]);
        }

        //触发用户注册事件
        $res = Event::fire(new Register($request,$this->configs['default_avatar']));
        foreach ($res as $one){
            if($one != Codes::SUCCESS){
                return Tool::apiOutput($one,Codes::$MSG[$one]);
            }
        }

        //返回登录凭证
        return Tool::apiOutput(Codes::SUCCESS,Tool::getSequenceAndVoucher($request->get('email')));
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
     * 用户注册传参验证
     * @param $request
     * @return bool|string
     */
    private function registerValidation($request){

        $validator = Validator::make($request->all(),[
            'email'     =>  'required|email|unique:'.TablesName::ADMIN_USERS.'|max:'.$this->configs['email_min_length'],
            'password'  =>  'required|confirmed|min:'.$this->configs['password_min_length'].'|max:'.$this->configs['password_max_length'],
            'verificationCode'  =>  'required|min:'.$this->configs['sms_length'].'|max:'.$this->configs['sms_length']
        ],[
            'email.required'    =>  multilingual('prompt.email').multilingual('valRequired'),
            'email.email'       =>  multilingual('prompt.email').multilingual('prompt.valEmail'),
            'email.unique'      =>  multilingual('prompt.email').multilingual('prompt.valUnique'),
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
     * @SWG\Definition(
     *     definition="login",
     *     type="object",
     *     required={"sequence","voucher"},
     *     @SWG\Property(
     *         property="sequence",
     *         type="string",
     *         description="序列码"
     *     ),
     *     @SWG\Property(
     *         property="voucher",
     *         type="string",
     *         description="凭证"
     *     )
     * )
     */
}