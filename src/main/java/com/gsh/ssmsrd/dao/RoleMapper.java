package com.gsh.ssmsrd.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gsh.ssmsrd.model.Role;

import java.util.List;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface RoleMapper extends BaseMapper<Role> {
    //根据用户名查找角色信息
     List<Role> listRolesByUserId(int userid);

}
