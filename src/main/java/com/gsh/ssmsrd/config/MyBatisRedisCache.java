package com.gsh.ssmsrd.config;

import java.util.concurrent.locks.ReadWriteLock;
import java.util.concurrent.locks.ReentrantReadWriteLock;

import com.gsh.ssmsrd.util.SerializeUtil;
import org.apache.ibatis.cache.Cache;
import org.crazycake.shiro.RedisManager;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
/**
    * @Title: MyBatisRedisCache
    * @Package com.gsh.ssmsrd.config
    * @Description: Redis-Mybatis Cache 实现类缓存进Redis
    * @author gsh
    * @date 2018/4/20 上午12:26
    */
public class MyBatisRedisCache implements Cache {
    private static Logger logger = LoggerFactory.getLogger(MyBatisRedisCache.class);

//    private Jedis redisClient = createReids();
    private RedisManager redisManager=new RedisManager();

    private final ReadWriteLock readWriteLock = new ReentrantReadWriteLock();

    private String id;

    public MyBatisRedisCache(final String id) {
        if (id == null) {
            throw new IllegalArgumentException("Cache instances require an ID");
        }
        logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>MybatisRedisCache:id=" + id);
        this.id = id;
    }

    @Override
    public String getId() {
        return this.id;
    }

    @Override
    public int getSize() {
//        return Integer.valueOf(redisClient.dbSize().toString());
        return Integer.valueOf(redisManager.dbSize().toString());
    }

    @Override
    public void putObject(Object key, Object value) {
        logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>putObject:" + key + "=" + value);
//        redisClient.set(SerializeUtil.serialize(key.toString()), SerializeUtil.serialize(value));
        redisManager.set(SerializeUtil.serialize(key.toString()), SerializeUtil.serialize(value));
    }

    @Override
    public Object getObject(Object key) {
        Object value = SerializeUtil.unserialize(redisManager.get(SerializeUtil.serialize(key.toString())));
        logger.debug(">>>>>>>>>>>>>>>>>>>>>>>>getObject:" + key + "=" + value);
        return value;
    }

    @Override
    public Object removeObject(Object key) {
       return  redisManager.set(SerializeUtil.serialize(key.toString()),null, 0);
//        return redisManager.expire(SerializeUtil.serialize(key.toString()), 0);
    }

    @Override
    public void clear() {
        redisManager.flushDB();
    }

    @Override
    public ReadWriteLock getReadWriteLock() {
        return readWriteLock;
    }

//    protected static Jedis createReids() {
//        RedisCacheManager redisCacheManager=new RedisCacheManager();
//        redisCacheManager.getRedisManager().
//        JedisPool pool = new JedisPool("127.0.0.1", 6379);
//        return pool.getResource();
//    }
}