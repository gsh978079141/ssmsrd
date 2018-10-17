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
	<style type="text/css">
		hr{
			width: 85%;
			height:10px;border:none;border-top:10px groove skyblue;
		}
		.memdetail input{
			margin-left:5px;
		}
		#memdetail a{
			float:left;
			margin:  0 20px;
			width: 100px;
			height: 30px;
			background: skyblue;
			text-align: center;
		}
		#memdetail a label{
			font-size: 13px;
		}
		.hykxx{
		background-color:#EAEAEA; width: 550px;
		}
		.grxx{
		 background-color:#EAEAEA; width: 550px;
		
		}
	</style>
	<script type="text/javascript">
		$(function(){
			//查询--查询按钮事件 
			$('#serachbtn').click(function(){
				$('#memlist').datagrid('load' ,{
						memnum: $('#searmemnum').val(),
						state: $('#searstate').combobox('getValue'),
						memname:$('#searmemname').val()
					});
				});
			//查询--清空按钮事件
			$('#clearbtn').click(function(){
						$('#mysearch').form('clear');
						$('#memlist').datagrid('load' ,{});
					});
		});
	
	</script>
  </head>
  
  <body>
			<table class="easyui-datagrid" title="会员信息列表" id="memlist" data-options="rownumbers:true,singleSelect:true,url:'mem/crisearch.do',method:'post',toolbar:'#tb',pagination: true , 
							pageSize: 10 ,
							pageList:[5,10,15,20,50] ,fit:true,
							rowStyler: function(index ,record){
								 if(record.state ==2){
									 return 'background:yellow';
								 }if(record.state==3)
								 return 'background:red';
								 },loadMsg: '数据加载中......',
								 onLoadSuccess: onloadS
								 ">
						<thead>
						<script>
							function onloadS(data) {
					            if (data.total == 0) {
								    var body = $(this).data().datagrid.dc.body2;
								    body.find('table tbody').append('<div width="' + body.width() + '"style="text-align:center;color:red;" ><img src="images/no-data.png"/></div></td></tr>');
			  			     	 $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').hide();
								  }					          
					            else $(this).closest('div.datagrid-wrap').find('div.datagrid-pager').show();
					        }
						</script>
							<tr>
								<th data-options="field:'memnum',width:80" style="">会员卡号</th>
								<th data-options="field:'memname',width:100">会员姓名</th>
								<th data-options="field:'memType',width:80,formatter:function(value,record,index){return value.typename;}">会员等级</th>
								<th data-options="field:'totalpoints',width:80,align:'right'">总积分</th>
								<th data-options="field:'leftpoints',width:80,align:'right'">可用积分</th>
								<th data-options="field:'leftmoney',width:60,align:'right'">余额</th>
								<th data-options="field:'state',width:80,formatter:function(value,record,index){if(value==1)return '正常';if(value==2)return '挂失';if(value==3)return '黑名单';
								return value.typename;}">卡状态</th>
								<th data-options="field:'_operate',width:80,align:'center',formatter:rowformater">操作</th>	
			<script type="text/javascript">  
					function rowformater(value, row, index) {  
						return "<a href='javascript:getinfo("+index+");' target='_self' style='color:blue;'> " + "详情" + "</a>";//_top,  
							}  
					 function getinfo(index) {
						  var row = $('#memlist').datagrid('getData').size[index];
								$('#memdetail').dialog('open'); //打开窗口
											//$('#detailform').reset();   //清空表单数据 
											$('#meminfo').form('load',{	   //调用load方法把所选中的数据load到表单中,非常方便
												id:row.id ,
												memnum:row.memnum,
												memname:row.memname ,
												mempass:row.mempass ,
												sex:row.sex ,
												age:row.age ,
												birthday:row.birthday ,
												area:row.area ,
												memtype:row.memType.typename,
												starttime:row.starttime,
												endtime:row.endtime ,
												remark:row.remark,
												idnum:row.idnum,
												tel:row.tel,
												totalpoints:row.totalpoints,
												usedpoints:row.usedopints,
												leftpoints:row.leftpoints,
												totalmoney:row.totalmoney,
												leftmoney:row.leftmoney,
												idtype:2
											});	
											if(row.state==1) {  
												$("#state").textbox('setValue',"正常");
												$("#btngs").css("display","block");
												$("#btnjrhmd").css("display","block");
											}
											else if(row.state==2)  {
												$("#state").textbox('setValue',"挂失");
												$("#btnjcgs").css("display","block");
												$("#btnjrhmd").css("display","block");
											 }
											else  if(row.state==3){
												$("#state").textbox('setValue',"黑名单");
												$("#btnychmd").css("display","block");
												 }
													
						}
						
						
						function btnreset() {
							$('a[name=btns]').each(function(){
								$(this).css("display","none");							
							});
						}
   			 </script>  
							</tr>
						</thead>
					</table>
					<!-- S 搜索域  -->
						<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								会员卡号：<input type="text" id="searmemnum" name="searmemnum"  value="" class="easyui-textbox" style="width:60px;"/>
								会员姓名：<input type="text" id="searmemname" name="searmemname"  value="" class="easyui-textbox" style="width:60px;"/>
<!--								办卡日期: <input class="easyui-datebox" style="width:80px" id="searstarttime" name="searstarttime">-->
<!--								有效日期: <input class="easyui-datebox" style="width:80px" name="searendtime">-->
								会员状态: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="searstate" id="searstate">
									<option value="">全部</option>
									<option value="1">正常</option>
									<option value="2">挂失</option>
									<option value="3">黑名单</option>
								</select>
								<a id="serachbtn"  class="easyui-linkbutton" iconCls="icon-search">查询</a>
								<a id="clearbtn" class="easyui-linkbutton" >清空</a>
								</form>
							</div>
						</div>
					<!-- E 搜索域  -->
  	<!-- S 右键菜单 -->
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
  	<!-- E 右键菜单 -->
  	
  	<!-- S dialog meminfo-->
		<div id="memdetail" title="会员详情" modal="true" draggable="false"class="easyui-dialog" closed="true" style="width: 600px;height: 500px" data-options="onClose:function(){ btnreset();}">
			<h2 align="center">会员详细信息</h2><hr>
		  <div style="margin-left: 15px;font-family: 微软雅黑;font-weight: 5px;">
			<form id="meminfo" method="post">
				<input type="hidden" name="id"  id="memid"/>
				<h3>会员卡信息：</h3>
				<div class="hykxx">
				<div style="margin-left: 10px">
				会员卡号：<input type="text" name="memnum" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				会员密码：<input type="password" name="mempass" id="mempass" class="easyui-validatebox"required=true validType="equalLength[4]" missingMessage="密码必填!"value="" style="width:80px;" /><br/>
				会员等级：<input name="memtype" class="easyui-combobox" url="#"valueField="id" textField="name" value="" style="width: 90px;" readonly="readonly"/>
				会员状态：<input type="text"id="state" name="state" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				绑定手机号：<input type="text" name="tel" value="" class="easyui-textbox" readonly="readonly" style="width:120px;"/><br>
				总积分：<input type="text" name="totalpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				兑换积分：<input type="text" name="usedpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				剩余积分：<input type="text" name="leftpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/><br/>
				总储值：<input type="text" name="totalmoney" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				剩余储值：<input type="text" name="leftmoney" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				会员卡号：<input type="text" name="memnum" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				</div>
				</div>
				<h3>个人身份信息：</h3>
				<div class="grxx" >
				<div style="margin-left: 10px">
				会员姓名：<input type="text" name="memname" id="memname" style="width: 60px;" class="easyui-validatebox" required=true validType="midLength[2,5]" missingMessage="会员姓名必填!"invalidMessage="用户名必须在2到5个字符之间!" value=""  />
				证件类型：<select id="idtype" class="easyui-combobox" name="idtype" style="width:90px;" disabled="disabled">
					    <option value="1">身份证</option>
					    <option value="2">学生证</option>
					    <option value="3">军人证</option>
					    <option value="4">驾驶证</option>
					    <option value="5">护照</option>
					    <option value="6">员工证</option>
					    <option value="7">其他</option>
					</select>
				身份证号：<input type="text" name="idnum" style="width: 150px;" class="easyui-validatebox" required=true validType="midLength[0,18]" missingMessage="身份证必填!"invalidMessage="请输入有效身份证" value=""  readonly="readonly" /><br>
				性别：男<input type="radio" checked="checked" name="sex" value="男"style="10px;" readonly="readonly"/>
					女<input type="radio" name="sex" value="女" style="10px;" readonly="readonly"/>
				年龄：<input id="age" type="text" name="age" value="" style="width: 40px;" class="easyui-numbox" readonly="readonly"/>
				城市：<input name="area" class="easyui-textbox" valueField="id" textField="area" value="" style="width: 50px;" readonly="readonly"/>
				会员生日：<input id="birthday" class="easyui-textbox"  type="text"name="birthday" value="" style="width: 100;" readonly="readonly"/><br>
				办卡时间：<input id="starttime"  type="text"name="starttime" value="" style="width: 100;" class="easyui-textbox" readonly="readonly"/>
				有效期至：<input id="endtime" type="text" name="endtime" value="" style="width: 100;" class="easyui-textbox"/><br>
	    	             个人备注:<input class="easyui-textbox" id="remark"name="remark" data-options="multiline:true,prompt:'饮食口味或者其他住房习惯'" style="height:60px"></input><br>
				</div></div><br/>
			</form>
				<div>
				<a id="btnsave" class="easyui-linkbutton" onclick="memsave();" href="javascript:void(0);"><label>保存信息</label></a>
				<a id="btngs" class="easyui-linkbutton" style="display: none;" name="btns" onclick="statecz(2);"><label>挂失</label></a>
				<a id="btnjcgs" class="easyui-linkbutton" style="display: none;"  name="btns" onclick="statecz(22);"><label>解除挂失</label></a>
				<a id="btnjrhmd" class="easyui-linkbutton" style="display: none;"  name="btns" onclick="statecz(3);"><label>加入黑名单</label></a>
				<a id="btnychmd" class="easyui-linkbutton" style="display: none;"  name="btns" onclick="statecz(33);"><label>移除黑名单</label></a>
				<a id="btndel" class="easyui-linkbutton" onclick="statecz(4);"><label>删除会员</label></a>
				</div>	
			</div>
		</div>
		<!-- S 事件绑定 -->
				<script type="text/javascript">
				//刷新表格 关闭弹窗 复位按钮 
						function reset(){
							btnreset();
							$("#memlist").datagrid('reload');	
							$('#memdetail').dialog('close');
						}
					function statecz(state) {
						var tips="";
						 switch(state)
							{
							case 2:tips="挂失后将无法预订,并且将冻结会员卡资金，确定挂失？";break;
							case 22:tips="提示：是否解除挂失？";break;
							case 3 :tips="警告！加入黑名单 ，请填写 原因 ";break;
							case 33:tips="提示： 是否移除黑名单 ？";break;
							case 4:tips="危险操作：是否删除会员吗？";break;
							}
					        $.messager.defaults = { ok: "确定", cancel: "取消" };
					        $.messager.confirm("操作提示",tips , function (data){
							 if (data) {
								$.post("mem/memstatecz.do",{memid:$("#memid").val(),cz:state},reset);
								}
					        });
					   }
				//保存信息
				function memsave(){
								$.post("mem/savemem.do",{id:$("#memid").val(),mempass:$("#mempass").val(),endtime:$("#endtime").val(),remark:$("#remark").val(),memname:$("#memname").val()},function(){
							            $.messager.show({ 
							              title: '提示消息', 
							              msg: '修改已保存 ', 
							              showType: 'fade', 
							              timeout: 200, 
							              style: { 
							                right: '', 
							                bottom: ''
							              } 
							            }); 
							            reset();
								});
					}   
					   
				</script>
				<!-- S 按钮事件 -->
		<!-- E dialog meminfo-->
  </body>
</html>
