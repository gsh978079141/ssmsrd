package com.gsh.ssmsrd.controller;


import com.gsh.ssmsrd.model.Resource;
import com.gsh.ssmsrd.model.Role;
import com.gsh.ssmsrd.model.RoleResource;
import com.gsh.ssmsrd.service.*;
import com.gsh.ssmsrd.util.TreeDTO;
import org.apache.shiro.SecurityUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.context.annotation.Lazy;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 *
 *<p>Title:ResourceControl</p>
 *<p>Description:菜单操作控制层</p>
 *<p>Company:GSH</p>
 * @author gdd
 * @date:2017-3-22 下午8:06:41
 */
@Controller
@RequestMapping("resource")
public class ResourceControl {

	protected static final Logger logger = LoggerFactory.getLogger(ResourceControl.class);
	@javax.annotation.Resource
    @Lazy
	private ResourceService resourceService;
	@javax.annotation.Resource
	private UserService userService;
	@javax.annotation.Resource
	private RoleService roleService;
	@javax.annotation.Resource
	private RoleResourceService roleResService;
	@javax.annotation.Resource
	private UserRoleService userRoleService;


	/**
	 * 根据每个人的权限生成动态菜单
	 * @param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getMenu.do")
	@ResponseBody
	public List<TreeDTO> getMenu() throws Exception{
		logger.debug("/getMenu.do");
        Integer userId=Integer.parseInt(SecurityUtils.getSubject().getSession().getAttribute("userId").toString());
        List<TreeDTO> treeList=getMenu(resourceService.findByUserId(userId),null);
		logger.debug(String.valueOf(treeList.size()));
//		List<TreeDTO> treeList=getMenu(getResByUid(userId),session),null);
		return treeList;
	}


	/**
	 * 用户授权
	 * @return 树形菜单list
	 * @throws Exception
	 */
	@RequestMapping("/ushouquan.do")
	@ResponseBody
	public List<TreeDTO> ushouquan(HttpSession session, String act, int roleid) throws Exception{
		//int uid =Integer.parseInt(session.getAttribute("uid").toString());
		//声明树菜单格式list
		List<TreeDTO> treelist=new ArrayList<TreeDTO>();
		//获得所有系统权限
//		List<Resource> reslist=resourceService.find("from Resource ");
		//根据role的权限
        Role role=new Role();
        role.setRoleid(roleid);
        List<Role> roleList= new ArrayList<>();
        roleList.add(role);
		List<Resource> ureslist=resourceService.findByRoles(roleList);
		//得到所拥有的权限id的数组
		int []ids=new int[ureslist.size()];
		if("".equals(act)){
			for(int i=0;i<ureslist.size();i++){
				ids[i]=((Resource)ureslist.get(i)).getId();
			}
		}
//			treelist=getMenu(reslist,ids);

		return treelist;
	}
	/**
	 * 保存权限
	 * @param arry 前台权限id数组
	 * @param roleid 角色ID
	 * @return json提示信息
	 * @throws Exception
	 */
	@RequestMapping("/saveupdate.do")
	@ResponseBody
	public Map<String, Object> saveupdate(int roleid,int []arry,HttpSession session) throws Exception{
		Map<String, Object> map=new HashMap<String, Object>();
		//声明roleresource实体
        RoleResource roleres=new RoleResource();
        //获得session中酒店ID
        int hid=Integer.parseInt(session.getAttribute("hotelId").toString());
        //赋值
        roleres.setHid(hid);
		roleres.setRoleid(roleid);
		//将权限id数组转化为String字符串
        String s = Arrays.toString(arry);
        String arrystr=s.substring(1, s.length()-1);
        //roleres实体权限更新
        roleres.setResids(arrystr);
        roleResService.insertOrUpdate(roleres);
		map.put("msg", "yes");
		return map;
	}

	/**
	 * 根据用户id查询所有权限
	 * @param uid 用户id
	 * @return 拥有的权限list
	 */
//	public List<Resource> getResByUid(int uid,HttpSession session){
//		//获得角色id
//		int roleid=Integer.parseInt(session.getAttribute("roleid").toString());
//		return getResByRoleid(roleid);
//	}
	/**
	 * 根据角色roleid查询所有权限
	 * @param roleid
	 * @return
	 */
//	public List<Resource> getResByRoleid(int roleid){
//		List<Resource>	reslist=new ArrayList<Resource>();
//		//获得角色
//		Role role=roleService.selectById(roleid);
//		//声明角色权限set
//		Set<RoleResource> resset=role.getRoleResources();
//		//遍历角色权限set
//		for (Iterator iterator = resset.iterator(); iterator.hasNext();) {
//			//声明单个角色权限实体
//			RoleResource resource = (RoleResource)iterator.next();
//			//讲角色权限里的权限添加进权限list
//			reslist.add(resource.getResource());
//		}
//		return reslist;
//	}


	/**
	 * 菜单实体赋值给treeDTO
	 * @param resource 菜单实体类
	 * @param resids 是否为授权操作，是则不为null，否则为null
	 * @return
	 */
	public TreeDTO setTree(Resource resource,int []resids){
		Map<String, Object> attrs=new HashMap<String, Object>();
		TreeDTO treeDTO=new TreeDTO();
		//树菜单id
		treeDTO.setId(resource.getId());
		treeDTO.setParentId(1);
		//树菜单文字
		treeDTO.setText(resource.getName());
		//状态（是否为父节点）
		if(resource.getParentId()==1) {
            treeDTO.setState("closed");
        }

		//url设置
		if(!("").equals(resource.getUrl())&&null!=resource.getUrl()){
			Object o=resource.getUrl();
			attrs.put("url", o);
			treeDTO.setAttributes(attrs);
		}
		//图标设置
		if(!"".equals(resource.getIcon())&&null!=resource.getIcon()){
			treeDTO.setIconCls(resource.getIcon());
			}
		//checkbox是否选中
		if(null!=resids&&!"".equals(resids)){
			treeDTO.setState("open");
			for(int resid:resids){
				if(resid==resource.getId()){
					if(resource.getParentId()!=1){
						treeDTO.setChecked(1);
					}
					else {
                        continue;
                    }
				}
			}
		}
		return treeDTO;
	}

	/**
	 * 拼接菜单
	 * @param resources 数据库查询的菜单集合 list
	 * @return 拼接好的前台树形菜单集合 treelist
	 * @throws Exception
	 */
	public List<TreeDTO> getMenu(List<Resource> resources,int []resids) throws Exception{
		List<TreeDTO> treelist=new ArrayList<TreeDTO>();
		//循环resources集合
		for(int i=0;i<resources.size();i++){
			//声明TreeDTO类型变量treeDTO
			TreeDTO treeDTO=new TreeDTO();
			//获得当期循环的菜单实体resource
			Resource resource=resources.get(i);
			//判断是否为一级菜单
			if(resource.getParentId()==1){
				//是，则直接将相应的值赋值给treeDTO
				treeDTO=setTree(resource,resids);
				//查询获得子菜单集合
				List<Resource>	creslist=resourceService.getChildren(resource.getId());
				//声明树形菜单子菜单集合
				List<TreeDTO> kidreslist=new ArrayList<TreeDTO>();
				//声明树形菜单（子菜单）
				TreeDTO children=new TreeDTO();
				//循环查询数据库的子菜单集合
				for(Resource creres:creslist){
					//如果全部菜单中包含子菜单
//					if(resources.contains(creres)){
						//子菜单添加进父菜单
						children=setTree(creres,resids);
						kidreslist.add(children);
						treeDTO.setChildren(kidreslist);
//					}
				}
			}
			else{
				continue;
			}

			treelist.add(treeDTO);
		}

		return treelist;
	}


	/**
	 *
	 *<p>Description:获得职务列表 </p>
	 * @param r 前台查询条件
	 * @return json 提示信息
	 * @throws Exception
	 */
	@RequestMapping("/getRoles.do")
	@ResponseBody
	public Map<String , Object> getRoles(Role r,HttpSession session) throws Exception{
		Map<String , Object> map=new HashMap<String , Object>();
		List<Role> rolelist=new ArrayList<Role>();
		if("".equals(r.getRolename())) {
            r.setRolename(null);
        }
		if("".equals(r.getRolecode())) {
            r.setRolecode(null);
        }
		r.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));
//		rolelist=roleService.findcri(r,1,10);
		map.put("total", rolelist.size());
		map.put("rows", rolelist);
		return  map;
	}


	/**
	 *
	 *<p>Description: 职务修改 </p>
	 * @param r 角色实例对象
	 * @return
	 */
	@RequestMapping("/updateRole.do")
	@ResponseBody
	public Map<String, String> updateRole(Role r,HttpSession session){
		Map<String, String> map=new HashMap<String, String>();
		r.setHid(Integer.parseInt(session.getAttribute("hotelId").toString()));

		if(null==r.getRoleid()) {
            ;
        }
//			roleService.save(r);
		else
//			roleService.update(r);
        {
            map.put("status", "成功");
        }
		map.put("msg", "修改成功");
		return  map;
	}

	/**
	 *
	 *<p>Description:删除职务</p>
	 * @param
	 * @param session
	 * @return
	 */
	@RequestMapping("/deleteRole.do")
	@ResponseBody
	public Map<String, String> deleteRole(int roleid,HttpSession session){
		Map<String, String> map=new HashMap<String, String>();
		Role r=roleService.selectById(roleid);
//		roleService.delete(r);
		map.put("status", "成功");
		map.put("msg", "修改成功");
		return  map;
	}
	/************WIN10 UI   TEST***********/
	@RequestMapping("/getDesk.do")
	@ResponseBody
	public List<Resource> getDesk(HttpSession session){
		Integer uid=Integer.parseInt(session.getAttribute("userId").toString());
		resourceService.findByUserId(uid);
		Map map=new HashMap();
		map.put("parent_id",1);
		return resourceService.selectByMap(map);
	}

}
