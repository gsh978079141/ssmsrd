package com.gsh.ssmsrd.controller;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.gsh.ssmsrd.config.MyBatisRedisCache;
import com.gsh.ssmsrd.model.*;
import com.gsh.ssmsrd.service.HotelUserService;
import com.gsh.ssmsrd.service.RoleService;
import com.gsh.ssmsrd.service.UserRoleService;
import com.gsh.ssmsrd.service.UserService;
import com.gsh.ssmsrd.util.DateUtil;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
*<p>Title:UserControl </p>
*<p>Description: 员工管理模块</p>
*<p>Company: </p>
*@author gdd
*@date 2017-12-30 下午3:25:09
*/
@Controller
@RequestMapping("user")
public class UserControl {
	@Resource
	private UserRoleService userRoleService;
	@Resource
    @Lazy
	private UserService userService;
	@Resource
	private RoleService roleService;
	@Resource
	private HotelUserService hotelUserService;

	private static Logger logger = LoggerFactory.getLogger(UserControl.class);
	/**
	 * 获取城市数据
	 *
	 * @param
	 * @param
	 * @return
	 */
//	public List<City> getCity() {
//		System.out.println("getCity");
//			List<City> clist = new ArrayList<City>();
//			clist.add(new City(1, "北京", 0));
//			clist.add(new City(2, "上海", 0));
//			clist.add(new City(3, "深圳", 0));
//			clist.add(new City(4, "长春", 0));
//		return clist;
//	}

	/**
	 * 用户保存
	 * @param u
	 * @return
	 */
	@RequiresPermissions({"user:manage"})
	@RequestMapping("/save.do")
	public Map<String,String> save(User u,int roleid,HttpSession session) {
		Map<String, String> map=new HashMap<>();
//		u.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
		map.put("status", "ok");
		map.put("message", "success");
		return map;
	}
	/**
	 * 用户注册
	 * @param u 用户基本信息
	 * @return
	 */
	@RequestMapping("/reg.do")
	@ResponseBody
	public Map<String, String> reg(User u){
		Map<String, String> map=new HashMap<String, String>();
		//默认用户酒店ID=0，代表未创建酒店
		//设置开始时间
		u.setStarttime(DateUtil.getDay());
		//设置有效时间
		u.setEndtime(DateUtil.getAfterDayDate("7"));
		//设置酒店ID(默认为4)
		u.setHid(4);
		//保存用户
//		u.setUsername();
		userService.insert(u);
		//用户角色操作
		UserRole userRole=new UserRole();
		//设置用户ID
		userRole.setUserid(u.getId());
		//设置角色ID(2为默认注册用户)
		userRole.setRoleid(2);
		//保存用户与权限对应关系
		userRoleService.insert(userRole);
		map.put("status", "ok");
		map.put("message", "success");
		return map;
	}

	/**
	 * 得到用户信息列表
	 * @param page
	 * @param u
	 * @return
	 * @throws Exception
	 */
	@RequiresPermissions({"user:view"})
	@RequestMapping("/getlist.do")
	@ResponseBody
	public Map<String , Object> getList(PageInfo page ,User u,HttpSession session) throws Exception {
		Map<String, Object> map= new HashMap<String, Object>();
			u.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
			Page<User> pageUser =new Page<>(page.getPage(), page.getSize());
            EntityWrapper<User> eWrapper = new EntityWrapper<User>(u);
            Page<User> userList = userService.selectPage(pageUser, eWrapper);
			map.put("code", 0);
            map.put("total", userList.getTotal());
			map.put("rows", userList.getRecords());
			return map;
	}

	/**
	 * 修改用户
	 * @param u
	 * @return
	 */
	@RequiresPermissions({"user:update"})
	@RequestMapping("/update.do")
	@ResponseBody
	public String update(User u,Integer roleid,HttpSession session) {
		return  "{\"status\":\"提示\" , \"message\":\"success!\"}";
	}

	/**
	 * 删除用户
	 * @param ids：用户id数组
	 * @return
	 */
	@RequiresPermissions({"user:del"})
	@RequestMapping("/delete.do")
	@ResponseBody
	public String delete(String[] ids) {
		System.out.println("user delete.do ....");
			for (int i = 0; i < ids.length; i++) {
//				User u=new User(Integer.parseInt(ids[i]));
//				userService.delete(u);
			}
		return null;
	}

	/**
	 * 验证用户名是否存在
	 * @param username
	 * @return
	 */
	@RequestMapping("/checkname.do")
	@ResponseBody
	public Map<String, String> checkname(String username){
		Map<String, String> map=new HashMap<String, String>();
		User user=new User();
		EntityWrapper ew =new EntityWrapper();
		user.setUsername(username);
		ew.setEntity(user);
		int count=userService.selectCount(ew);
		if(count==0) {
			map.put("msg", "ok");
		}
		else {
			map.put("msg", "no");
		}
		return map;
	}

	/**
	 *
	 *<p>Description: 获得所有角色</p>
	 * @param session
	 * @return
	 */
	@RequestMapping("/getRole.do")
	@ResponseBody
	public List<Map<String,Object>> getrole(HttpSession session){
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Integer hid=Integer.parseInt(session.getAttribute("hotelId").toString());
		Map map1=new HashMap();
		map1.put("hotelId",hid);
		System.out.println(roleService.findRoleByUserId(2));
		List<Role> rlist=roleService.selectByMap(map1);
		for (int i = 0; i < rlist.size(); i++) {
			Map<String, Object> map=new HashMap<String, Object>();
				Role role =rlist.get(i);
				map.put("roleid", role.getRoleid());
				map.put("rolename", role.getRolename());
				list.add(map);
				System.out.println(list.get(i));
			}
		return list;
		}

}
