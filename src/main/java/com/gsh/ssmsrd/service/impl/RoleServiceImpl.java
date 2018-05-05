package com.gsh.ssmsrd.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.RoleMapper;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.service.RoleService;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@EnableCaching
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {
    @Resource
    RoleMapper roleMapper;
    @Override
    public List<Role> findRoleByUserId(int userid) {
        return roleMapper.listRolesByUserId(userid);
    }
}
