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
@TableName("members")
public class Members extends Model<Members> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 酒店ID
     */
    private Integer hid;
    private String memnum;
    private String memname;
    private String mempass;
    private String sex;
    private Integer age;
    private String tel;
    private String area;
    /**
     * 默认1（普通会员）
     */
    private Integer memtype;
    /**
     * 默认身份证
     */
    private Integer idtype;
    private String idnum;
    private String birthday;
    private String starttime;
    private String endtime;
    private Double totalmoney;
    private Double leftmoney;
    private Double totalpoints;
    private Double usedpoints;
    private Double leftpoints;
    /**
     * 不良费消记录
     */
    private Integer badrecord;
    /**
     * 默认正常（1），挂失（2），黑名单（3）
     */
    private String state;
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

    public String getMemnum() {
        return memnum;
    }

    public void setMemnum(String memnum) {
        this.memnum = memnum;
    }

    public String getMemname() {
        return memname;
    }

    public void setMemname(String memname) {
        this.memname = memname;
    }

    public String getMempass() {
        return mempass;
    }

    public void setMempass(String mempass) {
        this.mempass = mempass;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public Integer getAge() {
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public Integer getMemtype() {
        return memtype;
    }

    public void setMemtype(Integer memtype) {
        this.memtype = memtype;
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

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
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

    public Double getTotalmoney() {
        return totalmoney;
    }

    public void setTotalmoney(Double totalmoney) {
        this.totalmoney = totalmoney;
    }

    public Double getLeftmoney() {
        return leftmoney;
    }

    public void setLeftmoney(Double leftmoney) {
        this.leftmoney = leftmoney;
    }

    public Double getTotalpoints() {
        return totalpoints;
    }

    public void setTotalpoints(Double totalpoints) {
        this.totalpoints = totalpoints;
    }

    public Double getUsedpoints() {
        return usedpoints;
    }

    public void setUsedpoints(Double usedpoints) {
        this.usedpoints = usedpoints;
    }

    public Double getLeftpoints() {
        return leftpoints;
    }

    public void setLeftpoints(Double leftpoints) {
        this.leftpoints = leftpoints;
    }

    public Integer getBadrecord() {
        return badrecord;
    }

    public void setBadrecord(Integer badrecord) {
        this.badrecord = badrecord;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
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
        return "Members{" +
        "id=" + id +
        ", hid=" + hid +
        ", memnum=" + memnum +
        ", memname=" + memname +
        ", mempass=" + mempass +
        ", sex=" + sex +
        ", age=" + age +
        ", tel=" + tel +
        ", area=" + area +
        ", memtype=" + memtype +
        ", idtype=" + idtype +
        ", idnum=" + idnum +
        ", birthday=" + birthday +
        ", starttime=" + starttime +
        ", endtime=" + endtime +
        ", totalmoney=" + totalmoney +
        ", leftmoney=" + leftmoney +
        ", totalpoints=" + totalpoints +
        ", usedpoints=" + usedpoints +
        ", leftpoints=" + leftpoints +
        ", badrecord=" + badrecord +
        ", state=" + state +
        ", remark=" + remark +
        "}";
    }
}
