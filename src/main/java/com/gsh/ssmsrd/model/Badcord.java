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
@TableName("badcord")
public class Badcord extends Model<Badcord> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 记录单号
     */
    private String cordnum;
    /**
     * 会员账号
     */
    private String memnum;
    /**
     * 被记录人姓名
     */
    private String cordname;
    /**
     * 记录时间
     */
    private String cordtime;
    /**
     * 不良记录类型
     */
    private String cordtype;
    /**
     * 被记录人电话
     */
    private String tel;
    /**
     * 操作员
     */
    private String bookkeeper;
    /**
     * 详情
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

    public String getCordnum() {
        return cordnum;
    }

    public void setCordnum(String cordnum) {
        this.cordnum = cordnum;
    }

    public String getMemnum() {
        return memnum;
    }

    public void setMemnum(String memnum) {
        this.memnum = memnum;
    }

    public String getCordname() {
        return cordname;
    }

    public void setCordname(String cordname) {
        this.cordname = cordname;
    }

    public String getCordtime() {
        return cordtime;
    }

    public void setCordtime(String cordtime) {
        this.cordtime = cordtime;
    }

    public String getCordtype() {
        return cordtype;
    }

    public void setCordtype(String cordtype) {
        this.cordtype = cordtype;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
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
        return "Badcord{" +
        "id=" + id +
        ", hid=" + hid +
        ", cordnum=" + cordnum +
        ", memnum=" + memnum +
        ", cordname=" + cordname +
        ", cordtime=" + cordtime +
        ", cordtype=" + cordtype +
        ", tel=" + tel +
        ", bookkeeper=" + bookkeeper +
        ", remark=" + remark +
        "}";
    }
}
