package com.gsh.ssmsrd.dao;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gsh.ssmsrd.model.Hotel;

/**
 * <p>
 *  Mapper 接口
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
public interface HotelMapper extends BaseMapper<Hotel> {
    /**
     * 根据用户ID查询酒店
     * @param userid
     * @return
     */
     Hotel getHotelByUserId(Integer userid);
}
