package com.gsh.ssmsrd.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * 
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@TableName("guest_type")
public class GuestType extends Model<GuestType> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private String gtypename;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGtypename() {
        return gtypename;
    }

    public void setGtypename(String gtypename) {
        this.gtypename = gtypename;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "GuestType{" +
        "id=" + id +
        ", gtypename=" + gtypename +
        "}";
    }
}
