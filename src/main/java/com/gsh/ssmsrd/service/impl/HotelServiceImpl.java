package com.gsh.ssmsrd.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gsh.ssmsrd.dao.HotelMapper;
import com.gsh.ssmsrd.model.Hotel;
import com.gsh.ssmsrd.service.HotelService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * <p>
 *  服务实现类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@Service
public class HotelServiceImpl extends ServiceImpl<HotelMapper, Hotel> implements HotelService {
    @Resource
    HotelMapper hotelMapper;
    @Override
    public Hotel findByUserId(Integer userid) {
        return hotelMapper.getHotelByUserId(userid);
    }
}
