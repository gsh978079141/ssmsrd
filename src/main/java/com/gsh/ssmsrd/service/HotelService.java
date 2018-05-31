package com.gsh.ssmsrd.service;

import com.baomidou.mybatisplus.service.IService;
import com.gsh.ssmsrd.model.Hotel;

/**
 * <p>
 *  服务类
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface HotelService extends IService<Hotel> {
    //根据用户Id查询所属酒店信息
     Hotel findByUserId(Integer userid);
}
