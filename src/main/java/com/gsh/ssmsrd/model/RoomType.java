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
@TableName("room_type")
public class RoomType extends Model<RoomType> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 房型名称
     */
    private String typename;
    /**
     * 房型代号
     */
    private String typecode;
    /**
     * 房价
     */
    private Double roomprice;
    /**
     * 押金
     */
    private Double deposit;
    /**
     * 钟点房价
     */
    private Double hourprice;
    /**
     * 特价房是否有折扣（0否，1是）
     */
    private Integer sprice;
    /**
     * 房型是否启用：1启用0停用
     */
    private Integer state;
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

    public String getTypecode() {
        return typecode;
    }

    public void setTypecode(String typecode) {
        this.typecode = typecode;
    }

    public Double getRoomprice() {
        return roomprice;
    }

    public void setRoomprice(Double roomprice) {
        this.roomprice = roomprice;
    }

    public Double getDeposit() {
        return deposit;
    }

    public void setDeposit(Double deposit) {
        this.deposit = deposit;
    }

    public Double getHourprice() {
        return hourprice;
    }

    public void setHourprice(Double hourprice) {
        this.hourprice = hourprice;
    }

    public Integer getSprice() {
        return sprice;
    }

    public void setSprice(Integer sprice) {
        this.sprice = sprice;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
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
        return "RoomType{" +
        "id=" + id +
        ", hid=" + hid +
        ", typename=" + typename +
        ", typecode=" + typecode +
        ", roomprice=" + roomprice +
        ", deposit=" + deposit +
        ", hourprice=" + hourprice +
        ", sprice=" + sprice +
        ", state=" + state +
        ", remark=" + remark +
        "}";
    }
}
