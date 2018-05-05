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
@TableName("room_con_list")
public class RoomConList extends Model<RoomConList> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 项目名称
     */
    private String itemname;
    /**
     * 项目价格
     */
    private Double itemprice;
    /**
     * 消费数量
     */
    private Integer amount;
    /**
     * 支付方式（默认6入账；）
     */
    private Integer paymethod;
    /**
     * 总价(默认：项目价格*消费数量)
     */
    private Double totalprice;
    /**
     * 支付金额
     */
    private Double payprice;
    /**
     * 服务员（默认0，不需要服务员）
     */
    private Integer waiter;
    /**
     * 操作员
     */
    private String bookkeeper;
    private Integer consumid;
    /**
     * 入账时间
     */
    private String bookitime;
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

    public String getItemname() {
        return itemname;
    }

    public void setItemname(String itemname) {
        this.itemname = itemname;
    }

    public Double getItemprice() {
        return itemprice;
    }

    public void setItemprice(Double itemprice) {
        this.itemprice = itemprice;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public Integer getPaymethod() {
        return paymethod;
    }

    public void setPaymethod(Integer paymethod) {
        this.paymethod = paymethod;
    }

    public Double getTotalprice() {
        return totalprice;
    }

    public void setTotalprice(Double totalprice) {
        this.totalprice = totalprice;
    }

    public Double getPayprice() {
        return payprice;
    }

    public void setPayprice(Double payprice) {
        this.payprice = payprice;
    }

    public Integer getWaiter() {
        return waiter;
    }

    public void setWaiter(Integer waiter) {
        this.waiter = waiter;
    }

    public String getBookkeeper() {
        return bookkeeper;
    }

    public void setBookkeeper(String bookkeeper) {
        this.bookkeeper = bookkeeper;
    }

    public Integer getConsumid() {
        return consumid;
    }

    public void setConsumid(Integer consumid) {
        this.consumid = consumid;
    }

    public String getBookitime() {
        return bookitime;
    }

    public void setBookitime(String bookitime) {
        this.bookitime = bookitime;
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
        return "RoomConList{" +
        "id=" + id +
        ", itemname=" + itemname +
        ", itemprice=" + itemprice +
        ", amount=" + amount +
        ", paymethod=" + paymethod +
        ", totalprice=" + totalprice +
        ", payprice=" + payprice +
        ", waiter=" + waiter +
        ", bookkeeper=" + bookkeeper +
        ", consumid=" + consumid +
        ", bookitime=" + bookitime +
        ", remark=" + remark +
        "}";
    }
}
