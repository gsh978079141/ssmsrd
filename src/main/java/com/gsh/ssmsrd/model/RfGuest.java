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
@TableName("rf_guest")
public class RfGuest extends Model<RfGuest> {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;
    /**
     * 宾客来源
     */
    private String guestsource;
    /**
     * 此来源的人数
     */
    private Integer sourcenum;
    /**
     * 宾客类别
     */
    private String guesttype;
    /**
     * 此类型的人数
     */
    private Integer typenum;


    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getGuestsource() {
        return guestsource;
    }

    public void setGuestsource(String guestsource) {
        this.guestsource = guestsource;
    }

    public Integer getSourcenum() {
        return sourcenum;
    }

    public void setSourcenum(Integer sourcenum) {
        this.sourcenum = sourcenum;
    }

    public String getGuesttype() {
        return guesttype;
    }

    public void setGuesttype(String guesttype) {
        this.guesttype = guesttype;
    }

    public Integer getTypenum() {
        return typenum;
    }

    public void setTypenum(Integer typenum) {
        this.typenum = typenum;
    }

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    @Override
    public String toString() {
        return "RfGuest{" +
        "id=" + id +
        ", guestsource=" + guestsource +
        ", sourcenum=" + sourcenum +
        ", guesttype=" + guesttype +
        ", typenum=" + typenum +
        "}";
    }
}
