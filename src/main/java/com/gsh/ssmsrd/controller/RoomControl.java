//package com.gsh.ssmsrd.controller;
//
//import com.gsh.model.*;
//import com.gsh.service.*;
//import com.gsh.util.DateUtil;
//import com.gsh.util.IDCardCheck;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.ResponseBody;
//
//import javax.annotation.Resource;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpSession;
//import java.net.URLDecoder;
//import java.util.ArrayList;
//import java.util.HashMap;
//import java.util.List;
//import java.util.Map;
//
//@Controller
//@RequestMapping("room")
///**
// *
//*<p>Title:RoomControl </p>
//*<p style="color:red;">Description: </p>
//*<p>Company: jxxkhotel </p>
//*@author gdd
//*@date 2017-1-2 下午8:09:36
// */
//public class RoomControl {
//
//	@Resource
//	private RoomService roomService;
//	@Resource
//	private GuestService guestService;
//	@Resource
//	private RoomCService roomCService;
//	@Resource
//	private ConService conService;
//	@Resource
//	private RTService rtService;
//	@Resource
//	private RgoodService rgoodService;
//	@Resource
//	private BalService balService;
//	@Resource
//	private HotelService hotelService;
//	/**
//	 *
//	<p style="color:green;">Description :房间信息获取，包括动态多条件查询</p>
//	 * Map<String,Object>
//	 * @param
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping("/getlist.do")
//	@ResponseBody
//	public Map<String, Object> getlist(Room r, HttpSession session, PageInfo p) throws Exception{
//		if(null==p.getPage())
//			p.setPage(1);
//		if(null==p.getSize())
//			p.setSize(100);
//		//判断是否为求房型
//		if(r.getRoomType()==null){
//			RoomType rt=new RoomType();
//			rt.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//			r.setRoomType(rt);
//			}
//		//设默认值
//		if(null==r.getRoomType().getId())
//			r.setRoomType(null);
//		if(("").equals(r.getRoomnum()))
//			r.setRoomnum(null);
//		if(("").equals(r.getRoompwd()))
//			r.setRoompwd(null);
//		Map<String, Object> map=new HashMap<String, Object>();
//		map.put("total", roomService.getTotal(r));
//		map.put("rows", roomService.findcri(r, p.getPage(), p.getSize()));
//		return map;
//	}
//
//	/*
//	Map<String, Object> map=new HashMap<String, Object>();
//	int floor = r.getFloor() == null?0:r.getFloor();
//	int state = r.getRoomstate()== null?0: r.getRoomstate();
//	int rtype=0;
//	if(r.getRoomType()!=null)
//		rtype=r.getRoomType().getId()==null?0:r.getRoomType().getId();
//	Map<String, Integer> m = new HashMap<String, Integer>();
//	m.put("floor", floor);
//	m.put("roomstate", state);
//	m.put("roomType.id", rtype);
//	m.put("hotelId", Integer.parseInt(session.getAttribute("hotelId").toString()));
//	map.put("rows",roomService.searchbymap(m,p));
//	return map;
//	*/
//	/**
//	 *
//	<p style="color:green;">Description :新增房间信息</p>
//	 * Map<String,String>
//	 * @param r 房间信息实体类
//	 * @param typeid 房型id
//	 * @param session
//	 * @return
//	 */
//	@RequestMapping("/save.do")
//	@ResponseBody
//	public Map<String,String> save(Room r,int typeid,HttpSession session) {
//		r.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		Map<String, String> map=new HashMap<String, String>();
//		RoomType rt=new RoomType();
//		rt.setId(typeid);
//		r.setRoomType(rt);
//		roomService.save(r);
//		map.put("status", "ok");
//		map.put("message", "操作成功");
//		return map;
//	}
//
//	/**
//	 *
//	<p style="color:green;">Description :身份证合法性校验</p>
//	 * Map<String,String>
//	 * @param id 身份证号
//	 * @return String类型
//	 */
//	@RequestMapping("/checkid.do")
//	@ResponseBody
//	public String checkid(String id){
//		return 	IDCardCheck.checkid(id);
//	}
//
//	/**
//	 *
//	<p style="color:green;">Description :根据ID获得房间信息</p>
//	 * Map<String,String>
//	 * @param id 房间ID
//	 * @return String类型
//	 */
//	@RequestMapping("/getroom.do")
//	@ResponseBody
//	public Map<String, Object> getroom(int id){
//		Map<String, Object> map=new HashMap<String, Object>();
//		Room room=roomService.get(Room.class, id);
//		map.put("room", room);
//		map.put("resinfo", "no");
//		return map;
//	}
//	/**
//	 *
//	*Description:<p style="color:red">房态变更 </p>
//	*@param roomid 房间ID
//	*@param state 房间状态
//	*@param remark 备注信息
//	*@return “”
//	 * @throws Exception
//	 */
//	@RequestMapping("/changestate.do")
//	@ResponseBody
//	public String update_roomstate(int roomid, int state, String remark, HttpSession session, PageInfo p) throws Exception{
//		Map<String, Object> map=new HashMap<String, Object>();
//		Room r=roomService.get(Room.class, roomid);
//		if(remark!=null)
//			r.setRemark(remark);
//		r.setRoomstate(state);
//		getlist(r,session,p);
//		return "";
//	}
//	/**
//	 *
//	*Description:<p style="color:red"> 办理入住处理 </p>
//	*@param roomid 房间ID
//	*@param g 宾客信息实体
//	*@param paymethod 支付方式
//	*@param deposit 押金
//	*@param roomprice 房价
//	*@param con 消费信息
//	*@return “”
//	 */
//	@RequestMapping("/checkin.do")
//	@ResponseBody
//	public String checkin(int roomid,Guest g,int paymethod,Double deposit,double roomprice,Consumption con,int hourday,HttpSession session){
//		Room r=roomService.get(Room.class, roomid);
//		con.setOrdernum(DateUtil.getTimes());
//		con.setStarttime(DateUtil.getTime());
//		con.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		conService.save(con);
//		Consumption con1=conService.find(con).get(0);
//		//房态修改
//		r.setRoomstate(5);
//		//是否为钟点房*******重点 ！后面计算房价需要！
//		r.sethourday(hourday);
//		//房间消费清单添加
//			//房费
//		ffrz(roomprice,con1,"");
//			//押金
//		Paymethod p2=new Paymethod();
//		p2.setId(paymethod);
//		RoomConList rc2=new RoomConList();
//		rc2.setItemname("入住押金");
//		rc2.setItemprice(0.0);
//		rc2.setPayprice(deposit);
//		rc2.setPaymethod(p2);
//		rc2.setAmount(1);
//		rc2.setBookitime(DateUtil.getTime());
//		rc2.setBookkeeper("系统");
//		rc2.setTotalprice(0.0);
//		rc2.setConsumption(con1);
//		roomCService.save(rc2);
//		g.setRoomid(r.getId());
//		//保存房间信息
//		roomService.save(r);
//		//保存宾客信息
//		guestService.save(g);
//		//保存账单
//		return "";
//	}
//	/**
//	 *
//	<p style="color:green;">Description :结账退房</p>
//	 * Map<String,String>
//	 * @param id 房间id  m 模型
//	 * @return 跳转到结账页面
//	 */
//	@RequestMapping("/checkout.do")
//	public String checkout(int id,Model m){
//		Map<String, Object> map=new HashMap<String, Object>();
//		Room r=roomService.get(Room.class, id);
//		//房间号
//		String roomnum=r.getRoomnum();
//		//根据房间号得到入住账单号
//		Consumption c1=new Consumption();
//		c1.setRoomnum(roomnum);
//		c1.setChecked(0);
//		Consumption con=conService.find(c1).get(0);
//		map.put("con",con);
//		double totalmoney = 0,paymoney=0,needmoney=0;
//		for(int i=0;i<con.getRoomConLists().size();i++){
//			RoomConList rcon= con.getRoomConLists().get(i);
//			 totalmoney+=rcon.getTotalprice();
//			 paymoney+=rcon.getPayprice();
//		}
//		needmoney=totalmoney-paymoney;
//		map.put("totalmoney", totalmoney);
//		map.put("paymoney", paymoney);
//		map.put("needmoney", needmoney);
//		//m.addAllAttributes(map);
//		m.addAllAttributes(map);
//		return "reception/checkout";
//	}
//
//	/**
//	 *
//	*Description:<p style="color:red"> 结账退房，改入住单为已经计算</p>
//	*@param bal 收支详情单
//	*@param conid 入住单 ID
//	*@param request
//	*@return
//	 */
//	@RequestMapping("/checkoutend.do")
//	@ResponseBody
//	public Map checkoutend(Balance bal,int conid,String roomnum,HttpSession session){
//		Map<String, Object> map=new HashMap<String, Object>();
//		Room r=roomService.find("from Room as r where r.roomnum ="+"'"+roomnum+"'").get(0);
//		r.setRoomstate(1);
//		roomService.save(r);
//		Consumption con=conService.get(Consumption.class, conid);
//		con.setChecked(1);
//		bal.setBilltime(DateUtil.getTime());
//		bal.setMother(bal.getTotalmoney()-bal.getMcash());
//		bal.setBookkeeper(session.getAttribute("username").toString());
//		bal.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		conService.save(con);
//		balService.save(bal);
//		return map;
//	}
//
//	/**
//	 *
//	*Description:<p style="color:red"> 计算到退房时的房价 </p>
//	*@param roomid
//	*@return
//	 */
//	@RequestMapping("/checkroomprice.do")
//	@ResponseBody
//	public String checkroomprice(int roomid){
//		//收费说明
//		String remark ="";
//		//获得系统时间
//		String endtime=DateUtil.getTime();
//		//房费最后一次入账时间
//		String lastrztime="";
//		//要增加的房费
//		double addroomprice=0;
//		//房价
//		double roomprice=0;
//		//得到房间信息
//		Room r= roomService.get(Room.class, roomid);
//		int hourorday =r.gethourday();//1表示钟点房0表示天房
//		//房号
//		String roomnum=r.getRoomnum();
//		//得到入住账单
//		Consumption c1=new Consumption();
//		c1.setRoomnum(roomnum);
//		c1.setChecked(0);
//		Consumption c=conService.find(c1).get(0);
//		//所有房间消费信息的list，为求最后一次添加房费的时间
//		List<RoomConList> rclist =new ArrayList<RoomConList>();
//
//		//遍历房间消费列表,得到房费项目的list
//		for(RoomConList rc: c.getRoomConLists()){
//				if(rc.getItemname().equals("房费")){
//					rclist.add(rc);
//				}
//		}
//		//得到最后一次添加房费的时间
//		lastrztime=rclist.get(rclist.size()-1).getBookitime();
//		roomprice=rclist.get(rclist.size()-1).getItemprice();
//		//最后一次入账时间与当前时间差几个小时
//		long differhours=DateUtil.getTimeSub(lastrztime, DateUtil.getTime());
//		/****钟点房记价规则****/
//		if(hourorday==1&&differhours>1){
//			addroomprice=roomprice*(differhours-1);
//		}
//		/*** 天房记价规则***/
//		//根据最后一次入账时间与系统时间差去掉入住时记录的房费信息
//
//		else{
//			long hours=differhours-24;
//			if(hours-24>0){
//			//3<hours<12，追加半天房费
//				if(hours>=3&&hours<12){
//					addroomprice=roomprice/2;
//					remark="超过三小时，未超过12小时，补半天房价"+addroomprice;
//				}
//			//12<hours<24,追加一天
//				else if(hours>=12&&hours<24){
//					addroomprice=roomprice;
//					remark="超过12小时，补一天房价"+addroomprice;
//				}
//				//如果大于24小时(1天)
//				else {
//					//如果是整的天数，就增加天数*房费
//						if(hours%24==0){
//							addroomprice=roomprice*hours/24;
//							remark="补房价"+addroomprice;
//						}
//						//如果不是整天数，求余
//						else {
//								//余数在(6,12)间整天数再加半天房
//								if(hours%24<12&&hours%24>=3){
//									addroomprice=roomprice*(hours/24+0.5);
//									remark="整天，超(3,12)补房价"+addroomprice;
//								}
//								//余数大于12按一天算
//								else addroomprice=roomprice*(hours/24+1);
//								remark="整天，超(12,24)补房价"+addroomprice;
//							}
//				}
//			}
//		}
//		if(addroomprice!=0){
//
//			//保存消费信息
//			ffrz(addroomprice, c,remark);
//		}
//		return "";
//	}
//
//	/**
//	 *
//	*Description:<p style="color:red">封装房费入账 </p>
//	*@param roomprice
//	*@param con
//	 */
//	public  void  ffrz(double roomprice,Consumption con,String remark){
//		//房费
//			RoomConList rc1=new RoomConList();
//			Paymethod p1=new Paymethod();
//			p1.setId(2);
//			rc1.setRemark(remark);
//			rc1.setItemname("房费");
//			rc1.setItemprice(roomprice);
//			rc1.setAmount(1);
//			rc1.setBookitime(DateUtil.getTime());
//			rc1.setBookkeeper("系统");
//			rc1.setPaymethod(p1);
//			rc1.setTotalprice(roomprice);
//			rc1.setPayprice(0.0);
//			rc1.setConsumption(con);
//			roomCService.save(rc1);
//	}
//	/**
//	 *
//	*Description:<p style="color:red">遍历房间类型表获得动态添加房态图的tabs </p>
//	*@return
//	 */
//	@RequestMapping("/getrtype.do")
//	@ResponseBody
//	public Map<String, Object> getrtype(String typeid, Integer hid, RoomType rtype, PageInfo p, HttpSession session, String act){
//	Map<String, Object> map=new HashMap<String, Object>();
//	//判断是否是根据房型求房间
//	//typeid为null则求房型combox
//	if(typeid==null){
//		if(hid==null)
//			hid=Integer.parseInt(session.getAttribute("hotelId").toString());
//		List<RoomType> rtlist=new ArrayList<RoomType>();
//		//判断是否为求房型列表
//		if("".equals(act)||null==act){
//				rtype.setHid(hid);
//			try {
//				if("".equals(rtype.getState()))rtype.setState(null);
//				if("".equals(rtype.getSprice()))rtype.setSprice(null);
//				if("".equals(rtype.getTypecode()))rtype.setTypecode(null);
//				if("".equals(rtype.getTypename()))rtype.setTypename(null);
//				rtlist=rtService.find(rtype,p.getPage(),p.getSize());
//			} catch (Exception e) {
//				e.printStackTrace();
//			}
//			map.put("total", rtService.find(rtype).size());
//			map.put("rows", rtlist);
//		}
//		else {
//			System.out.println("getrtype.do   hid="+hid);
//			rtlist=rtService.find("from RoomType as rt where rt.hid="+hid+"and rt.state = 1 ");
//			map.put("rtlist", rtlist);
//		}
//	}
//	//否则求此房型下所有可以预定的房间号
//	else{
//		RoomType rt=rtService.get(RoomType.class, Integer.parseInt(typeid));
//		List<Room> rooms=new ArrayList<Room>();
//		for(Room r:rt.getRooms()){
//			//判断房态只有为空房或者打扫的房间才可以预定
//			if(r.getRoomstate()==1||r.getRoomstate()==3){
//				rooms.add(r);
//			}
//		}
//		map.put("rooms", rooms);
//	}
//	return map;
//	}
//	/**
//	 *
//	*Description:<p style="color:red">预订入住 </p>
//	*@param id 房间ID
//	*@return
//	 */
//	@RequestMapping("/resin.do")
//	@ResponseBody
//	public Map<String, Object> resin(int id){
//		Map<String,Object> map=new HashMap<String, Object>();
//		Room r=roomService.get(Room.class, id);
//		return map;
//	}
//	/**
//	 *
//	*Description:<p style="color:red"> 通过房间ID 获得房间消费信息</p>
//	*@param roomid
//	*@return
//	 */
//	@RequestMapping("/getconsumpt.do")
//	@ResponseBody
//	public Map<String, Object> getconsumption(int roomid){
//		Map<String,Object> map=new HashMap<String, Object>();
//		Room r=roomService.get(Room.class, roomid);
//		Consumption c1=new Consumption();
//		c1.setRoomnum(r.getRoomnum());
//		c1.setChecked(0);
//		Consumption con=conService.find(c1).get(0);
//		con.setRoomConLists(null);
//		map.put("con",con);
//		return map;
//	}
//	/**
//	 *
//	*Description:<p style="color:red">得到所有房间消费品表 </p>
//	*@param rg 房间商品信息实体
//	*@param p 分页参数
//	*@return
//	*@throws Exception
//	 */
//	@RequestMapping("/goodlist.do")
//	@ResponseBody
//	public Map<String, Object>  addgoon(Rgood rg,PageInfo p) throws Exception{
//		Map<String, Object> map=new HashMap<String, Object>();
//		List<Rgood> rglist=rgoodService.find(rg, p.getPage(), p.getSize());
//		map.put("total", rglist.size());
//		map.put("rows", rglist);
//		return map;
//	}
//	/**
//	 *
//	*Description:<p style="color:red"> 添加商品信息到房间消费账单</p>
//	*@param conid
//	*@param goodid
//	*@param request
//	*@return
//	 */
//	@RequestMapping("/sureadd.do")
//	@ResponseBody
//	public String sureaddgood(int conid,int goodid,HttpServletRequest request){
//		Rgood rg=rgoodService.get(Rgood.class, goodid);
//		rg.setAmount(rg.getAmount()-1);
//		rgoodService.save(rg);
//		Consumption con=conService.get(Consumption.class, conid);
//		Paymethod paymethod=new Paymethod();
//		paymethod.setId(2);
//		Map<String, Object> map=new HashMap<String, Object>();
//		RoomConList rc=new RoomConList();
//		rc.setAmount(1);
//		rc.setBookitime(DateUtil.getTime());
//		rc.setBookkeeper(request.getSession().getAttribute("username").toString());
//		rc.setItemname(rg.getSpname());
//		rc.setItemprice(rg.getSpprice());
//		rc.setPaymethod(paymethod);
//		rc.setTotalprice(rg.getSpprice());
//		rc.setConsumption(con);
//		roomCService.save(rc);
//		return "ok";
//	}
//	/**
//	 * 特价房的设置
//	 * @param roomid 房间id
//	 * @param relprice 实际价格
//	 * @return
//	 */
//	@RequestMapping("/changerelprice.do")
//	@ResponseBody
//	public Map<String, String> changerelprice(int roomid,double relprice){
//		Map<String, String> map=new HashMap<String, String>();
//		Room r=roomService.get(Room.class, roomid);
//		r.setRelprice(relprice);
//		roomService.save(r);
//		map.put("msg", "ok");
//		return map;
//
//	}
//	/**
//	 *
//	 *<p>Description: 房间宾客信息查询</p>
//	 * @param g 查询的宾客信息
//	 * @return
//	 * @throws Exception
//	 */
//	@RequestMapping("/searchinfo.do")
//	@ResponseBody
//	public Map<String, Object> searchinfo(Guest g) throws Exception{
//		if(g.getGuestname()!=null)
//			g.setGuestname(URLDecoder.decode(g.getGuestname(), "UTF-8"));
//		Map<String, Object> map=new HashMap<String, Object>();
//		List<Room> rlist= new ArrayList<Room>();
//		List<Guest> glist=guestService.findcri(g, 1, 10);
//		if(glist.size()!=0){
//			Guest sg=glist.get(0);
//			Room room=roomService.get(Room.class, sg.getRoomid());
//			if(room.getRoomstate()==2||room.getRoomstate()==5)
//				{
//				rlist.add(room);
//				map.put("msg", "ok");
//				map.put("rows",rlist);
//				}
//			else{
//				map.put("msg", "error");
//				map.put("tip","可到历史入住信息查找" );
//				}
//		}
//		else{
//			map.put("msg", "error");
//			map.put("tip","未找到符合搜索信息的宾客" );
//		}
//		return map;
//	}
//
//	/*@RequestMapping("/crisearch.do")
//	@ResponseBody
//	public Map<String, Object> crisearch(Members m,PageInfo p,HttpSession session) throws Exception{
//		if(m.getMemType()==null){
//			MemType mt=new MemType();
//			mt.setId(0);
//			mt.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//			m.setMemType(mt);
//			}
//		if(m.getMemType().getId()==0)
//			m.setMemType(null);
//		if(("").equals(m.getMemnum()))
//			m.setMemnum(null);
//		if(("").equals(m.getMemname()))
//			m.setMemname(null);
//		Map<String, Object> map=new HashMap<String, Object>();
//		map.put("total", memService.getTotal(m));
//		map.put("rows", memService.findcri(m, p.getPage(), p.getSize()));
//		//map.put("memlist", memService.findcriteria(m, 1, 5));
//		return map;
//	}*/
//	/**
//	 *
//	 *<p>Description:保存房间信息</p>
//	 * @param o 前台接收的数据
//	 * @return
//	 */
//	@RequestMapping("/update.do")
//	@ResponseBody
//	public  Map<String, String> update(Room r,int roomtype,HttpSession session){
//		 Map<String, String> map= new HashMap<String, String>();
//		 Room room=roomService.get(Room.class, r.getId());
//		 room.setFloor(r.getFloor());
//		 room.setWindow(r.getWindow());
//		 room.setRelprice(r.getRelprice());
//		 room.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		 room.setRoompwd(r.getRoompwd());
//		 room.setRoomnum(r.getRoomnum());
//		 room.setState(r.getState());
//		 RoomType rt=new RoomType();
//		 rt.setId(roomtype);
//		 room.setRoomType(rt);
//		 roomService.update(room);
//		 map.put("status", "提示");
//		 map.put("msg", "修改成功");
//		 return map;
//
//	}
//	/**
//	 *
//	 *<p>Description:删除房间 </p>
//	 * @param roomid 房间ID
//	 * @return 提示信息
//	 */
//	@RequestMapping("/delete.do")
//	@ResponseBody
//	public  Map<String, String> delete(int roomid){
//		 Map<String, String> map= new HashMap<String, String>();
//		 Room r=roomService.get(Room.class, roomid);
//		 roomService.delete(r);
//		 map.put("status", "提示");
//		 map.put("msg", "删除成功");
//		 return map;
//	}
//	/**
//	 *
//	 *<p>Description:删除房间 </p>
//	 * @param roomid 房间ID
//	 * @return 提示信息
//	 */
//	@RequestMapping("/delete_roomtype.do")
//	@ResponseBody
//	public  Map<String, String> delete_roomtype(int id){
//		Map<String, String> map= new HashMap<String, String>();
//		RoomType rt=new RoomType();
//		rt.setId(id);
//		rtService.delete(rt);
//		map.put("status", "提示");
//		map.put("msg", "删除成功");
//		return map;
//
//	}
//	/**
//	 *
//	 *<p>Description:  房型的管理</p>
//	 * @param rt 房型信息
//	 * @param session
//	 * @return
//	 */
//	@RequestMapping("/update_roomtype.do")
//	@ResponseBody
//	public  Map<String, String> update_roomtype(RoomType rt,HttpSession session){
//		 Map<String, String> map= new HashMap<String, String>();
//		 rt.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		 rtService.saveOrupdate(rt);
//		 map.put("status", "提示");
//		 map.put("msg", "修改成功");
//		 return map;
//	}
//
//	/**
//	 *
//	 *<p>Description: 得到酒店列表</p>
//	 * @return
//	 */
//	@RequestMapping("/gethotel.do")
//	@ResponseBody
//	public Map<String, Object> gethotel(){
//		Map<String, Object> map=new HashMap<String, Object>();
//		map.put("hlist", hotelService.find("from Hotel"));
//		return map;
//	}
//
//}
