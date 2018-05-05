//package com.gsh.ssmsrd.controller;
//
//import com.baomidou.mybatisplus.mapper.EntityWrapper;
//import com.baomidou.mybatisplus.plugins.Page;
//import com.gsh.ssmsrd.model.*;
//import com.gsh.ssmsrd.service.*;
//import com.gsh.ssmsrd.util.DateUtil;
//import org.springframework.stereotype.Controller;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.servlet.http.HttpSession;
//import java.util.HashMap;
//import java.util.Map;
//
//@Controller
//@RequestMapping("mem")
//public class MemberControl {
//    private MemTypeService memTypeService;
//    private RecService recService;
//    private MemService memService;
//    private ConService conService;
//    private RoomCService roomCService;
//    private GoodService goodService;
//
//
//    //private RecService recService;
//
//    /**
//     * 获取会员列表
//     *
//     * @param m：页面查询的信息
//     * @param p         ：分页信息
//     * @return
//     */
//    @RequestMapping("/getlist.do")
//    @ResponseBody
//    public Map<String, Object> getlist(Members m, PageInfo p) {
//        Map<String, Object> map = new HashMap<String, Object>();
//        EntityWrapper<Members> wrapper=new EntityWrapper<>();
//        wrapper.setEntity(m);
//        Page<Members> page=new Page<>();
//        page.setSize(1);
//        page.setOffset(5);
//        map.put("total", memService.selectList(wrapper));
//        map.put("rows", memService.selectPage(page, wrapper));
//        return map;
//    }
//    /**
//     *
//     <p style="color:green;">Description :会员列表</p>
//     * Map<String,Object>
//     * @param m
//     * @return
//     */
//	/*@RequestMapping("/searchmem.do")
//	@ResponseBody
//	public Map<String, Object> search(Members m){
//		Map<String, Object> map=new HashMap<String, Object>();
//		String  memnum = m.getMemnum()== null?"":m.getMemnum();
//		String  memname = m.getMemname()== null?"":m.getMemname();
//		String  birth = m.getBirthday()== null?"":m.getBirthday();
//		int state=m.getState()== null?0:m.getState();
//		int  memtype=1;
//		if( m.getMemType().getId()!=null){
//			memtype = m.getMemType().getId()== null?null:m.getMemType().getId();
//		}
//			Map<String, Object> param = new HashMap<String, Object>();
//			param.put("memnum", memnum);
//			param.put("memname", memname);
//			param.put("memType.id", memtype);
//			map.put("rlist",memService.searchbymap(param));
//		return map;
//	}*/
//
//    /**
//     * <p style="color:green;">Description :会员信息动态多条件查询</p>
//     * Map<String,Object>
//     *
//     * @param m
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/crisearch.do")
//    @ResponseBody
//    public Map<String, Object> crisearch(Members m, PageInfo p, HttpSession session) throws Exception {
//        if (m.getMemType() == null) {
//            MemType mt = new MemType();
//            mt.setId(0);
//            mt.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//            m.setMemType(mt);
//        }
//        if (m.getMemType().getId() == 0)
//            m.setMemType(null);
//        if (("").equals(m.getMemnum()))
//            m.setMemnum(null);
//        if (("").equals(m.getMemname()))
//            m.setMemname(null);
//        if (p.getPage() == null) {
//            p.setPage(1);
//        }
//        if (p.getSize() == null) {
//            p.setSize(10);
//        }
//        Map<String, Object> map = new HashMap<String, Object>();
//        //map.put("total", memService.getTotal(m));
//        //map.put("rows", memService.findcri(m, p.getPage(), p.getSize()));
//        //map.put("memlist", memService.findcriteria(m, 1, 5));
//        return map;
//    }
//
//    /**
//     * <p style="color:green;">Description :会员卡挂失、黑名单等状态操作</p>
//     * Map<String,String>
//     *
//     * @param memid
//     * @param cz
//     * @return
//     */
//    @RequestMapping("/memstatecz.do")
//    @ResponseBody
//    public Map<String, String> memstatecz(int memid, int cz) {
//        Map<String, String> map = new HashMap<String, String>();
//        Members m = memService.selectById(memid);
//        if (cz != 4) {
//            if (cz > 3)
//                m.setState(1);
//            else
//                m.setState(cz);
//            memService.updateById(m);
//        } else memService.deleteById(m.getId());
//        map.put("msg", "ok");
//        return map;
//    }
//
//    /**
//     * <p style="color:green;">Description :会员信息修改保存</p>
//     * Map<String,String>
//     *
//     * @param m 会员信息
//     * @return
//     */
//    @RequestMapping("/savemem.do")
//    @ResponseBody
//    public Map<String, String> memupdate(Members m) {
//        Map<String, String> map = new HashMap<String, String>();
////        Members mem = memService.selectById(m.getId());
////        mem.setMempass(m.getMempass());
////        mem.setRemark(m.getRemark());
////        mem.setEndtime(m.getEndtime());
////        mem.setMemname(m.getMemname());
//        memService.updateById(m);
//        map.put("msg", "ok");
//        return map;
//    }
//
//    /**
//     * Description:<p style="color:red"> 会员储值卡支付积分于余额更新</p>
//     *
//     * @param id     会员id
//     * @param mempay 支付/消费金额
//     * @return
//     */
//    @RequestMapping("/pay.do")
//    @ResponseBody
//    public String pay(int id, double mempay, int conid, HttpSession session) {
//        Members mem = memService.selectById(id);
//        //得到消费账单
//        Consumption c = conService.selectById(conid);
//        //声明房间消费清单
//        RoomConList rc = new RoomConList();
//        //支付方式
//        Paymethod p = new Paymethod();
//        p.setId(4);
//        rc.setItemname("储值卡支付");
//        rc.setItemprice(mempay);
//        rc.setAmount(1);
//        rc.setBookitime(DateUtil.getTime());
//        rc.setBookkeeper(session.getAttribute("username").toString());
//        rc.setPaymethod(p);
//        rc.setTotalprice(0.0);
//        rc.setPayprice(mempay);
//        rc.setConsumption(c);
//        //保存进房间消费明细表
//        roomCService.update();
//        //得到积分规则和金额明细
//        int pointrule = mem.getMemType().getPointsrule();
//        double leftmoney = mem.getLeftmoney();
//        double leftpoints = mem.getLeftpoints();
//        double totalpoints = mem.getTotalpoints();
//        int conpoint = (int) (mempay / pointrule);
//        //修改会员信息
//        mem.setLeftmoney(leftmoney - mempay);
//        mem.setLeftpoints(leftpoints + conpoint);
//        mem.setTotalpoints(totalpoints + conpoint);
//        memService.update(mem);
//
//        return "";
//    }
//
//    /**
//     * Description:<p style="color:red"> 新增会员</p>
//     *
//     * @param m 会员信息实体封装
//     * @param
//     * @return
//     */
//    @RequestMapping("/addmem.do")
//    @ResponseBody
//    public Map<String, String> addmem(Members m, HttpSession session) {
//        Map<String, String> map = new HashMap<String, String>();
//        m.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        m.setStarttime(DateUtil.getDay());
//        //日期中文替换
//        String birth = m.getBirthday().replaceAll("[^x00-xff]*", "-");
//        m.setBirthday(birth.substring(0, birth.length() - 1));
//        memService.save(m);
//        map.put("msg", "ok");
//        return map;
//    }
//
//    /**
//     * Description:<p style="color:red"> 获得兑换商品的列表</p>
//     *
//     * @param g 商品的实体信息
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/getgoodlist.do")
//    @ResponseBody
//    public Map<String, Object> getgoods(Goods g, PageInfo p, HttpSession session) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//        List<Goods> glist = goodService.find(g, p.getPage(), p.getSize());
//        g.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        map.put("total", goodService.getTotal(g));
//        map.put("rows", glist);
//        return map;
//    }
//
//    /**
//     * Description:<p style="color:red"> 会员充值 </p>
//     *
//     * @param rec   充值实体信息封装
//     * @param memid 会员id
//     * @return
//     */
//    @RequestMapping("/recharge.do")
//    @ResponseBody
//    public Map<String, Object> recharge(Recharge rec, int memid, HttpSession session) {
//        double money = rec.getRecmoney();
//        Map<String, Object> map = new HashMap<String, Object>();
//        Members m = memService.get(Members.class, memid);
//        m.setTotalmoney(m.getTotalmoney() + money);
//        m.setLeftmoney(m.getLeftmoney() + money);
//        rec.setRecnum(DateUtil.getTimes());
//        rec.setRectime(DateUtil.getTime());
//        rec.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        rec.setMemnum(m.getMemnum());
//        rec.setBookkeeper(session.getAttribute("username").toString());
//        memService.save(m);
//        recService.save(rec);
//        map.put("msg", "ok");
//        return map;
//    }
//
//    /**
//     * Description:<p style="color:red">会员积分兑换,商品库存减一 </p>
//     *
//     * @return
//     */
//    @RequestMapping("/duihuan.do")
//    @ResponseBody
//    public Map<String, Object> duihuan(int memid, double need, int goodid) {
//        Map<String, Object> map = new HashMap<String, Object>();
//        Goods g = goodService.get(Goods.class, goodid);
//        if (g.getAmount() - 1 < 0) {
//            map.put("msg", "no");
//        } else {
//            g.setAmount(g.getAmount() - 1);
//            Members m = memService.get(Members.class, memid);
//            m.setLeftpoints(m.getLeftpoints() - need);
//            m.setUsedpoints(m.getUsedpoints() + need);
//            memService.save(m);
//            map.put("msg", "ok");
//        }
//        goodService.save(g);
//        return map;
//    }
//
//
//    /**
//     * <p>Description: 获得会员类型信息</p>
//     *
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/gettype.do")
//    @ResponseBody
//    public Map<String, Object> getrtype(MemType m, PageInfo p, HttpSession session) throws Exception {
//        System.out.println("mem/gettype.do");
//        Map<String, Object> map = new HashMap<String, Object>();
//        m.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        if (null == p.getPage()) p.setPage(1);
//        if (null == p.getSize()) p.setSize(10);
//        map.put("total", memTypeService.find(m).size());
//        map.put("rows", memTypeService.findcri(m, p.getPage(), p.getSize()));
//        return map;
//    }
//
//    /**
//     * <p>Description:删除会员类型 </p>
//     *
//     * @param roomid 房间ID
//     * @return 提示信息
//     */
//    @RequestMapping("/delete_memtype.do")
//    @ResponseBody
//    public Map<String, String> delete_roomtype(int id) {
//        Map<String, String> map = new HashMap<String, String>();
//        MemType mt = new MemType();
//        mt.setId(id);
//        memTypeService.delete(mt);
//        map.put("status", "提示");
//        map.put("msg", "删除成功");
//        return map;
//
//    }
//
//    /**
//     * <p>Description:会员类型更新</p>
//     *
//     * @return
//     */
//    @RequestMapping("/saveupdate_memtype.do")
//    @ResponseBody
//    public Map<String, String> updateType(MemType m, HttpSession session) {
//        Map<String, String> map = new HashMap<String, String>();
//        m.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        memTypeService.saveOrupdate(m);
//        map.put("status", "提示");
//        map.put("msg", "修改成功");
//        return map;
//    }
//
//    /**
//     * <p>Description: 获得会员充值信息列表</p>
//     *
//     * @return
//     * @throws Exception
//     */
//    @RequestMapping("/getrclist.do")
//    @ResponseBody
//    public Map<String, Object> getrclist(Recharge rc, Integer pay, PageInfo p, HttpSession session) throws Exception {
//        Map<String, Object> map = new HashMap<String, Object>();
//        System.out.println("pay = " + pay);
//        if (pay != null && pay != 0) {
//            Paymethod py = new Paymethod();
//            py.setId(pay);
//            rc.setPaymethod(py);
//        }
//        rc.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//        if (null == p.getPage()) p.setPage(1);
//        if (null == p.getSize()) p.setSize(10);
//        map.put("total", recService.find(rc).size());
//        map.put("rows", recService.findcri(rc, p.getPage(), p.getSize()));
//        return map;
//    }
//
//}
//
