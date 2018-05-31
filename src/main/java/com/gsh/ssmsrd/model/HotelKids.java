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
@TableName("hotel_kids")
public class HotelKids extends Model<HotelKids> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 主店id
     */
    private Integer pidhid;
    /**
     * 分店id
     */
    private Integer kidhid;
    /**
     * 备注
     */
    private String remark;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPidhid() {
        return pidhid;
    }

    public void setPidhid(Integer pidhid) {
        this.pidhid = pidhid;
    }

    public Integer getKidhid() {
        return kidhid;
    }

    public void setKidhid(Integer kidhid) {
        this.kidhid = kidhid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "HotelKids{" +
        "id=" + id +
        ", pidhid=" + pidhid +
        ", kidhid=" + kidhid +
        ", remark=" + remark +
        "}";
    }
}
