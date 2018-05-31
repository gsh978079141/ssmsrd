package com.gsh.ssmsrd.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.LogMapper;
import com.gsh.ssmsrd.model.Log;
import com.gsh.ssmsrd.service.LogService;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 操作日志记录 服务实现类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@Service
public class LogServiceImpl extends ServiceImpl<LogMapper, Log> implements LogService {

}
