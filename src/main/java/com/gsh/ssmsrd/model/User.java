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
@SuppressWarnings("ALL")
@TableName("user")
/**
 * 对于User类中有而user表中没有的属性需要加第二个注解@TableField(exist = false),表示排除User类中的属性.
 */
public class User extends Model<User> implements Serializable {
    private static final long serialVersionUID = 1L;
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    private Integer hid;
    private String usernum;
    private String username;
    private String password;
    /**
     * 用户状态0正常 1冻结 2 临时用户 3 其他
     */
    private Integer state;
    /**
     * 手机号
     */
    private String tel;
    /**
     * 电子邮件
     */
    private String email;
    private String sex;
    private Integer age;
    private String birthday;
    private Integer city;
    private String salary;
    private String starttime;
    private String endtime;
    private String description;


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

    public String getUsernum() {
        return usernum;
    }

    public void setUsernum(String usernum) {
        this.usernum = usernum;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
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

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public Integer getCity() {
        return city;
    }

    public void setCity(Integer city) {
        this.city = city;
    }

    public String getSalary() {
        return salary;
    }

    public void setSalary(String salary) {
        this.salary = salary;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getState() {return state; }

    public void setState(Integer state) { this.state = state; }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "User{" +
        "id=" + id +
        ", hid=" + hid +
        ", usernum=" + usernum +
        ", username=" + username +
        ", password=" + password +
        ", tel=" + tel +
        ", email=" + email +
        ", sex=" + sex +
        ", age=" + age +
        ", birthday=" + birthday +
        ", city=" + city +
        ", salary=" + salary +
        ", starttime=" + starttime +
        ", endtime=" + endtime +
        ", description=" + description +
        "}";
    }
}
