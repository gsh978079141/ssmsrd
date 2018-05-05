<%@page import="com.gsh.model.Room"%>
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
		input{
			margin-left:30px;
			width: 80px;
			
		}
		label{
 				font-size: 25px;
 				color: rgb(51,107,155);
		}
		#divbtn{
			margin-left: 200px;
		}
		.infos{
			background-color: rgb(239,239,239);
			margin:  20px 10px;
			padding: 5px;
		    justify-content: space-around;	
		    	}
		   a{
		   	margin-left: 40px;
		   }
	</style>
	<script type="text/javascript">
			var room;
			var roomRate=1.0;
			window.onload=function memnum(){
			var memnum=$("#memnum").val();
			if(memnum!=null&&memnum!="")
				v_memnumhand();
			}
		$(function(){
			//会员卡号自动填充
			
			//日期控件初始化 
				 $('#starttime').datebox().datebox('calendar').calendar({
                validator: function(date){
                    var now = new Date();
                    var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                    var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
                    return d1<=date && date<=d2;
                }
            });
            	$('#endtime').datebox().datebox('calendar').calendar({
                validator: function(date){
                    var now = new Date();
                    var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
                    var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate()+10);
                    return d1<=date && date<=d2;
                }
            });
				
				formatterDate = function(date) {
					var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
					var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1);
					return date.getFullYear() + '-' + month + '-' + day;
				};
				
				formatterDate2=function(date) {
					var day = date.getDate() > 9 ? date.getDate() : "0" + date.getDate();
					var month = (date.getMonth() + 1) > 9 ? (date.getMonth() + 1) : "0"
					+ (date.getMonth() + 1);
					return date.getFullYear() + '-' + month + '-' + day+1;
				};
				$("#starttime").datebox("setValue",formatterDate(new Date()));
				$("#endtime").datebox("setValue",formatterDate2(new Date()));
				//为页面自动赋值  
				//房间信息 
				$.post("room/getroom.do",{id:${param.id}},function(data){
							room=data.room;
							if(room.relprice!=null&&room.relprice!=0){
							$("#starttime").attr("readonly", "readonly"); 
							$("#endtime").attr("readonly", "readonly"); 
							 $("#hourday").combobox('setValue',0);
							 $("#hourday").combobox('setText','特价房');
							 $("#hourday").combobox("disable");
							$("#roomprice").textbox('setValue',room.relprice);
 							}
 							else{
								$("#roomprice").textbox('setValue',room.roomType.roomprice);
							}
							$("#roomType").textbox('setValue',room.roomType.typename);
							$("#roomnum").textbox('setValue',room.roomnum);
						});	
				//宾客信息 /*error*/ 
					function guestinfo(){
					var guest=$("#resinfo");
					if(guest!=""){
						$("#tel").textbox('setValue',guest.restel);		
						$("#guestname").textbox('setValue',guest.resname);
						if(guest.memnum!=""&&guest.memnum!=null&&guest.memnum!=undifiend){
							v_memnum2(guest.memnum);
						}
					}
				}
						//是否为钟点房 
						$("#hourday").combobox({
							onChange: function (n,o) {
								if(room.relprice==null||room.relprice==0){
									if(n==0)$("#roomprice").textbox('setValue',room.roomType.roomprice*roomRate);
									else $("#roomprice").textbox('setValue',room.roomType.hourprice*roomRate);
									}
								}
							});
					});
						
						
	</script>
		
	
	<script type="text/javascript">
		//手动 会员卡信息监测
		function v_memnumhand(){
			var memnum=$("#memnum").val();
			v_memnum2(memnum);
		}
		//会员卡信息检测
		function v_memnum2(memnum){
			if(memnum.length==5){
				$.post("mem/crisearch.do",{memnum:memnum},function(data){
					if(data.total!=0){
							var mem=data.size[0];
							if(mem.state=="2"){
								$.messager.alert('提示:','会员卡已挂失无法入住...','error'); 	
							}
							else if(mem.memType.state==0){
								$.messager.alert('提示:','此类型会员已停用','error'); 	
							}
							else if(mem.state=="3"){
								$.messager.alert('警告 :','黑名单会员 无权操作 ...','error'); 	
							}
							else{
							$("#sex").textbox('setValue',mem.sex);
							$("#birth").textbox('setValue',mem.birthday);
							$("#area").textbox('setValue',mem.area);	
							$("#idnum").textbox('setValue',mem.idnum);
							$("#tel").textbox('setValue',mem.tel);		
							$("#guestname").textbox('setValue',mem.memname);	
							$("#dq").linkbutton('disable');	
							$("#guestType").combobox('setValue',2);
							$("#idtype").combobox('setValue',1);
							var msprice=mem.memType.sprice;//此类会员特价房是否享受折扣
							var rprice=room.relprice;//特价房价格
							var rsprice=room.roomType.sprice;//此类房特价是否享受折扣
							var lastprice=0;
							roomRate=mem.memType.roomrate;
							if(rprice!=null&&rprice!=0){
								if(msprice==1&&rsprice==1){
									lastprice=rprice*roomRate;
									}
								else 
									lastprice=rprice;
							}
							else{
								lastprice=(room.roomType.roomprice)*roomRate;
								}
							$('#roomprice').textbox('setValue',lastprice);
							$('#memid').val(mem.id);
							}
						}
						else{
							roomRate=1.0;
							 $.messager.show({ 
							              title: '提示消息', 
							              msg: '会员卡号不存在，请检查 ', 
							              showType: 'fade', 
							              timeout: 400, 
							              style: { 
							                right: '', 
							                bottom: '',
							              } 
							            }); 
							}        
				});
			   }
			   else	
			   $.messager.alert('提示:','会员卡号为五位纯数字','error'); 
		}
		//身份证信息监测
		 function v_idnum(){
				  var idnum=$("#idnum").val();
				  	  if(idnum.length==18){
						$.post("jump/checkid.do",{idnum:idnum},function(data){
							data=eval("("+data+")");
								if(data.status==0){
								var idinfo=data.result;
								$("#sex").textbox('setValue',idinfo.sex);
								$("#birth").textbox('setValue',idinfo.birth);
								$("#area").textbox('setValue',idinfo.area);									
								}
								else{
								  $.messager.alert('提示:','身份信息有误！请核实！','error'); 	
								}
						});
			   			}
			   			else	
			   			$.messager.alert('提示:','请输入有效身份证号','error'); 	
					}
		//提交按钮
		function submitForm(){
		$.messager.confirm('办理入住 ', '确认办理入住 ', function(r){
				if (r){
					$.ajax({  
                    type: "post",  
                    url: "room/checkin.do?hourday="+$("#hourday").combobox('getValue'),  
                    data: $("#myform").serialize(),  
                    success: function () {
				 	parent.$('#win-cz').window('close');
                    }  
                });  
				}
			});
			  
		}
		//重置 按钮
		function clearForm(){
			$('#myform').form('clear');
		}
	
	</script>
  </head>
<body>

			<h3>办理入住</h3>
			<div>
			<input type="hidden" id="resinfo" value="${resinfo}">
			<form method="post" id="myform" action="room/checkin.do">
			<div id="divroominfo" class="infos">
				房型：<input name="roomType" id="roomType" readonly="readonly" class="easyui-textbox">
				房号:<input  name="roomnum" id="roomnum" readonly="readonly" class="easyui-textbox">
				会员卡号:<input  name="memnum" id="memnum"  data-options="prompt:'会员卡号'"class="easyui-textbox" value="${resinfo.memnum}">
				<a href="javascript:void(0)" class="easyui-linkbutton" onclick="v_memnumhand()"  iconCls="icon-lock">读取</a><br><br>
				<input name="memid" type="hidden" id="memid">
				<input name="roomid" type="hidden" id="rooomid" value="${param.id}">
				宾客类型:<select class="easyui-combobox" name="guestType.id" style="width:100px;" id="guestType">
							<option value="1">散客自入</option>
							<option value="2">vip会员</option>
							<option value="3">协议单位</option>
							<option value="4">酒店管理</option>
						</select>
		
				开房方式:<select class="easyui-combobox" name="hourday" style="width:100px;" id="hourday" >
							<option value="0">天房</option>
							<option value="1">钟点房/小时</option>
						</select>
				房价:<input type="text" name="roomprice" id="roomprice" readonly="readonly" class="easyui-textbox" style="width: 60px;"><br><br>
				入住时间:<input type="text" name="starttime" id="starttime" class="easyui-datebox" required="required" style="width: 150px;" editable="false" >
				预离时间<input type="text" name="endtime" id="endtime" class="easyui-datebox" required="required" style="width: 150px;" editable="false">
			</div>
				
			<div id="divguest" class="infos">
				姓名:<input type="text" name="guestname" id="guestname" class="easyui-textbox" value="${resinfo.resname}">
				电话:<input type="text" name="tel" id="tel" class="easyui-textbox" style="width: 120px;"value="${resinfo.restel}"><br><br>
				证件类型:<select class="easyui-combobox" name="idtype.id" style="width:100px;" id="idtype">
							<option value="1">身份证</option>
							<option value="2">学生证</option>
							<option value="3">军人证</option>
							<option value="4">驾驶证</option>
							<option value="5">护照</option>
							<option value="6">员工证</option>
							<option value="7">其他</option>
						</select>
				身份证号:<input class="easyui-textbox" type="text" name="idnum" data-options="prompt:'身份证号',required:true" id="idnum" style="width: 170px;"></input>
	    		<a href="javascript:void(0)" id="dq" class="easyui-linkbutton" onclick="v_idnum()"  iconCls="icon-lock">读取</a><br><br>
				出生年月:<input type="text" name="birth" id="birth" readonly="readonly" class="easyui-textbox" style="width: 150px;">
				性别:<input type="text" name="sex" id="sex" readonly="readonly" class="easyui-textbox"><br><br>
				地址:<input type="text" name="area" id="area" style="width: 250px;" class="easyui-textbox"readonly="readonly">
			</div>
				
			<div id="divdetail" class="infos">
				支付方式:<select class="easyui-combobox" name="paymethod" style="width:100px;" id="paymethod" >
							<option value="1">现金</option>
							<option value="3">网上支付</option>
							<option value="5">信用卡</option>
							<option value="6">酒店员工</option>
						</select>
				押金:<input type="text" name="deposit" id="deposit" class="easyui-textbox" data-options="prompt:'押金',required:true">
				操作员:<input type="text" value="${sessionScope.user}" readonly="readonly" class="easyui-textbox"><br><br>
				备注:<input class="easyui-textbox" data-options="multiline:true,prompt:'宾客的其他要求'"  style="width:300px;height:50px" name="remark"><br><br>
			</div>
			
			</form>
			</div>
			
			<div id="divbtn">
	    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()"><label>确认入住</lable></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()"><label>重新填写</label></a>
			</div>
					
</body>
</html>
