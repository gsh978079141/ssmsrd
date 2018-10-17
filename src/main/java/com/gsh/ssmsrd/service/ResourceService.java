package com.gsh.ssmsrd.service;

import com.baomidou.mybatisplus.service.IService;
import com.gsh.ssmsrd.model.Resource;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.util.TreeDTO;
import org.springframework.cache.annotation.CacheConfig;
import org.springframework.cache.annotation.Cacheable;

import java.util.List;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface ResourceService extends IService<Resource> {
    /**
     * 根据用户ID查询权限
     * @param userid
     * @return
     */
    List<Resource> findByUserId(int userid);

    /**
     * 根据（多个）角色获得权限
     * @param roles
     * @return
     */
    List<Resource> findByRoles(List<Role> roles);
    List<TreeDTO> getChildrenByParentId(int []ids) throws Exception;
    List<Resource> getChildren(int pid) throws Exception;
}
