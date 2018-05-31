package com.gsh.ssmsrd.config.shiro;

import com.gsh.ssmsrd.model.Hotel;
import com.gsh.ssmsrd.model.Resource;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.model.User;
import com.gsh.ssmsrd.service.*;
import com.gsh.ssmsrd.util.Tools;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Lazy;

import java.util.*;

@SuppressWarnings("ALL")
public class MyShiroRealm extends AuthorizingRealm {

    @Autowired
    @Lazy
    UserService userService;
    @Autowired
    @Lazy
    RoleService roleService;
    @Autowired
    @Lazy
    ResourceService resourceService;
    @Autowired
    @Lazy
    RoleResourceService roleResourceService;
    @Autowired
    @Lazy
    HotelService hotelService;
    /**
     * 授权用户权限
     *说如果在shiro配置文件中添加了filterChainDefinitionMap.put(“/add”, “perms[权限添加]”);
     * 就说明访问/add这个链接必须要有“权限添加”这个权限才可以访问，
     * 如果在shiro配置文件中添加了filterChainDefinitionMap.put(“/add”, “roles[100002]，perms[权限添加]”);
     * 就说明访问/add这个链接必须要有“权限添加”这个权限和具有“100002”这个角色才可以访问。
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {
        System.out.println("用户授权");
        //获取当前登录输入的用户名，等价于
        // (String) principalCollection.fromRealm(getName()).iterator().next();
//      String loginName = (String) super.getAvailablePrincipal(principalCollection);
        //获取用户
        User user = (User) principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo info =  new SimpleAuthorizationInfo();
        //获取用户角色信息
        List<Role> roles=roleService.findRoleByUserId(user.getId());
        Set<String> roleSet = new HashSet<String>();
        //用户角色id集合
        List<Integer> roleid =new ArrayList<>();
        for (Role role:roles){
            //添加Shiro角色
            roleSet.add(role.getRolecode());
            roleid.add(role.getRoleid());
        }
        //角色信息加入session
        Session session=SecurityUtils.getSubject().getSession();
        session.setAttribute("roleInfo",roles);
        session.setAttribute("roleId",roleid);
        //根据roles(角色list)查找所有权限
        List<Resource> resources=resourceService.findByRoles(roles);
        Set<String> permissionSet = new HashSet<String>();
        for (Resource resource :resources){
            String url = resource.getUrl();
            if("button".equals(url)) {
                //如果是
                String perm=resource.getPerms();
                permissionSet.add(perm);
            }
            else if (Tools.notEmpty(url)){
                info.addStringPermission(url);
            }

        }
        //获取用户角色
//        Set<String> roleSet = new HashSet<String>();
//        roleSet.add("100002");
//        info.setRoles(roleSet);
        info.setRoles(roleSet);
        info.setStringPermissions(permissionSet);
        System.out.println(" MyShiro 中 info.getStringPermissions()"+info.getStringPermissions());
        return info;
    }

    /**
     * 验证用户身份
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(
            AuthenticationToken authcToken) throws AuthenticationException {
        System.out.println("验证用户身份");
//        String password = String.valueOf(token.getPassword());
        //获取输入的用户名
        UsernamePasswordToken token= (UsernamePasswordToken) authcToken;
        String username= token.getUsername();
        if (Tools.isEmpty(username)){return null;}
        //根据用户名查找数据库
        User userInfo=userService.findByUserName(username);
        if (userInfo==null) {return  null;}
        Hotel hotelInfo= hotelService.findByUserId(userInfo.getId());
        //实际项目中，这里可以根据实际情况做缓存，如果不做，Shiro自己也是有时间间隔机制，2分钟内不会重复执行该方
//        Map<String, Object>    map = new HashMap<String, Object>();
//        map.put("nickname", username);
//        //密码进行加密处理  明文为  password+name
//        String paw = password+username;
//        String pawDES = MyDES.encryptBasedDes(paw);
//        map.put("pswd", "paw");
//        hotelew.setSqlSelect("select * from hotelInfo where hid = (select hid from hotel_user where uid = "+userInfo.getId()+")");
//        Hotel hotelInfo =hotelService.selectOne(hotelew);
        Session session = SecurityUtils.getSubject().getSession();
        session.setAttribute("userInfo",userInfo);
        session.setAttribute("userId", userInfo.getId());
        session.setAttribute("hotelInfo",hotelInfo);
        session.setAttribute("hotelId",hotelInfo.getHid());
//        session.setAttribute("hotelInfo",hotelInfo);
//        session.setAttribute("hotelId",hotelInfo.getHid());
        SimpleAuthenticationInfo info = new SimpleAuthenticationInfo(userInfo,userInfo.getPassword(),this.getName());
        return info;
    }

}