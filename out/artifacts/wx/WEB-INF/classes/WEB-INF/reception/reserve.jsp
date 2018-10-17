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
			$(function(){
			/* 动态生成房间类型表格*/
			$.getJSON("room/getrtype.do?act=getrooms", function(json) {
				$('#roomtype').combobox({
				data : json.rtlist,
				valueField:'id',
				textField:'typename',
				onChange: function (n,o) {
					$.getJSON("room/getrtype.do?typeid="+n+"&act=getrooms", function(json) {
					$('#rooms').combobox({
					data : json.rooms,
					valueField:'roomnum',
					textField:'roomnum',
					 panelHeight:'auto',  
		                required:true,  
		                editable:true
					});
					});
				}
				});
				});
			/*a标签事件绑定 */
				$('a[title]').click(function(){
						var src = $(this).attr('title');
						var title = $(this).attr('desc');
						if($('#tt').tabs('exists' ,title)){
							$('#tt').tabs('select',title);
						} else {
							$('#tt').tabs('add',{   
							    title:title,   
							    content:'<iframe frameborder=0 style=width:100%;height:100% src='+ src +' ></iframe>',   
							    closable:true  
							});  
						}
				});
			/*日期控件初始化 */
				   var curr_time = new Date();
				   var Year=curr_time.getFullYear();
				   var Month=curr_time.getMonth()+1;
				   var Day=curr_time.getDate()+1;
				   var Day2=Day+1;
				   var starttime =Year +"-"+Month+"-"+Day+" "+"18:00:00";
				   var endtime = Year +"-"+Month+"-"+Day2+" "+"12:00:00";
				  	$("#starttime").datetimebox("setValue",starttime);
				  	$("#endtime").datetimebox("setValue",endtime);
				  	
			});
			/*确认预定提交 */
	function submitForm() {
			$.messager.confirm('预定  ', '确认预定  ', function(r){
				if($(this).form('enableValidation').form('validate')){
				if (r){
					$.ajax({  
                    type: "post",  
                    url: "res/olres.do",  
                    data: $("#resform").serialize(),  
                    success: function () {
                    	$.messager.show({ 
							              title: '提示消息', 
							              msg: '预定成功', 
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
				}
			});
	}
	function clearForm() {
		$('#resform').form('clear');
	}
	
		//会员卡信息监测
		function v_memnum(){
			var memnum=$("#memnum").val();
			if(memnum.length==5){
				$.post("mem/crisearch.do",{memnum:memnum},function(data){
					if(data.total!=0){
							var mem=data.size[0];
							$('#resname').val(mem.memname);
							$('#restel').val(mem.tel);
							$("#guesttel").textbox('setValue',mem.tel);
							$("#guestname").textbox('setValue',mem.memname);
							
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
	<style type="text/css">
		input{
			margin-left:3px;
			width: 100px;
		}
		 a label{
 				font-size: 25px;
 				color: rgb(51,107,155);
		}
	</style>
  </head>
  
  <body>
				<div id="tt" class="easyui-tabs" fit=true style="width:500px;height:250px;">  
					<div title="快速预定" style="padding:10px">
							<div style="margin: 20px  0  0 30px;">
								<form method="post" data-options="novalidate:false" id="resform" class="easyui-form">
									<label>会员卡号:</label><input class="easyui-searchbox" data-options="searcher:v_memnum,prompte:'会员快速预定'" style="width:150px" id="memnum"name="memnum"></input>
									<div><h2>预订单信息：</h2><hr>
									<label>预定人：</label><input type="text" name="resname" onkeyup="" id="resname" />
									<label>预定电话：</label><input type="text" name="restel" onkeyup="" id="restel"/>
									<h2>详细信息：</h2>
									<label>房型：</label> 
											<input class="easyui-combobox" name="roomtype"  id="roomtype" style="width:100px;margin-left: 8px;"/>										 
									房间号：	<input class="easyui-combobox" name="roomnum"  id="rooms" style="width:100px;margin-left: 8px;"/><br><br/>
									<label>抵店时间：</label><input id="starttime" class="easyui-datetimebox" name="starttime" style="width: 180px" ></input>
									<label>预离时间：</label><input id="endtime" class="easyui-datetimebox" name="endtime" style="width: 180px" ></input>
									</div>
									<h2>入住人信息：</h2><hr>
									<div id="divguest" class="infos" style="margin-top: 15px;">
										姓名:<input type="text" name="guestname" id="guestname" class="easyui-textbox">
										电话:<input type="text" name="tel" id="guesttel" class="easyui-textbox" style="width: 120px;"><br><br>
									</div>
									<div style="text-align:center;padding:5px;margin-top: 15px;">
								    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="submitForm()"><label>确认预定</label></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								    	<a href="javascript:void(0)" class="easyui-linkbutton" onclick="clearForm()"><label>重新填写</label></a>
								    </div>
								</form>
							</div>
					</div>
<!--					<div title="新增预定" style="padding:10px">-->
<!--						<iframe frameborder=0 style=width:100%;height:100%></iframe>-->
<!--					</div>-->
					<div title="订单中心" style="padding:10px" data-options="href:'jump/reception/rescenter.do'" >
						<iframe frameborder=0 style=width:100%;height:100% ></iframe>
					</div>
					<div title="逾期预订" style="padding:10px" data-options="href:'jump/reception/resoverdue.do'">
						<iframe frameborder=0 style=width:100%;height:100% ></iframe>
					</div>
			</div>
  </body>
</html>
