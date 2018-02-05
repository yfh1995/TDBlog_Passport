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
     * @SWG\Post(
     *     path="/api/sendEmail",
     *     tags={"Email"},
     *     summary="统一邮件发送接口",
     *     description="",
     *     operationId="base-email-login",
     *     produces={"application/xml", "application/json"},
     *     @SWG\Parameter(
     *         name="email",
     *         description="邮箱",
     *         required=true,
     *         type="string",
     *         format="string"
     *     ),
     *     @SWG\Parameter(
     *         name="emailType",
     *         description="邮件类型",
     *         required=true,
     *         type="integer",
     *         format="int32"
     *     ),
     *     @SWG\Response(
     *         response=200,
     *         description="请求成功"
     *     )
     * )
     */
    public function sendEmail(EmailService $email, Request $request){

        $res = $email->sendEmail($request,$this->configs);
        return Tool::apiOutput($res['code'],$res['data']);
    }

}