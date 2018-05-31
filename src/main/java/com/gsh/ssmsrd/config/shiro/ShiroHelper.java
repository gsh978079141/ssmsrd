package com.gsh.ssmsrd.config.shiro;

import com.gsh.ssmsrd.model.User;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.mgt.RealmSecurityManager;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.subject.Subject;

@SuppressWarnings("ALL")
public class ShiroHelper {
    /**
     * 重新赋值权限(在比如:给一个角色临时添加一个权限,需要调用此方法刷新权限,否则还是没有刚赋值的权限)
     * @param  user 用户实体
     */
    public static void reloadAuthorizing(User user) {
        RealmSecurityManager rsm = (RealmSecurityManager) SecurityUtils.getSecurityManager();
        MyShiroRealm shiroRealm = (MyShiroRealm) rsm.getRealms().iterator().next();
        Subject subject = SecurityUtils.getSubject();
        String realmName = subject.getPrincipals().getRealmNames().iterator().next();
        //shiroRealm.clearAllCachedAuthorizationInfo2();//清楚所有用户权限
        //第一个参数为用户名,第二个参数为realmName,test想要操作权限的用户
        SimplePrincipalCollection principals = new SimplePrincipalCollection(user.getUsername(), realmName);
        subject.runAs(principals);
        shiroRealm.getAuthorizationCache().remove(subject.getPrincipals());
        shiroRealm.getAuthorizationCache().remove(user.getUsername());
        subject.releaseRunAs();
    }
}
