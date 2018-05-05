package com.gsh.ssmsrd.config.shiro;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import org.apache.shiro.authc.credential.HashedCredentialsMatcher;
import org.apache.shiro.session.SessionListener;
import org.apache.shiro.spring.LifecycleBeanPostProcessor;
import org.apache.shiro.spring.security.interceptor.AuthorizationAttributeSourceAdvisor;
import org.apache.shiro.spring.web.ShiroFilterFactoryBean;
import org.apache.shiro.web.mgt.DefaultWebSecurityManager;
import org.apache.shiro.web.servlet.SimpleCookie;
import org.apache.shiro.web.session.mgt.DefaultWebSessionManager;
import org.crazycake.shiro.RedisCacheManager;
import org.crazycake.shiro.RedisManager;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.aop.framework.autoproxy.DefaultAdvisorAutoProxyCreator;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.session.data.redis.config.annotation.web.server.RedisWebSessionConfiguration;

@SuppressWarnings("ALL")
@Configuration
@ConfigurationProperties(prefix = "spring.redis")
public class ShiroConfiguration {

    @Value("${spring.redis.host}")
    private String host;

    @Value("${spring.redis.port}")
    private int port;

    @Value("${spring.redis.timeout}")
    private int timeout;

    @Value("${spring.redis.jedis.pool.max-idle}")
    private int maxIdle;

    @Value("${spring.redis.jedis.pool.max-wait}")
    private long maxWaitMillis;

    private static Map<String, String> filterChainDefinitionMap = new LinkedHashMap<String, String>();

    /**
    　* @Description:
    　* @param 自定义自己的realm
    　* @return
    　* @throws
    　*/
    @Bean(name = "myShiroRealm")
    public MyShiroRealm getShiroRealm() {
        MyShiroRealm myShiroRealm=new MyShiroRealm();
        //密码加密开启注释
//        myShiroRealm.setCredentialsMatcher(hashedCredentialsMatcher());
        return  myShiroRealm;
    }

//    @Bean(name = "shiroEhcacheManager")
//    public EhCacheManager getEhCacheManager() {
//        EhCacheManager em = new EhCacheManager();
//        em.setCacheManagerConfigFile("classpath:ehcache.xml");
//        return em;
//    }

    @Bean(name = "lifecycleBeanPostProcessor")
    public static LifecycleBeanPostProcessor getLifecycleBeanPostProcessor() {
        return new LifecycleBeanPostProcessor();
    }

    @Bean
    public DefaultAdvisorAutoProxyCreator getDefaultAdvisorAutoProxyCreator() {
        DefaultAdvisorAutoProxyCreator daap = new DefaultAdvisorAutoProxyCreator();
        daap.setProxyTargetClass(true);
        return daap;
    }
    /**
     * 凭证匹配器
     * （由于我们的密码校验交给Shiro的SimpleAuthenticationInfo进行处理了
     * 密码加密
     *
     * @return
     */
    @Bean
    public HashedCredentialsMatcher hashedCredentialsMatcher() {
        HashedCredentialsMatcher hashedCredentialsMatcher = new HashedCredentialsMatcher();
        hashedCredentialsMatcher.setHashAlgorithmName("md5");//散列算法:这里使用MD5算法;
        hashedCredentialsMatcher.setHashIterations(2);//散列的次数，比如散列两次，相当于 md5(md5(""));
        return hashedCredentialsMatcher;
    }

        @Bean(name = "securityManager")
        public DefaultWebSecurityManager getDefaultWebSecurityManager() {
            DefaultWebSecurityManager dwsm = new DefaultWebSecurityManager();
            dwsm.setRealm(getShiroRealm());
            // 自定义缓存实现 使用redis
            dwsm.setCacheManager(cacheManager());
            // 自定义session管理 使用redis
            dwsm.setSessionManager(sessionManager());
        //        dwsm.setCacheManager(getEhCacheManager());
            return dwsm;
        }
    /**
        * @Title: AuthorizationAttributeSourceAdvisor
        * @Description: 加入注解的使用，不加入这个注解不生效
        */
    @Bean
    public AuthorizationAttributeSourceAdvisor getAuthorizationAttributeSourceAdvisor() {
        AuthorizationAttributeSourceAdvisor aasa = new AuthorizationAttributeSourceAdvisor();
        aasa.setSecurityManager(getDefaultWebSecurityManager());
        return new AuthorizationAttributeSourceAdvisor();
    }
    /**
        * @Title: ShiroFilterFactoryBean
        * @Description:* 注意：单独一个ShiroFilterFactoryBean配置是或报错的，以为在
         * 初始化ShiroFilterFactoryBean的时候需要注入：SecurityManager
         *
        Filter Chain定义说明
        1、一个URL可以配置多个Filter，使用逗号分隔
        2、当设置多个过滤器时，全部验证通过，才视为通过
        3、部分过滤器可指定参数，如perms，roles
        */
    @Bean(name = "shiroFilter")
    public ShiroFilterFactoryBean getShiroFilterFactoryBean() {
        ShiroFilterFactoryBean shiroFilterFactoryBean = new ShiroFilterFactoryBean();
        shiroFilterFactoryBean.setSecurityManager(getDefaultWebSecurityManager());
        //配置不会拦截的url，顺序判断
        // 配置退出过滤器,其中的具体的退出代码Shiro已经替我们实现了
        filterChainDefinitionMap.put("/logout","logout");
        // 防止登录成功之后下载favicon.ico
        filterChainDefinitionMap.put("/favicon.ico", "anon");
        filterChainDefinitionMap.put("/js/**", "anon");
        filterChainDefinitionMap.put("/img/**", "anon");
        filterChainDefinitionMap.put("/css/**", "anon");
        filterChainDefinitionMap.put("/component/**", "anon");
        filterChainDefinitionMap.put("/**.html","anon");
        filterChainDefinitionMap.put("/login.do","anon");
        // <!-- 过滤链定义，从上向下顺序执行，一般将 /**放在最为下边 -->:这是一个坑呢，一不小心代码就不好使了;
        //自定义加载权限资源关系
//        List<Resources> resourcesList = resourcesService.queryAll();
//        for(Resources resources:resourcesList){
//
//            if (StringUtil.isNotEmpty(resources.getResurl())) {
//                String permission = "perms[" + resources.getResurl()+ "]";
//                filterChainDefinitionMap.put(resources.getResurl(),permission);
//            }
//        }
        // <!-- authc:所有url都必须认证通过才可以访问; anon:所有url都都可以匿名访问-->
        filterChainDefinitionMap.put("/**", "authc");
        // 如果不设置默认会自动寻找Web工程根目录下的"/login.jsp"页面
        shiroFilterFactoryBean.setLoginUrl("/loginin.do");
        // 登录成功后要跳转的链接
        shiroFilterFactoryBean.setSuccessUrl("/index.do");
        //未授权界面;
        shiroFilterFactoryBean.setUnauthorizedUrl("/403");
        shiroFilterFactoryBean.setFilterChainDefinitionMap(filterChainDefinitionMap);
        return shiroFilterFactoryBean;
    }
        /**
         * 配置shiro redisManager
         * 使用的是shiro-redis开源插件
         * @return
         */
        @Bean
        public RedisManager redisManager() {
            RedisManager redisManager = new RedisManager();
            redisManager.setHost(host);
            redisManager.setPort(port);
            redisManager.setExpire(1800);// 配置缓存过期时间
            redisManager.setTimeout(timeout);
            // redisManager.setPassword(password);
            return redisManager;
        }
        /**
         * cacheManager 缓存 redis实现
         * 使用的是shiro-redis开源插件
         * @return
         */
        public RedisCacheManager cacheManager() {
            RedisCacheManager redisCacheManager = new RedisCacheManager();
            redisCacheManager.setRedisManager(redisManager());
            return redisCacheManager;
        }
        /**
         * RedisSessionDAO shiro sessionDao层的实现 通过redis
         * 使用的是shiro-redis开源插件
         */
        @Bean
        public RedisSessionDAO redisSessionDAO() {
            RedisSessionDAO redisSessionDAO = new RedisSessionDAO();
            redisSessionDAO.setRedisManager(redisManager());
            return redisSessionDAO;
        }
        /**
         * shiro session的管理
         */
        @Bean
        public DefaultWebSessionManager sessionManager() {
            DefaultWebSessionManager sessionManager = new DefaultWebSessionManager();
            sessionManager.setCacheManager(cacheManager());
            sessionManager.setSessionDAO(redisSessionDAO());
            sessionManager.setGlobalSessionTimeout(3600000);// 设置全局session超时时间
            sessionManager.setSessionValidationSchedulerEnabled(true);// 是否定时检查session
            sessionManager.setDeleteInvalidSessions(true);//删除过期session
            sessionManager.setSessionIdCookieEnabled(true);
            return sessionManager;
        }
    /**
    　* @Description: 记住我功能
    　* @param
    　* @return
    　* @throws
    　* @author gsh
    　* @date 2018/4/19 下午3:59
    　*/
    @Bean(name = "rememberMeCookie")
    public SimpleCookie getRememberMeCookie() {
        SimpleCookie simpleCookie = new SimpleCookie("rememberMe");
        simpleCookie.setHttpOnly(true);
        simpleCookie.setMaxAge(2592000);//30天
        return simpleCookie;
    }

}
