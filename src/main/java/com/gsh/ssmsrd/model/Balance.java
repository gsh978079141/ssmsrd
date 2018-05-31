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
@TableName("balance")
public class Balance extends Model<Balance> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店id
     */
    private Integer hid;
    /**
     * 入住单号
     */
    private String ordernum;
    /**
     *  手工单号
     */
    private String handnum;
    /**
     * 收款时间
     */
    private String billtime;
    /**
     * 总计消费金额
     */
    private Double totalmoney;
    /**
     * 现金
     */
    private Double mcash;
    /**
     * 其他支付
     */
    private Double mother;
    /**
     * 操作员
     */
    private String bookkeeper;
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

    public String getOrdernum() {
        return ordernum;
    }

    public void setOrdernum(String ordernum) {
        this.ordernum = ordernum;
    }

    public String getHandnum() {
        return handnum;
    }

    public void setHandnum(String handnum) {
        this.handnum = handnum;
    }

    public String getBilltime() {
        return billtime;
    }

    public void setBilltime(String billtime) {
        this.billtime = billtime;
    }

    public Double getTotalmoney() {
        return totalmoney;
    }

    public void setTotalmoney(Double totalmoney) {
        this.totalmoney = totalmoney;
    }

    public Double getMcash() {
        return mcash;
    }

    public void setMcash(Double mcash) {
        this.mcash = mcash;
    }

    public Double getMother() {
        return mother;
    }

    public void setMother(Double mother) {
        this.mother = mother;
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
        return "Balance{" +
        "id=" + id +
        ", hid=" + hid +
        ", ordernum=" + ordernum +
        ", handnum=" + handnum +
        ", billtime=" + billtime +
        ", totalmoney=" + totalmoney +
        ", mcash=" + mcash +
        ", mother=" + mother +
        ", bookkeeper=" + bookkeeper +
        ", remark=" + remark +
        "}";
    }
}
