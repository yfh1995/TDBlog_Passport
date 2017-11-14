<?php

namespace App\Models;

use App\Util\CacheKey;
use App\Util\TablesName;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class Configs extends Model {

    const TABLE_VERSION_NO = 1;

    const STATUS_CLOSE = 0;  //关闭配置
    const STATUS_OPEN = 1; //开启配置

    protected $table = TablesName::ADMIN_CONFIGS;

    public static function getStatusCode($status){
        if($status == self::STATUS_OPEN) return '开启';
        else if($status == self::STATUS_CLOSE) return '关闭';
        else return '未知状态';
    }

    /**
     * @param $data
     * @return bool|mixed 成功返回插入数据id，否则返回false
     */
    public function add($data){
        DB::beginTransaction();

        //添加configs表数据
        $this->module_id = $data['module_id'];
        $this->key = $data['key'];
        $this->value = $data['value'];
        $res_ac = $this->save();

        //更新版本信息
        $res_atv = $this->updateTableVersion([$this->id]);
        if($res_ac && $res_atv){
            DB::commit();
            //更新base_configs表缓存
            $this->updateConfigsCache();
            return $this->id;
        }
        DB::rollback();
        return false;
    }

    /**
     * @param $data
     * @return bool|mixed 成功返回更新数据id，否则返回false
     */
    public function edit($data){
        DB::beginTransaction();

        //更新configs表信息
        if(!($config = Configs::find($data['id']))){
            DB::rollback();
            return false;
        }
        $config->module_id = $data['module_id'];
        $config->key = $data['key'];
        $config->value = $data['value'];
        $res_ac = $config->save();

        //更新版本信息
        $res_atv = $this->updateTableVersion([$data['id']]);
        if($res_ac && $res_atv){
            DB::commit();
            //更新base_configs表缓存
            $this->updateConfigsCache();
            return $config->id;
        }
        DB::rollback();
        return false;
    }

    /**
     * @param $data
     * @return int 返回删除数据数量
     */
    public function dele($data){
        DB::beginTransaction();

        //删除configs表信息
        $num = $this->destroy($data);

        //更新版本信息
        $res_atv = $this->updateTableVersion($data);
        if($num == count($data) && $res_atv){
            DB::commit();
            //更新base_configs表缓存
            $this->updateConfigsCache();
            return $num;
        }
        DB::rollback();
        return false;
    }

    public static function getConfigs(){
        if(!($configs = Cache::get(CacheKey::AdminConfig))){
            $configs = Configs::updateConfigsCache();
        }

        return $configs;
    }

    /**
     * 更新configs表缓存信息
     * @return mixed
     */
    public static function updateConfigsCache(){
        $configs = Configs::where('status',Configs::STATUS_OPEN)->get()->toArray();
        Cache::forever(CacheKey::AdminConfig,$configs);
        return $configs;
    }

    /**
     * 更新版本信息
     * @param array $ids
     * @return mixed
     */
    protected function updateTableVersion($ids){
        return TableVersion::renew([
            'table_id'      =>  self::TABLE_VERSION_NO,
            'ids'           =>  $ids
        ]);
    }
}
