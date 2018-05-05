package com.gsh.ssmsrd.controller;
import com.gsh.ssmsrd.model.User;
import com.gsh.ssmsrd.service.RoleService;
import com.gsh.ssmsrd.service.UserRoleService;
import com.gsh.ssmsrd.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.authz.annotation.RequiresRoles;
import org.apache.shiro.subject.Subject;
import org.crazycake.shiro.RedisSessionDAO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

/**
*<p>Title:LoginControl </p>
*<p style="color:red;">Description: 登录控制类 </p>
*<p>Company: jxxkhotel </p>
*@author gdd
*@date 2016-12-30 下午4:23:14
*/
@Controller
public class LoginControl {
	@Resource
	private UserService userService;
	@Resource
	private RoleService roleService;
//	@Resource
//	private HotelUserMapper hotelUserMapper;
	@Resource
	private UserRoleService userRoleService;
	@Resource
	private RedisSessionDAO redisSessionDAO;



	/**
	 *
	*Description:<p style="color:red"> 登录验证</p>
	 *@return
	 * @throws Exception
	 */
	@RequestMapping("/login.do")
	@ResponseBody
	public Map login(User u) throws Exception{
	    Map map=new HashMap();
		Subject subject = SecurityUtils.getSubject();
		UsernamePasswordToken token = new UsernamePasswordToken(u.getUsername(), u.getPassword());
		try {
			subject.login(token);
		} catch (UnknownAccountException e) {
			e.printStackTrace();
			token.clear();
			map.put("tip","用户名不存在");
            return map;
        } catch (IncorrectCredentialsException e) {
			e.printStackTrace();
			token.clear();
			map.put("tip","密码错误");
			return map;
		}
        map.put("tip","正在登陆");
        map.put("token",subject.getSession().getId());
        map.put("href","jump/win10/index.do");
		return map;
//		EntityWrapper<User> wrapper=new EntityWrapper<>();
//		wrapper.setEntity(u);
//		User user=userService.selectOne(wrapper);
		//当前Subject
//		Subject currentUser = SecurityUtils.getSubject();
//		//加密（md5+盐），返回一个32位的字符串小写
//		String salt="("+u.getUsername()+")";
//		String md5Pwd=new Md5Hash(u.getPassword(),salt).toString();
//		//传递token给shiro的realm
//		UsernamePasswordToken token = new UsernamePasswordToken(u.getUsername(),md5Pwd);
//		try {
//			currentUser.login(token);
//			return "index";
//		} catch (AuthenticationException e) {//登录失败
//			System.out.println("登录失败");
//		}
//		System.out.println("LoginControl  /login.do  controller");
//		return "fail";
//
//		if(ulist.size()!=0){
//			User user=ulist.get(0);
			//查询特定列
			//Role role=userRoleService.find(" from UserRole as ur where ur.user = ? ", new Object[]{user}).get(0).getRole();
//临时注释			Role role=user.getUserRole().getRole();
			/*set iterator 循环
			 * Iterator<RoleResource> iterator=resset.iterator();
			while(iterator.hasNext()){
						resources.add((com.gsh.model.Resource) iterator.next().getResource());
						}
				for(com.gsh.model.Resource res :resources){
				System.out.println("res"+res.getName());
				}*/
//			Hotel hotel=user.getHotelUser().getHotel();
//			session.setAttribute("User", user);
//			session.setAttribute("uid", user.getId());
//			session.setAttribute("username", user.getUsername());
//			session.setAttribute("userpass", user.getPassword());
//			session.setAttribute("roleid", role.getRoleid());
//			session.setAttribute("role", role);
//			session.setAttribute("hotelId", hotel.getHid());
//			session.setAttribute("hotelname", hotel.getHname());
//			session.setAttribute("hotelnum", hotel.getHnum());
//			if(role.getRolename().equals("注册用户"))
//				map.put("msg", "jump/manager/main.do");
//			else if(role.getRolename().equals("酒店前台"))
//				map.put("msg", "jump/reception/main.do");
//            System.out.println(user.getUsername());
//        }
//		else
//			 map.put("msg", "error") ;
	}
	/**
	 *
	 *<p>Description: 安全退出</p>
	 * @return
	 */
	@RequestMapping("/loginout.do")
	public String loginout(HttpSession session){
		session.invalidate();
		return "index";
	}

	/**
	　* @Description:
	　* @param
	　* @return
	　* @throws
	　* @author gsh
	　* @date 2018/4/17 下午3:40
	　*/
	@RequestMapping("/loginin.do")
	public String loginin(){
		return "login";
	}

	@RequestMapping("/test.do")
	@RequiresRoles({"admin"})
	public String test(){
		SimpleAuthorizationInfo info =  new SimpleAuthorizationInfo();
		System.out.println(info.getStringPermissions());
		return "test";
	}


	@RequestMapping("/index.do")
	public String index(){
		//session.setAttribute("123","123");
		return "index";
	}

}
