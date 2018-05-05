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
@TableName("mem_type")
public class MemType extends Model<MemType> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 会员类型名称
     */
    private String typename;
    /**
     * 卡费
     */
    private Double cardfee;
    /**
     * 升级所需积分
     */
    private Double uppoints;
    /**
     * 房费折扣率
     */
    private Double roomrate;
    /**
     * 商品消费折扣率
     */
    private Double goodrate;
    /**
     * 代表没消费多少金额增加一分（默认十）
     */
    private Integer pointsrule;
    /**
     * 默认1（使用）0停用
     */
    private Integer state;
    /**
     * 可逾期记录次数
     */
    private Integer overdue;
    /**
     * 特价房是否享受会员折扣（0否，1是）
     */
    private Integer sprice;
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

    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getTypename() {
        return typename;
    }

    public void setTypename(String typename) {
        this.typename = typename;
    }

    public Double getCardfee() {
        return cardfee;
    }

    public void setCardfee(Double cardfee) {
        this.cardfee = cardfee;
    }

    public Double getUppoints() {
        return uppoints;
    }

    public void setUppoints(Double uppoints) {
        this.uppoints = uppoints;
    }

    public Double getRoomrate() {
        return roomrate;
    }

    public void setRoomrate(Double roomrate) {
        this.roomrate = roomrate;
    }

    public Double getGoodrate() {
        return goodrate;
    }

    public void setGoodrate(Double goodrate) {
        this.goodrate = goodrate;
    }

    public Integer getPointsrule() {
        return pointsrule;
    }

    public void setPointsrule(Integer pointsrule) {
        this.pointsrule = pointsrule;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public Integer getOverdue() {
        return overdue;
    }

    public void setOverdue(Integer overdue) {
        this.overdue = overdue;
    }

    public Integer getSprice() {
        return sprice;
    }

    public void setSprice(Integer sprice) {
        this.sprice = sprice;
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
        return "MemType{" +
        "id=" + id +
        ", hid=" + hid +
        ", typename=" + typename +
        ", cardfee=" + cardfee +
        ", uppoints=" + uppoints +
        ", roomrate=" + roomrate +
        ", goodrate=" + goodrate +
        ", pointsrule=" + pointsrule +
        ", state=" + state +
        ", overdue=" + overdue +
        ", sprice=" + sprice +
        ", remark=" + remark +
        "}";
    }
}
