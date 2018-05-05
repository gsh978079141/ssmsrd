//package com.gsh.ssmsrd.config;
//
//import net.sf.ehcache.CacheManager;
//import org.springframework.cache.annotation.EnableCaching;
//import org.springframework.cache.ehcache.EhCacheCacheManager;
//import org.springframework.cache.ehcache.EhCacheManagerFactoryBean;
//import org.springframework.context.annotation.Bean;
//import org.springframework.context.annotation.Configuration;
//import org.springframework.core.io.ClassPathResource;
//
///**
//    * @Title: EhCacheConfig
//    * @Package com.gsh.ssmsrd.config
//    * @Description: Ehcache配置
//    * @author gsh
//    * @date 2018/3/31 下午5:57
//    */
//@Configuration
//@EnableCaching
//public class EhCacheConfig {
//
//    /**
//     * EhCache的配置
//     */
//    @Bean
//    public EhCacheCacheManager cacheManager(CacheManager cacheManager) {
//        return new EhCacheCacheManager(cacheManager);
//    }
//
//    /**
//     * EhCache的配置
//     */
//    @Bean
//    public EhCacheManagerFactoryBean ehcache() {
//        EhCacheManagerFactoryBean ehCacheManagerFactoryBean = new EhCacheManagerFactoryBean();
//        ehCacheManagerFactoryBean.setConfigLocation(new ClassPathResource("ehcache.xml"));
//        return ehCacheManagerFactoryBean;
//    }
//}
