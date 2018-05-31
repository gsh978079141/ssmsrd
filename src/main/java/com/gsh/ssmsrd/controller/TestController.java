package com.gsh.ssmsrd.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.gsh.ssmsrd.model.*;
import com.gsh.ssmsrd.service.*;
import com.gsh.ssmsrd.util.Tools;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

@SuppressWarnings("ALL")
@Controller
public class TestController {
    @Resource
    UserService userService;
    @Autowired
    RoleService roleService;
    @Autowired
    RoleResourceService roleResourceService;
    @Autowired
    UserRoleService userRoleService;
    @Autowired
    HotelService hotelService;
    @Autowired
    HotelUserService hotelUserService;
    @RequestMapping("/user")
    @ResponseBody
    public List Test() {

        List list = userService.selectList(null);
//        pu=userService.selectPage(pu,uw);
//        System.out.println("总得记录数为："+list.size());
//        System.out.println(pu);
//        list=userService.findUserByUsername("gsh");
//        System.out.println(list.size());
//        System.out.println(userService.findUserByUsername("gsh"));

        return list;
    }

    @RequestMapping("/userBySelfMethod")
    @ResponseBody
    public User dataUsersSelfMethod(String username) {
        System.out.println("gsh");
        User user= userService.selectById(1);
        return user;
    }

    @RequestMapping("/role.do")
    @ResponseBody
    public List<Role> dataRoles(String rname) {
        Wrapper<Role> ew = new EntityWrapper<>();
        List<Role> roles = roleService.selectList(ew);
        return roles;
    }

    @RequestMapping("/roleBySelfMethod")
    @ResponseBody
    public List<Role> dataRolesSelfMethod(String rname) {
        return null;
    }

    @RequestMapping("/logintest.do")
    @ResponseBody
    public String roleres(User user){
        User u =userService.findByUserName(user.getUsername());
        //获取用户角色
        List<Role> roles=roleService.findRoleByUserId(u.getId());
        for (Role role :roles){
            int roleid=role.getRoleid();
            EntityWrapper<RoleResource> ew= new EntityWrapper();
            RoleResource roleResource=roleResourceService.selectOne(ew);
            String restr =roleResource.getResids();
            System.out.println("restr"+restr);
            Tools.str2StrArray(restr,",");
            for (String test : Tools.str2StrArray(restr,",")){
                System.out.println(test);
            }
        }
        EntityWrapper<Hotel> hotelew=new EntityWrapper<>();
        EntityWrapper<HotelUser> hoteluserew =new EntityWrapper<>();
        hotelew.getSqlSelect();
        return "";
    }
}
