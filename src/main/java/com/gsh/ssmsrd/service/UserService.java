package com.gsh.ssmsrd.service;

import com.baomidou.mybatisplus.service.IService;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.model.User;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface UserService extends IService<User> {
    /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    User findByUserName(String username);

    /**
     * 根据用户名查找角色信息
     * @param userid
     * @return
     */
    Role findRoleByUserId(int userid);
}
