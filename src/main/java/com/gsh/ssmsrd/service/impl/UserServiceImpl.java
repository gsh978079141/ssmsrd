package com.gsh.ssmsrd.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.UserMapper;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.model.User;
import com.gsh.ssmsrd.service.UserService;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@Service
@EnableCaching
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Resource
    private UserMapper userMapper;

    /**
     * 根据用户名查找用户
     * @param username
     * @return
     */
    @Override
    public  User findByUserName(String username){
        return userMapper.getUserByUserName(username);
    }

    /**
     * 根据用户ID查询角色
     * @param userid
     * @return
     */
    @Override
    public Role findRoleByUserId(int userid) {
        return null;
    }
}
