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
@TableName("recharge")
public class Recharge extends Model<Recharge> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 值充单号
     */
    private String recnum;
    private String memnum;
    private Integer paymethod;
    private Double recmoney;
    private String rectime;
    private String bookkeeper;
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

    public String getRecnum() {
        return recnum;
    }

    public void setRecnum(String recnum) {
        this.recnum = recnum;
    }

    public String getMemnum() {
        return memnum;
    }

    public void setMemnum(String memnum) {
        this.memnum = memnum;
    }

    public Integer getPaymethod() {
        return paymethod;
    }

    public void setPaymethod(Integer paymethod) {
        this.paymethod = paymethod;
    }

    public Double getRecmoney() {
        return recmoney;
    }

    public void setRecmoney(Double recmoney) {
        this.recmoney = recmoney;
    }

    public String getRectime() {
        return rectime;
    }

    public void setRectime(String rectime) {
        this.rectime = rectime;
    }

    public String getBookkeeper() {
        return bookkeeper;
    }

    public void setBookkeeper(String bookkeeper) {
        this.bookkeeper = bookkeeper;
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
        return "Recharge{" +
        "id=" + id +
        ", hid=" + hid +
        ", recnum=" + recnum +
        ", memnum=" + memnum +
        ", paymethod=" + paymethod +
        ", recmoney=" + recmoney +
        ", rectime=" + rectime +
        ", bookkeeper=" + bookkeeper +
        ", remark=" + remark +
        "}";
    }
}
