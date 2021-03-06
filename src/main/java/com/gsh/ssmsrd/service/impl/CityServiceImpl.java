package com.gsh.ssmsrd.service.impl;

import com.baomidou.mybatisplus.service.IService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.CityMapper;
import com.gsh.ssmsrd.model.City;
import org.springframework.stereotype.Service;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@Service
public class CityServiceImpl extends ServiceImpl<CityMapper, City> implements IService<City> {

}
