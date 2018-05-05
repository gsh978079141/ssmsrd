package com.gsh.ssmsrd.model;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import com.baomidou.mybatisplus.enums.IdType;

import java.io.Serializable;

/**
 * <p>
 * InnoDB free: 3072 kB; (`memid`) REFER `jxxkhotel/members`(`i
 * </p>
 *
 * @author gsh123
 * @since 2018-03-22
 */
@TableName("reserve")
public class Reserve extends Model<Reserve> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    /**
     * 订单号
     */
    private String resnumber;
    /**
     * 房间号(空则系统随机一间类型房)
     */
    private String roomnum;
    /**
     * 会员卡号
     */
    private String memnum;
    /**
     * 预定人姓名
     */
    private String resname;
    /**
     * 预订电话
     */
    private String restel;
    /**
     * 预抵时间
     */
    private String starttime;
    /**
     * 预离时间
     */
    private String endtime;
    /**
     * 预订时间
     */
    private String restime;
    /**
     * 订单状态（默认正常；取消）
     */
    private String resstate;
    /**
     * 公司名称
     */
    private String comname;
    private Integer ressource;
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

    public String getResnumber() {
        return resnumber;
    }

    public void setResnumber(String resnumber) {
        this.resnumber = resnumber;
    }

    public String getRoomnum() {
        return roomnum;
    }

    public void setRoomnum(String roomnum) {
        this.roomnum = roomnum;
    }

    public String getMemnum() {
        return memnum;
    }

    public void setMemnum(String memnum) {
        this.memnum = memnum;
    }

    public String getResname() {
        return resname;
    }

    public void setResname(String resname) {
        this.resname = resname;
    }

    public String getRestel() {
        return restel;
    }

    public void setRestel(String restel) {
        this.restel = restel;
    }

    public String getStarttime() {
        return starttime;
    }

    public void setStarttime(String starttime) {
        this.starttime = starttime;
    }

    public String getEndtime() {
        return endtime;
    }

    public void setEndtime(String endtime) {
        this.endtime = endtime;
    }

    public String getRestime() {
        return restime;
    }

    public void setRestime(String restime) {
        this.restime = restime;
    }

    public String getResstate() {
        return resstate;
    }

    public void setResstate(String resstate) {
        this.resstate = resstate;
    }

    public String getComname() {
        return comname;
    }

    public void setComname(String comname) {
        this.comname = comname;
    }

    public Integer getRessource() {
        return ressource;
    }

    public void setRessource(Integer ressource) {
        this.ressource = ressource;
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
        return "Reserve{" +
        "id=" + id +
        ", hid=" + hid +
        ", resnumber=" + resnumber +
        ", roomnum=" + roomnum +
        ", memnum=" + memnum +
        ", resname=" + resname +
        ", restel=" + restel +
        ", starttime=" + starttime +
        ", endtime=" + endtime +
        ", restime=" + restime +
        ", resstate=" + resstate +
        ", comname=" + comname +
        ", ressource=" + ressource +
        ", remark=" + remark +
        "}";
    }
}
