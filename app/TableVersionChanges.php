<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class TableVersionChanges extends Model {

    protected $table = 'base_table_version_changes';

    /**
     * 校验数据表版本信息，发现非法数据返回false，否则返回需要更新的数据
     * @param $data         版本字符串，格式：0,1,0,4,5.....，对应表顺序默认与数据库存储顺序一致
     * @return array|bool   返回更新数据格式：
     * [
     *      'table_name':[
     *          ['id'=>1,'name'=>2.....],
     *          ['id'=>2,'name'=>3.....]
     *      ],
     *      'table_name':[
     *          ['id'=>1,'num'=>2.....],
     *          ['id'=>2,'num'=>3.....]
     *      ],
     * ]
     */
    public static function getVersionTableData($data){
        $old_codes = explode(',',$data);

        //获取数据表版本信息
        $new_codes = TableVersion::getVersionData();

        $change_data = [];
        foreach($new_codes as $k=>$v){
            if($v['version_code']<$old_codes[$k]['version_code']) return false;
            else if($v['version_code']>$old_codes[$k]['version_code'])
                $change_data[$v['table_name']] = TableVersionChanges::getOneVersionTableSomeData($v['table_name'],$old_codes[$k]['version_code']+1,$v['version_code']);
        }
        return $change_data;
    }

    /**
     * 获取某张受版本控制的数据表中，指定版本区间段的变更数据，取闭区间段
     * @param $table_name
     * @param null $old_version_code    为空则为起始版本
     * @param null $new_version_code    为空则为最新版本
     * @return bool|mixed               获取成功则返回数组数据，失败返回false
     */
    public static function getOneVersionTableSomeData($table_name,$old_version_code = null,$new_version_code = null){
        if($old_version_code == null) $old_version_code = 0;
        if($new_version_code == null){
            //获取数据表版本信息
            $codes = TableVersion::getVersionData();
            foreach($codes as $v){
                if($v['table_name'] == $table_name){
                    $new_version_code = $v['version_code'];
                    break;
                }
            }
            if(!$new_version_code) return false;
        }

        $table_ids = TableVersionChanges::where('table_name',$table_name)
            ->whereBetween('new_version_code',[$old_version_code,$new_version_code])
            ->lists('table_id');
        if(!$table_ids) return false;

        $data = DB::table($table_name)->whereIn('id',$table_ids)->get()->toArray();
        if(!$data) return false;

        return $data;
    }

    /**
     * 获取受版本控制的数据表中的所有数据
     * @return array
     */
    public static function getAllVersionTableData(){
        //获取数据表版本信息
        $codes = TableVersion::getVersionData();

        $bases = [];
        foreach($codes as $v){
            $one = DB::table($v['table_name'])->get();
            $bases[$v['table_name']] = CommonTools::object_to_array($one);
        }
        return $bases;
    }

    /**
     * 获取非版本控制下的所有配置表可被当前用户获取的信息
     * @return array
     */
    public static function getAllPrivateTableData(){
        $data = [];
        //获取base_emoticon_group中可被当前用户利用的表情组信息
        $data['base_emoticon_group'] = TableVersionChanges::getOnePrivateTableData('base_emoticon_group');
        //获取base_emoticons中可被当前用户利用的表情信息
        $data['base_emoticons'] = TableVersionChanges::getOnePrivateTableData('base_emoticons');

        return $data;
    }

    /**
     * 获取非版本控制下的某张配置表可被当前用户获取的信息
     * @param $table_name
     * @return mixed
     */
    public static function getOnePrivateTableData($table_name){
        $data = DB::table($table_name)->whereIn('owner_id',[0,Auth::user()->id])->get();
        return CommonTools::object_to_array($data);
    }

    /**
     *  传入格式：
     *  [
     *      ['old_version_code'=>0,'new_version_code'=>1,'table_name'=>'base_configs','table_id'=>1,'created_at'=>'','updated_at'=>''],
     *      ['old_version_code'=>0,'new_version_code'=>1,'table_name'=>'base_configs','table_id'=>2,'created_at'=>'','updated_at'=>''],
     *      ['old_version_code'=>0,'new_version_code'=>1,'table_name'=>'base_configs','table_id'=>3,'created_at'=>'','updated_at'=>'']
     *  ]
     * @param $data
     * @return mixed
     */
    public static function add($data){
        return TableVersionChanges::insert($data);
    }
}
