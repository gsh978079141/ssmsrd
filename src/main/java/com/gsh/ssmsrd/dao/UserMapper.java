package com.gsh.ssmsrd.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gsh.ssmsrd.model.User;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface UserMapper extends BaseMapper<User> {
    /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    User getUserByUserName(String username);
}
