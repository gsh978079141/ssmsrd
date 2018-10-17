package com.gsh.ssmsrd.service;

import com.baomidou.mybatisplus.service.IService;
import com.gsh.ssmsrd.model.Role;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface RoleService extends IService<Role> {
    /**
     * 根据用户名查找角色信息
     * @param userid
     * @return
     */
    List<Role> findRoleByUserId(int userid);
}
