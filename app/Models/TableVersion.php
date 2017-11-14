<?php

namespace App\Models;

use App\Util\CacheKey;
use App\Util\TablesName;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Cache;
use Illuminate\Support\Facades\DB;

class TableVersion extends Model {

    protected $table = TablesName::BASE_TABLE_VERSION;


    /**
     * 获取受版本控制下的数据表的版本信息
     * @return mixed
     */
    public static function getVersionData(){
        if(!($codes = Cache::get(CacheKey::AdminTableVersion))){
            TableVersion::updateVersionCache();
            $codes = Cache::get(CacheKey::AdminTableVersion);
        }
        return $codes;
    }

    /**
     * 强制更新数据表版本缓存
     */
    public static function updateVersionCache(){
        $version = TableVersion::select(DB::raw('version_code,table_name'))->get();
        Cache::forever(CacheKey::AdminTableVersion,$version->toArray());
        return $version->toArray();
    }

    /**
     *  更新基础配置数据表版本信息
     *  传入格式：
     *  [
     *      'table_id'=>'1',            //数据变更的数据表id
     *      'ids'=>[1,2,3]              //数据变更id
     *  ]
     * @param $data
     * @return mixed
     */
    public static function renew($data){
        $tableVersion = TableVersion::find($data['table_id']);
        $tableVersion->version_code++;
        $rs_tv = $tableVersion->save();
        if($rs_tv) {
            $changes = [];
            foreach($data['ids'] as $v){
                $one = [];
                $one['old_version_code'] = $tableVersion->version_code-1;
                $one['new_version_code'] = $tableVersion->version_code;
                $one['table_name'] = $data['table_name'];
                $one['table_id'] = $v;
                $one['created_at'] = $one['updated_at'] = date('Y-m-d H:i:s');
                $changes[] = $one;
            }
            return TableVersionChanges::add($changes);
        }
        return false;
    }
}
