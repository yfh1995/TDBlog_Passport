<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/25
 * Time: 15:28
 */

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class LoginController extends Controller {

    /**
     * 登录授权
     * @param Request $request
     */
    public function login(Request $request){
        if(!$this->loginValidation($request)) return;

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

}