<?php
/**
 * Created by PhpStorm.
 * User: fuhao
 * Date: 2017/5/21
 * Time: 16:16
 */

namespace App\Util;

/**
 * 设置所有用到的cache key，避免冲突
 * Class CacheKey
 * @package App\Util
 */
class CacheKey{

    //数据表在缓存中的键

    const AdminTableVersion = 'admin_table_version';
    const AdminConfig = 'admin_config';
    const AdminMenu = 'admin_menu';
    const AdminModules = 'admin_modules';
    const AdminPermissions = 'admin_permissions';
    const AdminResource = 'admin_resource';
    const AdminRoles = 'admin_roles';
    const AdminRoleMenu = 'admin_role_menu';
    const AdminRolePermissions = 'admin_role_permission';
    const AdminRoleUser = 'admin_role_user';
    const AdminUserPermissions = 'admin_user_permissions';

    //邮件在缓存中的键

    const EmailRegister = 'email_register';

    //验证码在缓存中的键

    const CodeRegister = 'code_register';
}