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
@TableName("room")
public class Room extends Model<Room> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    private String roomnum;
    private Integer roomtype;
    private String roompwd;
    /**
     * 房间状态
1空房;
2预留;
3打扫;
4维修;
5在住
1只有：2,3,4
5时只有：5


     */
    private Integer roomstate;
    /**
     * 房间电话
     */
    private String tel;
    /**
     * 所在楼层
     */
    private Integer floor;
    /**
     * 1有窗0无
     */
    private Integer window;
    /**
     * 是否为钟点房1是0否
     */
    private Integer hourday;
    /**
     * 实际价格
     */
    private Double relprice;
    /**
     * 此时间之前可入住
     */
    private String starttime;
    /**
     * 次时间之后可入住
     */
    private String endtime;
    /**
     * 房间状态（1正常0停用）
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

    public String getRoomnum() {
        return roomnum;
    }

    public void setRoomnum(String roomnum) {
        this.roomnum = roomnum;
    }

    public Integer getRoomtype() {
        return roomtype;
    }

    public void setRoomtype(Integer roomtype) {
        this.roomtype = roomtype;
    }

    public String getRoompwd() {
        return roompwd;
    }

    public void setRoompwd(String roompwd) {
        this.roompwd = roompwd;
    }

    public Integer getRoomstate() {
        return roomstate;
    }

    public void setRoomstate(Integer roomstate) {
        this.roomstate = roomstate;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public Integer getFloor() {
        return floor;
    }

    public void setFloor(Integer floor) {
        this.floor = floor;
    }

    public Integer getWindow() {
        return window;
    }

    public void setWindow(Integer window) {
        this.window = window;
    }

    public Integer getHourday() {
        return hourday;
    }

    public void setHourday(Integer hourday) {
        this.hourday = hourday;
    }

    public Double getRelprice() {
        return relprice;
    }

    public void setRelprice(Double relprice) {
        this.relprice = relprice;
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
        return "Room{" +
        "id=" + id +
        ", hid=" + hid +
        ", roomnum=" + roomnum +
        ", roomtype=" + roomtype +
        ", roompwd=" + roompwd +
        ", roomstate=" + roomstate +
        ", tel=" + tel +
        ", floor=" + floor +
        ", window=" + window +
        ", hourday=" + hourday +
        ", relprice=" + relprice +
        ", starttime=" + starttime +
        ", endtime=" + endtime +
        ", state=" + state +
        ", remark=" + remark +
        "}";
    }
}
