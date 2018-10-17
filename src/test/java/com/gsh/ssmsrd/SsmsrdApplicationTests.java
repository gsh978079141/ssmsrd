package com.gsh.ssmsrd;

import org.crazycake.shiro.RedisManager;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;

@RunWith(SpringRunner.class)
@SpringBootTest
public class SsmsrdApplicationTests {
	@Autowired
	RedisManager redisManager;
	@Test
	public void contextLoads() {

	}

}
