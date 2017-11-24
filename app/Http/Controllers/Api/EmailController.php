<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/31
 * Time: 11:12
 */

namespace App\Http\Controllers\Api;


use App\Http\Controllers\Controller;
use App\Services\EmailService;
use App\Util\Tool;
use Illuminate\Http\Request;

class EmailController extends Controller {

    /**
     * 统一邮件发送接口
     * @param EmailService $email
     * @param Request $request
     * @return string
     */
    public function sendEmail(EmailService $email, Request $request){

        $res = $email->sendEmail($request,$this->configs);
        return Tool::apiOutput($res['code'],$res['data']);
    }

}