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
@TableName("rgood")
public class Rgood extends Model<Rgood> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 商品简码
     */
    private String spjm;
    /**
     * 商品名
     */
    private String spname;
    /**
     * 商品价格
     */
    private Double spprice;
    /**
     * 库存
     */
    private Integer amount;
    /**
     * 商品类型
     */
    private String sptype;
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

    public String getSpjm() {
        return spjm;
    }

    public void setSpjm(String spjm) {
        this.spjm = spjm;
    }

    public String getSpname() {
        return spname;
    }

    public void setSpname(String spname) {
        this.spname = spname;
    }

    public Double getSpprice() {
        return spprice;
    }

    public void setSpprice(Double spprice) {
        this.spprice = spprice;
    }

    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    public String getSptype() {
        return sptype;
    }

    public void setSptype(String sptype) {
        this.sptype = sptype;
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
        return "Rgood{" +
        "id=" + id +
        ", spjm=" + spjm +
        ", spname=" + spname +
        ", spprice=" + spprice +
        ", amount=" + amount +
        ", sptype=" + sptype +
        ", remark=" + remark +
        "}";
    }
}
