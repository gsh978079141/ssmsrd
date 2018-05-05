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
@TableName("guest")
public class Guest extends Model<Guest> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 房间号
     */
    private Integer roomid;
    /**
     * 宾客姓名
     */
    private String guestname;
    /**
     * 联系电话
     */
    private String tel;
    /**
     * 客人性别
     */
    private String sex;
    /**
     * 证件类型（默认：0）
1：身份证;
2：学生证;
3：军人证;
4：驾驶证;
5：护照;
6：员工证;
7：其他;

     */
    private Integer idtype;
    /**
     * 证件号码
     */
    private String idnum;
    /**
     * 客人地址
     */
    private String area;
    /**
     * 客人类型（默认：1）
1：普通宾客;
2：VIP客户
3：酒店员工
4：协议单位
     */
    private Integer guesttype;
    /**
     * 客人来源（默认1）
1：散客自入
2：直接预定
3：协议单位

     */
    private Integer guestsource;
    /**
     * 协议单位
     */
    private String corporatename;
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

    public Integer getRoomid() {
        return roomid;
    }

    public void setRoomid(Integer roomid) {
        this.roomid = roomid;
    }

    public String getGuestname() {
        return guestname;
    }

    public void setGuestname(String guestname) {
        this.guestname = guestname;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getIdtype() {
        return idtype;
    }

    public void setIdtype(Integer idtype) {
        this.idtype = idtype;
    }

    public String getIdnum() {
        return idnum;
    }

    public void setIdnum(String idnum) {
        this.idnum = idnum;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Integer getGuesttype() {
        return guesttype;
    }

    public void setGuesttype(Integer guesttype) {
        this.guesttype = guesttype;
    }

    public Integer getGuestsource() {
        return guestsource;
    }

    public void setGuestsource(Integer guestsource) {
        this.guestsource = guestsource;
    }

    public String getCorporatename() {
        return corporatename;
    }

    public void setCorporatename(String corporatename) {
        this.corporatename = corporatename;
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
        return "Guest{" +
        "id=" + id +
        ", roomid=" + roomid +
        ", guestname=" + guestname +
        ", tel=" + tel +
        ", sex=" + sex +
        ", idtype=" + idtype +
        ", idnum=" + idnum +
        ", area=" + area +
        ", guesttype=" + guesttype +
        ", guestsource=" + guestsource +
        ", corporatename=" + corporatename +
        ", remark=" + remark +
        "}";
    }
}
