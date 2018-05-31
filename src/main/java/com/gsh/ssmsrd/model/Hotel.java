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
@TableName("hotel")
public class Hotel extends Model<Hotel> {

    private static final long serialVersionUID = 1L;

    /**
     * 酒店id
     */
    @TableId(value = "hid", type = IdType.AUTO)
    private Integer hid;
    /**
     * 酒店编号
     */
    private String hnum;
    /**
     * 酒店名称
     */
    private String hname;
    /**
     * 酒店等级/类型(1经济型酒店2星级酒店3豪华酒店)
     */
    private Integer hlevel;
    /**
     * 酒店负责人联系方式
     */
    private String hchargetel;
    /**
     * 酒店地址
     */
    private String hadress;
    /**
     * 是否有添加分店权限(1有，0没有)
     */
    private Integer haskid;
    /**
     * 备注
     */
    private String remark;


    public Integer getHid() {
        return hid;
    }

    public void setHid(Integer hid) {
        this.hid = hid;
    }

    public String getHnum() {
        return hnum;
    }

    public void setHnum(String hnum) {
        this.hnum = hnum;
    }

    public String getHname() {
        return hname;
    }

    public void setHname(String hname) {
        this.hname = hname;
    }

    public Integer getHlevel() {
        return hlevel;
    }

    public void setHlevel(Integer hlevel) {
        this.hlevel = hlevel;
    }

    public String getHchargetel() {
        return hchargetel;
    }

    public void setHchargetel(String hchargetel) {
        this.hchargetel = hchargetel;
    }

    public String getHadress() {
        return hadress;
    }

    public void setHadress(String hadress) {
        this.hadress = hadress;
    }

    public Integer getHaskid() {
        return haskid;
    }

    public void setHaskid(Integer haskid) {
        this.haskid = haskid;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Override
    protected Serializable pkVal() {
        return this.hid;
    }

    @Override
    public String toString() {
        return "Hotel{" +
        "hid=" + hid +
        ", hnum=" + hnum +
        ", hname=" + hname +
        ", hlevel=" + hlevel +
        ", hchargetel=" + hchargetel +
        ", hadress=" + hadress +
        ", haskid=" + haskid +
        ", remark=" + remark +
        "}";
    }
}
