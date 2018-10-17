package com.gsh.ssmsrd.service.impl;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.*;
import com.gsh.ssmsrd.model.Resource;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.model.RoleResource;
import com.gsh.ssmsrd.model.UserRole;
import com.gsh.ssmsrd.service.ResourceService;
import com.gsh.ssmsrd.util.Tools;
import com.gsh.ssmsrd.util.TreeDTO;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

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
@Transactional
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements ResourceService {
    @javax.annotation.Resource
    ResourceMapper resourceMapper;
    @javax.annotation.Resource
    RoleResourceMapper roleResourceMapper;
    @javax.annotation.Resource
    UserRoleMapper userRoleMapper;

    @Override
    public List<Resource> findByUserId(int userid) {
        UserRole userRole=new UserRole();
        userRole.setUserid(userid);
        userRole=userRoleMapper.selectOne(userRole);
        List<Role> roleList=new ArrayList<>();
        Role role=new Role();
        role.setRoleid(userRole.getRoleid());
        roleList.add(role);
        userRole.getRoleid();
        return findByRoles(roleList);
    }
    @Override
    public List<Resource> findByRoles(List<Role> roles) {
        Set<Resource> set = new HashSet();
        List<Resource> list = new  ArrayList();
        List<Resource> newList =new ArrayList<>();
        for (Role role : roles) {
            int roleid = role.getRoleid();
            //声明要查询的实体
            RoleResource roleResource = new RoleResource();
            Session session = SecurityUtils.getSubject().getSession();
            //查询的实体属性赋值
            roleResource.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
            roleResource.setRoleid(roleid);
            //查询
            roleResource = roleResourceMapper.selectOne(roleResource);
            //获得角色权限字符串，形如：1，2，5，8，7...
            String resids = roleResource.getResids();
            //工具类字符串处理后，形如:1 2 3 5 8 7 ....
            String []resid = Tools.str2StrArray(resids, ",");
            List<Integer> idlist = new ArrayList<>();
            for (String id : resid) {
                idlist.add(Integer.parseInt(id));
                //根据ID列表查询多条
            }
            newList=resourceMapper.selectBatchIds(idlist);
        }
        //角色不唯一，有重复权限是时去重
        for (Resource resource:newList) {
            if(set.add(resource)){
                list.add(resource);
            }
        }
        return list;
    }

    /**
     * 根据菜单ID数组拼接权限菜单
     * @param ids
     * @return
     * @throws Exception
     */
    @Override
    public List<TreeDTO> getChildrenByParentId(int[] ids) throws Exception {
        List<Resource> rlist = new ArrayList<Resource>();
        Map selectmap=new HashMap();
        selectmap.put("parent_id",1);
        rlist=resourceMapper.selectByMap(selectmap);
        System.out.println("***************rlist.size="+rlist.size());
        List<TreeDTO> tlist = new ArrayList<TreeDTO>();
        for (Iterator iterator = rlist.iterator(); iterator.hasNext();) {
            Resource resource = (Resource) iterator.next();
            System.out.println(resource.getId());
            TreeDTO tree = new TreeDTO();
            tree.setId(resource.getId());
            tree.setText(resource.getName());
            for(int id:ids){
                if(resource.getId()==id){
                    tree.setChecked(1);
                }
            }
            //tree.setChecked(resource.getChecked());
            tree.setIconCls(resource.getIcon());
            tree.setParentId(resource.getParentId());
            if(getChildren(resource.getId()).size() > 0){
                tree.setState("closed");
            } else {
                tree.setState("open");
            }
            Map<String, Object>  map = new HashMap<String, Object>();
            map.put("url", resource.getUrl());
            tree.setAttributes(map);
            tlist.add(tree);
        }
        return tlist;
    }
    @Override
    public List<Resource> getChildren(int pid) throws Exception {
        Map map=new HashMap();
        map.put("parent_id",pid);
        //System.out.println("getChildren"+children.size());
        return resourceMapper.selectByMap(map);
    }
}
