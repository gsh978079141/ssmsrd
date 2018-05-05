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
	
	
	
  </head>
  		
 	 <body>
 	 	<h1>积分中心</h1>
			<div style="background-color:rgb(239,239,239); padding: 5px; ">
			会员卡号:<input  name="memnum" id="memnum"  data-options="prompt:'会员卡号'"class="easyui-textbox">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="checknum();"  iconCls="icon-lock">读取</a>
				<script type="text/javascript">
				var MEMID=0;
  		function checknum(){
			var memnum=$("#memnum").val();
			if(memnum.length==5){
				$.post("mem/crisearch.do",{memnum:memnum},function(data){
					if(data.total!=0){
							var mem=data.size[0];
							if(mem.state=="2"){
								$.messager.alert('提示:','会员卡已挂失...','error'); 	
							}
							else if(mem.memType.state==0){
								$.messager.alert('提示:','此类型会员已停用','error'); 	
							}
							else if(mem.state=="3"){
								$.messager.alert('警告 :','黑名单会员 无权操作 ...','error'); 	
							}
							else{
							$("#memtype").textbox('setValue',mem.memType.typename);
							$("#state").combobox('setValue',mem.state);  
							$("#totalpoints").textbox('setValue',mem.totalpoints);	
							$("#usedpoints").textbox('setValue',mem.usedpoints);	
							$("#leftpoints").textbox('setValue',mem.leftpoints);	
								MEMID=mem.id;
							}
						}
						else{
							 $.messager.show({ 
							              title: '提示消息', 
							              msg: '会员卡号不存在，请检查 ', 
							              showType: 'fade', 
							              timeout: 400, 
							              style: { 
							                right: '', 
							                bottom: ''
							              } 
							            }); 
							            
						}
				});
			   }
			 else	
			   $.messager.alert('提示:','会员卡号为五位纯数字','error'); 
		}
		
		
  </script>
  			</div>
  			<div>
				<div style="background-color:rgb(239,239,239); padding: 5px;" id="hykxx">
				会员等级：<input type="text" style="width: 90px;"  value=""  class="easyui-textbox" id="memtype" readonly="readonly"/>
				会员状态：
					<select class="easyui-combobox" name="state" style="width:80px;height: 30px;" id="state" disabled="disabled" >
							<option value="1">正常</option>
							<option value="2">挂失</option>
							<option value="3">黑名单</option>
						</select>
				总&nbsp;积&nbsp;分：<input type="text" id="totalpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				兑换积分：<input type="text" id="usedpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				剩余积分：<input type="text" id="leftpoints" value="" class="easyui-textbox" readonly="readonly" style="width:60px;"/>
				</div>
				<div>
				<!-- S 菜单栏 搜索区域 -->
					<!-- 	<div id="tb" style="padding:5px;height:auto">
							<div>
								<form method="post" id="mysearch">
								<a ></a>
								商品名称：<input type="text" id="name" name="name"  value="" class="easyui-textbox" style="width:60px;"/>
								积分：<input type="text" id="p1" name="p1"  value="" class="easyui-textbox" style="width:60px;"/>--
									<input type="text" id="p2" name="p2"  value="" class="easyui-textbox" style="width:60px;"/>
								办卡日期: <input class="easyui-datebox" style="width:80px" id="searstarttime" name="searstarttime">
								有效日期: <input class="easyui-datebox" style="width:80px" name="searendtime">
								类别: 
								<select class="easyui-combobox" panelHeight="auto" style="width:100px" name="type" id="type">
									<option value="数码">数码</option>
									<option value="食品">食品</option>
									<option value="运动">运动</option>
									<option value="床上用品">床上用品</option>
								</select>
								<input  type="button" onclick="serachbtn();"  style="width: 80px;height: 20px;" value="查询"/>
								<input type="button" onclick="clearbtn();"  value="清空" style="width: 80px;height: 20px;"/>
								
								</form>
							</div>
						</div> -->
				<!-- E 菜单栏 搜索区域 -->
					<table class="easyui-datagrid" title="商品信息列表" id="goodlist" style="width: 600px;height: 420px;"
						data-options="rownumbers:true,singleSelect:true,url:'mem/getgoodlist.do',toolbar:'#tb',pagination: true">
						<thead>
							<tr>
								<th data-options="field:'id',width:30">代号</th>
								<th data-options="field:'name',width:90">商品名</th>
								<th data-options="field:'price',width:100">价格</th>
								<th data-options="field:'points',width:80">所需积分</th>
								<th data-options="field:'amount',width:80,align:'right'">剩余数量</th>
								<th data-options="field:'_operate',width:80,align:'center',formatter:rowformater">操作</th>	
							</tr>
						</thead>
					</table>
				</div>
  			</div>
  				<script type="text/javascript">  
											function rowformater(value, row, index) {  
												return "<a href='javascript:dh("+index+");' target='_self'>" + "兑换" + "</a>";//_top,  
													}  
											 function dh(index) {
												 var left=$("#leftpoints").textbox('getValue');	
											 	 var total=$("#totalpoints").textbox('getValue');
												 var row = $('#goodlist').datagrid('getData').size[index];
												 var need=row.points;
												  if(need>left){
			   										$.messager.alert('提示:','积分不足','error'); 	
												  }
												  else {
												  	 $.messager.confirm("提示","确认花费"+row.points+"兑换？" , function (data){
														 if (data) {
															$.post("mem/duihuan.do",{memid:MEMID,need:need,goodid:row.id},function(data){
																if(data.msg=="no"){
																	$.messager.alert('提示:','库存不足，兑换失败','error'); 	
																}
																else{
																$.messager.show({
																title:'提示',
																msg:'已兑换',
																timeout:100,
																showType:'slide',
																 style: { 
														                right: '', 
														                bottom: ''
														              } 
																});
																$("#goodlist").datagrid('reload');
																	checknum();
																}
															});
															}
												        });
												  }
												}
						   			 </script>  
		
	</body>
</html>