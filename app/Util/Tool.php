<?php
/**
 * Created by PhpStorm.
 * User: yfh69
 * Date: 2017/10/25
 * Time: 15:41
 */

namespace App\Util;


use Illuminate\Support\Facades\Lang;

class Tool {

    public static function apiOutput($code, $data = ''){

        header('Content-type:text/json;charset=utf-8');

        $return['code'] = $code;
        $return['msg'] = Codes::$MSG[$code];
        $return['data'] = $data;
        return json_encode($return);
    }

    /**
     * 获取验证码
     * @return int
     */
    public static function getVerificationCode(){
        return rand(100000,999999);
    }

    /**
     * 获取多语言句子
     * @param $word
     * @return string
     */
    public static function multilingual($word){
        return Lang::has($word) ? Lang::get($word) : '未查询到此翻译';
    }

    /**
     * 生成盐值映射表
     */
    private static function getSaltMap(){
        $str = 'zxcvbnmasdfghjklqwertyuiop1234567890!@#$%^&*()';
        $str = str_shuffle($str);

        $array = [];
        $len = strlen($str);
        for($i=0;$i<$len;$i++){
            $array[$str[$i]] = [];
        }

        for($i=0;$i<$len;$i++){
            $cnt = 0;
            $ls = str_shuffle($str);
            for($j=0;$j<$len;$j++){
                if($ls[$j]!=$str[$i] && !in_array($str[$i],$array[$ls[$j]])){
                    $array[$str[$i]][] = '\''.$ls[$j].'\'';
                    if(++$cnt == 10) break;
                }
            }
        }

        $string = '[';
        foreach ($array as $k=>$one){
            $string .= '\''.$k.'\'=>['.implode(',',$one).'],';
        }
        $string = substr($string, 0, -1);
        $string .= ']';

        dd($string);
    }

    /**
     * 获取登录凭证
     * @return array
     */
    public static function getSequenceAndVoucher($email){

        //定义序列码长度
        $seqLen = config('TDConfig.seqLen');
        $saltMap = config('TDConfig.saltMap');

        //生成序列码
        $keys = array_keys($saltMap);
        $sequenceIndex = array_rand($keys,$seqLen);

        //获取盐值
        $str = '';
        $sequence = '';
        for($i=0;$i<$seqLen;$i++){
            $sequence .= $keys[$sequenceIndex[$i]];
            $str .= $saltMap[$keys[$sequenceIndex[$i]]][abs(ord($keys[$sequenceIndex[$i]])-ord($keys[$sequenceIndex[($i+1)%$seqLen]]))%$seqLen];
        }

        //获取加密文本（盐值+整10时间戳+email+站点密码）
        $str .= (int)(time()/10)*10 . $email . config('TDConfig.password');

        //hash加密
        $voucher = hash('sha256',$str);
        return [
            'sequence'  =>  $sequence,
            'voucher'   =>  $voucher
        ];
    }

}