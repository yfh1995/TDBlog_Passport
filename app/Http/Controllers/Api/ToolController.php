<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/31
 * Time: 13:50
 */

namespace App\Http\Controllers\Api;


use App\Configs;
use App\Http\Controllers\Controller;
use App\Util\Codes;
use App\Util\Tool;

class ToolController extends Controller {

    /**
     * 强制更新后台configs缓存
     * @return string
     */
    public function updateBackendConfigsCache(){
        Configs::updateConfigsCache();
        return Tool::apiOutput(Codes::SUCCESS);
    }

}