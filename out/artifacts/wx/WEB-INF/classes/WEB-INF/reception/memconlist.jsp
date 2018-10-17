<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>main</title>
    
	<link rel="stylesheet" type="text/css" href="css/common.css" />
	<script type="text/javascript" src="js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css" />
	<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="js/easyui/locale/easyui-lang-zh_CN.js"></script>
	
	<script type="text/javascript">
									
		</script>
  </head>
  
  <body>
			<table class="easyui-datagrid" title="会员信息列表" id="memlist"
						data-options="rownumbers:true,singleSelect:true,url:'mem/getlist.do',method:'get',toolbar:'#tb'">
						<thead>
							<tr>
								<th data-options="field:'number',width:80">会员卡号</th>
								<th data-options="field:'memname',width:100">会员姓名</th>
								<th data-options="field:'type',width:80">会员等级</th>
								<th data-options="field:'totalpoints',width:80,align:'right'">总积分</th>
								<th data-options="field:'leftpoints',width:80,align:'right'">可用积分</th>
								<th data-options="field:'leftmoney',width:60,align:'right'">余额</th>
								<th data-options="field:'state',width:80">卡状态</th>
								<th data-options="field:'_operate',width:80,align:'center',formatter:rowformater">操作</th>	
			<script type="text/javascript">  
					function rowformater(value, row, index) {  
						return "<a href='javascript:getinfo("+index+");' target='_self'>" + "详情" + "</a>";//_top,  
							}  
					 function getinfo(index) {
						  var row = $('#memlist').datagrid('getData').size[index];
						  alert(row.memname);
								$('#memdetail').dialog('open'); //打开窗口
											$('#detailform').reset();   //清空表单数据 
											$('#detailform').form('load',{	   //调用load方法把所选中的数据load到表单中,非常方便
												id:row.id ,
												memname:row.memname ,
												mempass:row.mempass ,
												sex:row.sex ,
												age:row.age ,
												birthday:row.birthday ,
												city:row.city ,
												starttime:row.starttime,
												endtime:row.endtime ,
												remark:row.remark
											});	
						}
   			 </script>  
							</tr>
						</thead>
					</table>
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form action="">
								<a ></a>
								办卡日期: <input class="easyui-datebox" style="width:80px" name="starttime">
								有效日期: <input class="easyui-datebox" style="width:80px" name="endtime">
								会员状态: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px">
									<option value="0">正常</option>
									<option value="1">挂失</option>
									<option value="2">黑名单</option>
								</select>
								<a href="javascript();" class="easyui-linkbutton" iconCls="icon-search">Search</a>
								</form>
							</div>
						</div>
		  
  	<!-- start 右键菜单 -->
		<div id="mm" class="easyui-menu" style="width:150px;">
				<div id="mm-tabrefresh">刷新</div>
				<div class="menu-sep"></div>
				<div id="mm-tabclose">关闭</div>
				<div id="mm-tabcloseall">全部关闭</div>
				<div id="mm-tabcloseother">除此之外全部关闭</div>
				<div class="menu-sep"></div>
				<div id="mm-tabcloseright">当前页右侧全部关闭</div>
				<div id="mm-tabcloseleft">当前页左侧全部关闭</div>
		</div>
  	<!-- end 右键菜单 -->
  	
  	<!-- start dialog adduser-->
		<div id="memdetail" title="会员详情" modal="true" draggable="false"
			class="easyui-dialog" closed="true" style="width: 600px;height: 500px">
			<form id="detailform" action="" method="post">
				<input type="hidden" name="id" value="" />
				卡号：<input type="text" name="number" value=""/>
							会员名:
							<input type="text" name="memname" class="easyui-validatebox"
								required=true validType="midLength[2,5]" missingMessage="用户名必填!"
								invalidMessage="用户名必须在2到5个字符之间!" value="" />
					
							会员密码:
						
							<input type="password" name="mempass" class="easyui-validatebox"
								required=true validType="equalLength[4]" missingMessage="密码必填!"
								value="" />
					
							性别:
						
							男
							<input type="radio" checked="checked" name="sex" value="1" />
							女
							<input type="radio" name="sex" value="2" />
					
							年龄:
						
							<input id="age" type="text" name="age" value="" />
					
							会员生日:
						
							<input id="birthday" style="width: 160px;" type="text"
								name="birthday" value="" />
					
							会员等级:
						
							<input name="cardtype" class="easyui-combobox" url="#"
								valueField="id" textField="name" value="" />
					
							会员状态:
						
							<input name="state" class="easyui-combobox" url="#"
								valueField="id" textField="name" value="" />
						
							城市:
						
							<input name="city.name" class="easyui-combobox" url="#"
								valueField="id" textField="name" value="" />
						
							开始时间:
						
							<input id="starttime" style="width: 160px;" type="text"
								name="starttime" value="" />
					
							结束时间:
						
							<input id="endtime" style="width: 160px;" type="text"
								name="endtime" value="" />
				
							个人描述:
						
							<input type="text" name="remark" class="easyui-validatebox"
								required=true validType="midLength[5,50]"
								missingMessage="个人描述必填!" invalidMessage="描述必须在5到50个字符之间!"
								value="" />
					
				<div>
					
				</div>
				
				<a id="btn1" class="easyui-linkbutton">保存</a>
				<a id="btn2" class="easyui-linkbutton">取消</a>
			</form>
		</div>
		<!-- end dialog adduser-->
  </body>
</html>
