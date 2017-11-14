<?php

namespace App\Listeners;

use App\Events\Register;
use App\User;
use App\Util\Codes;
use App\Util\Tool;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class RegisterListener
{
    /**
     * RegisterListener constructor.
     */
    public function __construct()
    {
        //
    }

    /**
     * 用户注册事件处理
     *
     * @param  Register  $event
     * @return int
     */
    public function handle(Register $event)
    {
        $email = $event->request->get('email');
        $password = $event->request->get('password');
        $avatar = $event->avatar;

        DB::beginTransaction();

        //注册admin_users表
        $user = User::create([
            'name'      =>  $email,
            'email'     =>  $email,
            'password'  =>  bcrypt($password),
            'avatar'    =>  $avatar
        ]);
        if(!$user){
            Log::error('用户注册，生成admin_users表数据失败，用户email：'.$email.'，password：'.$password);
            DB::rollback();
            return Codes::DATA_CREATE_ERROR;
        }

        DB::commit();

        return Codes::SUCCESS;
    }
}
