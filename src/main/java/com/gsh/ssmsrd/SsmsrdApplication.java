package com.gsh.ssmsrd;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;


@SuppressWarnings("ALL")
@SpringBootApplication
@EnableTransactionManagement
public class SsmsrdApplication {
	public static void main(String[] args) {
//		JedisPool jedisPool = new JedisPool("127.0.0.1", 6379);
//		Jedis jedis = jedisPool.getResource();
//		jedis.set("key3", "飞机");
//		System.out.println(jedis.get("key3"));
//		jedis.close();
//		jedisPool.close();
//		@Cacheable 触发缓存入口
//
//		@CacheEvict 触发移除缓存
//
//		@CacahePut 更新缓存
//
//		@Caching 将多种缓存操作分组
//
//		@CacheConfig 类级别的缓存注解，允许共享缓存名称
		SpringApplication.run(SsmsrdApplication.class, args);
	}
}
