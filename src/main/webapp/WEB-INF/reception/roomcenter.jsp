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
    
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/common.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/css/reception/rec.css" />
	<script type="text/javascript" src="<%=basePath%>/js/jquery.min.js"></script>
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/easyui/themes/bootstrap/easyui.css" />
	<link rel="stylesheet" type="text/css" href="<%=basePath%>/js/easyui/themes/icon.css" />
	<script type="text/javascript" src="<%=basePath%>/js/easyui/jquery.easyui.min.js"></script>
	<script type="text/javascript" src="<%=basePath%>/js/easyui/locale/easyui-lang-zh_CN.js"></script>
	<style type="text/css">
		.rdiv{
			width: 100px;
			height: 100px;
			color: white;
	         
			box-shadow:10px 10px 5px #444;
			-moz-box-shadow:10px 10px 5px #444;
			-webkit-box-shadow:10px 10px 5px #444;
			position:relative;
			z-index:1;
			float: left;
  			margin: 5px 5px 10px 10px;
  			border-radius: 15px 5px;
		}
		.ycdiv{
			width: 100px;
			height: 100px;
			color: white;
			border: 10px black;
			box-shadow:10px 10px 5px #444;
			-moz-box-shadow:10px 10px 5px #444;
			-webkit-box-shadow:10px 10px 5px #444;
			position:relative;
			z-index:1;
			float: left;
  			margin: 5px 5px 10px 10px;
  			border-radius:50px;	
  			text-align: center;	
		}
		.rnum{
			padding-top: 5px;
			font-size: 20px;
			font-weight: 5;
		}
		select{
		width: 100px;
		}
		.fttdx{
			background-color: rgb(40,105,157);
			float: left;
			margin: 1px;
		}
		.fttstate{
			text-align: center;
			width: 30px;
			height: 18px;
			float: left;
			margin: 1px;
			color: white;
			border: 1px solid;
		}
		.tb{
			width: 25px;
			height: 25px;
		}
		#rdiv img:hover {
			width: 30px;
			height: 30px;
			padding: 0;
			}
			.tj{
				width: 40px;
				text-align: center;
			}
			.tl{
				width: 35px;
			}
	</style>
	<script type="text/javascript">
	var ROOMID;
	var ROOMSTATE=1;
	var ROOMTEL="";
	var str="";
		$(function(){
			/*S 宾客信息快速搜索*/
			$('#ss').searchbox({
				    searcher:function(value,name){
						$.post("room/searchinfo.do?"+name+"="+encodeURI(encodeURI(value)),function(result){
							if(result.msg=="error"){
								$.messager.show({
												title:'搜索结果',
												msg:result.tip,
												timeout:1000
											});
										}
							else{
								creatroom(result);
							}
						});
				    },
				    menu:'#mm',
				    prompt:'要搜素的宾客信息',
				    width:'250px'
				});
			/*E 宾客信息快速搜索*/
		$('#state').combobox({
		    onChange:function(newValue,oldValue){
		        roomsearch();
		    }
		});
		
		$('#floor').combobox({
		    onChange:function(newValue,oldValue){
		        roomsearch();
		    }
		});
			/* 动态生成房间类型表格*/
			$.getJSON("room/getrtype.do?act=rtcomx", function(json) {
				$('#roomtype').combobox({
				data : json.rtlist,
				valueField:'id',
				textField:'typename',
				onChange: function (n,o) {
						roomsearch();
						}
					});
				});
					
			
		/*S ***************房间操作************* */
			$('#win-cz').window("close");
				$('div[cz]').click(function(){
							var myframe=$("#winframe");
							var cz=$(this).attr('cz');
							var title=$(this).attr('title');
							var src = $(this).attr('adress');
							//主要 业务 
							//入住
							if(cz==1&&ROOMSTATE==1){
								openwin(src,myframe,title);
							}
							//办理退房
							else if((cz==2||cz==4)&&ROOMSTATE==5){
								$.post("room/checkroomprice.do",{roomid:ROOMID},function(){});
								openwin(src,myframe,title);
							}
							//预订入住
							else if(cz==3&&ROOMSTATE==2){
								openwin(src,myframe,title);
							}
							else if(cz==5&&ROOMSTATE==5){
								$.messager.show({
									title:'客房叫醒 ',
									msg:'请拨打客房电话'+ROOMTEL,
									timeout:5000,
									showType:'slide',
									 style: { 
							                right: '', 
							                bottom: ''
							              } 
								});
							}
							//房态修改 
							else if(cz==11&&ROOMSTATE!=1){
									if(ROOMSTATE==4) {
										statepost('改为空房 ','确认已维修 ，并可以入住？',cz);
									}
									else if(ROOMSTATE==2){
										$.messager.prompt('取消 ', '确认取消 预定 ？请 输入操作员密码   ', function(r){
												if (r== ${sessionScope.userpass}){
													$.post("room/changestate.do",{roomid:ROOMID,state:cz%10,remark:r},getlist);
												}
												else $.messager.alert('提示  ','密码错误 ,无法执行','warning');
												});
										}
									else if(ROOMSTATE==5){
										 $.messager.alert('提示  ','还未 结账退房..','warning');
									}
									else 
										statepost('改为空房 ','确认打扫完毕 ，并可以入住？',cz);
									}
								
							//
							else if(cz==12&&(ROOMSTATE==1||ROOMSTATE==3||ROOMSTATE==4)){
									if(ROOMSTATE!=4){
									statepost('设为预留房','确认改为预留房？请检查是否打扫。',cz);
									}
									else $.messager.alert('提示  ','此房正在维修中....... ','warning');
							}
							//清洁
							else if(cz==13&&ROOMSTATE==5){
									statepost('打扫','确认宾客退房并通知保洁打扫？ ',cz);
							}
							//报修
							else if(cz==14&&ROOMSTATE!=5){
								$.messager.prompt('报修 ', '请填写故障概要 信息  ', function(r){
									if (r){
									$.post("room/changestate.do",{roomid:ROOMID,state:cz%10,remark:r},getlist);									}
								});
							}
							else if(cz==15&&ROOMSTATE!=5){
								$.messager.prompt('特价房  ', '请设置特价房价   ', function(r){
									if (r){
									$.post("room/changerelprice.do",{roomid:ROOMID,relprice:r},function(data){
											$.messager.show({
												title:'提示 ',
												msg:'特价房设置成功 ',
												timeout:500,
												showType:'slide',
												 style: { 
										                right: '', 
										                bottom: ''
										              } 
													});
										getlist();
									});
									}
								});
							}
					});
					//修改房态统一post
					function statepost(tip,title,cz){
								$.messager.confirm(tip,title, function(r){
											if (r){
												$.post("room/changestate.do",{roomid:ROOMID,state:cz%10},getlist);
											}
								});
					}
					//操作弹窗打开
					function openwin(src,myframe,title){
						myframe.attr('src',src+"?id="+ROOMID);
									$('#win-cz').window({
										title:title,
			    						closed:false,
									    onBeforeClose:function(){ 
			        					 	 myframe.attr('src',"");
			      						 	},
			      						onMinimize: function () {     
						                //最下化移动到右下角并折叠          
						                      $('#win').window('move', {   
						                                       left: "26%",    
						                                        top: "-5px"             
						                         }).window('collapse').window('open'); 
			          						}     
									});
					}
				/*E ***************房间操作**************/
					/*S 全局阻止 鼠标右击事件*/
					document.oncontextmenu = function() {
								    return false;
								}
					/*E 全局阻止 鼠标右击事件*/
				/* S a 标签事件绑定*/
				$('a[title]').click(function(){
						var src = $(this).attr('title');
						var title = $(this).attr('desc');
						if($('#tt').tabs('exists' ,title)){
							$('#tt').tabs('select',title);
						} else {
							$('#tt').tabs('add',{   
							    title:title,   
							    content:'<iframe frameborder=0 style=width:100%;height:100% src='+ src +' ></iframe>',   
							    closable:true, 
							});  
						}
				});
				
				/* E a 标签事件绑定*/
				/* S 初始化 房态图  */
				window.onload = function(){
					$.post("room/getrtype.do?act=recept",creattab);
					getlist();
				};
					function getlist(){
							$.ajax({
									url:"room/getlist.do",
									success:creatroom
								});
							}
				/* E 初始化 房态图 */
		});
			/*S 创建房间类型 */
			function creattab(data){	
				for(var i=0;i<data.rtlist.length;i++){
					var  rt=data.rtlist[i];
						  $('#tt').tabs('add',{
						title:rt.typename,
						content:"<div  class='adddiv' style='padding:10px;' type='"+rt.typecode+"' name='room'> </div>",
						closable:false
						});
					}
				}
			/*E 创建房间类型 */
		
				/*S 封装创建房态图函数 */
			function creatroom(data){
					$('.rdiv').remove();
					$('.ycdiv').remove();
					zfjs=data.size.length;
						for(var i=0;i<data.size.length;i++){
								var room=(data.size)[i];
								var rtype=room.roomType.typecode;
								var rstate=room.roomstate;
								var color="";
								var price=0;
								var image="";
								var special="";
								if(room.relprice==null||room.relprice==0) price=room.roomType.roomprice;
								else {
									price=room.relprice;
									special="<image src='images/icons/special.png' class='tb'/>";
								}
								/* S 根据房态拼接房态图*/
								switch (rstate)
									{
									case 1:
									  color="rgb(40,105,157)";//空房 
									  break;
									case 2:
									  color="green";//预留
									 image="<image src='images/icons/reserve.png' class='tb' onmouseover='resover("+room.id+");'onmouseout='resout();'/>";
									  break;
									case 3:
									  color="gray";//打扫
									 image="<image src='images/icons/clean.png' class='tb' onmouseover='cleover("+room.id+");'onmouseout='resout();'/>";
									  break;
									case 4:
									 color="red";//维修 
									 image="<image src='images/icons/repair.png' class='tb'  onmouseover='repover("+room.id+");'onmouseout='resout();'/>";
									  break;
									 case 5:
									 color="#FF60AF";//在住 
									 image="<image src='images/icons/man.png' class='tb'  onmouseover='liveover("+room.id+");'onmouseout='resout();'/>";
									  break;
									}
									var divclass="";
								$("div[name='room']").each(function(){
								if($(this).attr("type")==rtype){ 
										if(rtype!='YC')
											divclass="rdiv";
										else 
											divclass="ycdiv";
										$(this).append("<div class='"+divclass+"' id='rdiv' name='rdiv'  onclick='roomclick(event,"+room.id+","+room.roomstate+","+room.tel+");' style='background-color:"+color+";'><p class='rnum'>"+room.roomnum+"</p>"
													+" <p class='rtname'>"+room.roomType.typename+"&nbsp;"+room.floor+"层</p><p>"+special+price+"</p><p>"+image+"</p></div>");								
									}
								});
							}
					}
					
				/*E 封装创建房态图函数*/
				/*S 房态快速查询 */
				//下拉框 查询
				function roomsearch() {
					var floor=$("#floor").combobox('getValue');
					var state=$("#state").combobox('getValue');
					var roomtype=$("#roomtype").combobox('getValue');
						$.post("room/getlist.do",{floor:floor,'roomType.id':roomtype,roomstate:state},creatroom);
				}
				//图例查询 
				function fttsearch(state) {
					var floor=$("#floor").find("option:selected").val();
					var roomtype=$("#roomtype").find("option:selected").val();
						$.post("room/getlist.do",{floor:floor,'roomType.id':roomtype,roomstate:state},creatroom);
				}
				/*E 房态快速查询 */
				/*S 房态图改变大小  */
				function fttsize(size) {
					$("div[name='rdiv']").each(function(){
							$(this).width(size);
							$(this).height(size);
					});
				}
				/*E 房态图改变大小  */
				/*S 房态图图标详细信息 */
				//预留
				function resover(roomid) {
					$.post("res/getresinfo.do",{roomid:roomid},function(data){
						var res=data.res;
						str="<div class='resover'>订单号:"+res.resnumber+"<br>预订人："+res.resname+"<br>联系电话:"+res.restel+"<br>预订时间:"+res.restime+"<br>预抵时间:"+res.starttime+"</div>";
					});
					mouseover(str);
				}
				//打扫
				function cleover(roomid) {
					mouseover("保洁正在打扫中......");
				}
				//维修
				function repover(roomid) {
					$.post("room/getroom.do",{id:roomid},function(data){
						str="<div class='resover'>损坏项目与明细：<br>"+data.room.remark+"</div>";
					});
					mouseover(str);
				}
				function liveover(roomid) {
					$.post("room/getconsumpt.do",{roomid:roomid},function(data){
					var con=data.con;
						str="<div class='resover'>入住单号:"+con.ordernum+"<br>在住人姓名："+con.guestname+"<br>入住时间:"+con.starttime+"</div>";
					
					});
					mouseover(str);
				}
				
				function mouseover(str){
					var showDiv = document.getElementById('showDiv');
					showDiv.style.left = event.clientX;
					showDiv.style.top = event.clientY;
					showDiv.style.display = 'block';
					showDiv.style.background = 'rgb(40,105,157)';
					showDiv.style.color = 'white';
					showDiv.style.padding = '15px;';
					showDiv.style.font.size = '20px;';
					showDiv.innerHTML = str;
				}
				
				function resout() {
					var showDiv = document.getElementById('showDiv');
					showDiv.style.display = 'none';
					showDiv.innerHTML = '';
				}
				/*E 房态图详细信息 */
				/*S *******房间 操作 ******* */
				function roomclick(e,id,state,tel){
					ROOMID=id;
					ROOMSTATE=state;
					ROOMTEL=tel;
					if(ROOMSTATE!=1){
					 	$("#mm-checkin").attr("disabled","disabled").css({ "cursor": "default", "opacity": "0.4" });
						$("#mm-empty").attr("disabled","disabled").css({ "cursor": "default", "opacity": "0.4" });
					 }
						else 
							$("#mm-checkin").attr("disabled","block").css({ "cursor": "default", "opacity": "1" });
						$('#mm').menu('show', {
							left: e.pageX,
							top: e.pageY
						});
					
				}
			/*E************ 房间 操作 *********** */
	</script>
  </head>
  
  <body>
		<div id="cc" class="easyui-layout" fit=true style="width:100%;height:100%;">  
r<!-- 		    <div region="south" title="South Title" split="true" style="height:100px;"></div>   -->
		    <div region="west"  iconCls="icon-ok" split="true" title="操作台" style="width:270px;">
				<div id="ftzx" class="easyui-accordion" fit=true >  
				    <div title="快捷操作"  style="overflow:auto;padding:10px;"> 
				    	<!-- S 房态图快捷 -->
				    		<!-- 大小调节 -->
				    		图例大小：
				    	<div style="width: 130px;height: 50px;">
				    		<div style="width: 30px;height: 30px; background-color: " class="fttdx" onclick="fttsize(130)"></div>
			    			<div style="width: 25px;height: 25px;" class="fttdx" onclick="fttsize(100)"></div>
					     	<div style="width: 20px;height: 20px;" class="fttdx" onclick="fttsize(80)"></div>
		    			</div>
		    				<!-- 房态图基本信息  -->
		    				房态图例：
		    			<div>
		    				<div style="background-color:rgb(40,105,157);" class="fttstate" onclick="fttsearch(1)">空房</div>
		    				<div style="background-color:#FF60AF;"  class="fttstate" onclick="fttsearch(5)">在住</div>
		    				<div style="background-color:green;" class="fttstate" onclick="fttsearch(2)">预留</div>
		    				<div style="background-color:gray" class="fttstate" onclick="fttsearch(3)">打扫</div>
		    				<div style="background-color:red" class="fttstate" onclick="fttsearch(4)">维修</div>
		    				
		    			</div><br><br><br>
		    			<!-- E 房态图快捷  -->
				    	<!-- S 房间快速搜索 -->
					    <div>
					    		楼层：<select id="floor" class="easyui-combobox" name="floor"  data-options="onselect:roomsearch"  style="width:150px;">
									        <option value="" selected="selected">全部</option>
										    <option value="1">1</option>
										    <option value="2">2</option>
										    <option value="3">3</option>
									    </select>
					    		
					    		<br><br>
								房型：<input name="roomtype" id="roomtype" style="width: 150px;"/><br><br>
								
								房态：<select id="state" class="easyui-combobox" name="state"  data-options="onselect:roomsearch"  style="width:150px;">
									    <option value="" selected="selected">全部</option>
									    <option value="1">空房</option>
									    <option value="5">在住</option>
									    <option value="3">打扫</option>
									    <option value="4">维修</option>
									    <option value="2">预定</option>
									</select>
					    </div><br>
					    <!-- S 宾客信息快速搜索 -->
								 <input id="ss"></input>
									<div id="mm" style="width:120px">
									    <div data-options="name:'tel',iconCls:'icon-ok'">手机号</div>
									    <div data-options="name:'guestname'">宾客姓名</div>
									    <div data-options="name:'idnum'">身份证号</div>
									</div>		
						<!-- E 宾客信息快速搜索 -->
					    <br><br/><br>
					  <a href="javascript:void(0);" onclick="javascript:$.post('room/getlist.do',creatroom);" class="easyui-linkbutton" style="width: 150px;height: 30px;margin-left: 50px;"> 房态更新</a>
				    </div> 
				    		
				    <!-- E 房间快速搜索 -->
				    <!-- S 实时统计 --> 
				    <script type="text/javascript">
				    
				    </script>
				    <div title="实时统计"   style="padding:10px; float: none" > 
				    	 	<div style="background-color:rgb(40,105,157);" class="tl" onclick="fttsearch(1)">空房</div>
				    	 	房间数：<input type="text" id="kf" readonly="readonly" class="tj">间<input type="text" id="kfbfb" class="tj" readonly="readonly">%
		    				<div style="background-color:#FF60AF;" class="tl" onclick="fttsearch(5)">在住</div>
		    				房间数：<input type="text" id="zz" readonly="readonly" class="tj">间<input type="text" id="zzbfb" class="tj" readonly="readonly">%
		    				<div style="background-color:green;" class="tl" onclick="fttsearch(2)">预留</div>
		    				房间数：<input type="text" id="yl" readonly="readonly" class="tj">间 <input type="text" id="ylbfb" class="tj" readonly="readonly">%
		    				<div style="background-color:gray" class="tl" onclick="fttsearch(3)">打扫</div>
		    				房间数：<input type="text" id="qj" readonly="readonly" class="tj"> 间<input type="text" id="qjbfb" class="tj" readonly="readonly">%
		    				<div style="background-color:red" class="tl" onclick="fttsearch(4)">维修</div>
		    				房间数：<input type="text" id="wx" readonly="readonly" class="tj">间 <input type="text" id="wxbfb"class="tj" readonly="readonly">%
				   <br><br/>
				   总房间数:<input type="text" id="zfjs" class="tj" readonly="readonly"/> <br>   <br>
				   入&nbsp;住&nbsp;率:<input type="text" id="rzl" class="tj"  style="width: 50px;" readonly="readonly">%
				</div>  
				    <!-- E 实时统计 --> 
				    <div title="权限树管理" style="overflow:auto;padding:10px;">
				   		 <a title="jsp/shouquan.jsp" ></a> <br/>  
				   		
				    </div> 
				</div>  
	 </div> 
	 <!-- S  房态中心图例 --> 
		  <div region="center"  title="房态中心" style="padding:5px;">
			<div id="tt" class="easyui-tabs" fit=true style="width:500px;height:250px;" class="tt">  
			</div>
		</div> 
	<!-- E  房态中心图例 --> 
		 		    				
	</div>
  	<!-- S 右键菜单 -->
		<div id="mm" class="easyui-menu" style="width:150px;">
				<div class="menu-sep" ></div>
				<div name="mm-cz" id="mm-checkin"  data-options="iconCls:'icon-save'" cz="1" title="办理入住" adress="jump/reception/checkin.do">办理入住</div>
				<div name="mm-cz" id="mm-checkout" cz="2" title="结账退房" adress="room/checkout.do">结账退房</div>
				<div name="mm-cz" id="mm-resin" cz="3" title="预定入住" adress="res/checkin.do">预定入住</div>
				<div name="mm-cz" id="mm-good" cz="4" title="财务入账" adress="jump/reception/raddgood.do">财务入账</div>
				<div name="mm-cz" id="mm-good" cz="5" title="叫醒" adress="">叫醒</div>
				<div>
					<span>修改房态</span>
					<div id="mm-cstate">
						<div id="mm-empty"  data-options="iconCls:'icon-ok'" cz="11" title="空房">空房</div>
						<div id="mm-res" data-options="iconCls:'icon-lock'" cz="12" title="预留">预留</div>
						<div id="mm-clean" data-options="iconCls:'icon-redo'" cz="13" title="打扫">打扫</div>
						<div id="mm-repair"  data-options="iconCls:'icon-cancel'" cz="14" title="维修">维修中</div>
						<div id="mm-repair"  data-options="iconCls:'icon-filter'" cz="15" title="今日特价">今日特价</div>	
					</div>
				</div>
				<div class="menu-sep"></div>
		</div>
  	<!-- E 右键菜单 -->
  	<!-- S 鼠标滑过提示信息 -->
  		<div id="showDiv" style="position: absolute; background-color: white; border: 1px solid black;"></div>
  	<!-- E 鼠标滑过提示信息 -->
  	<!-- S 办理入住 -->
		<div id="win-cz" class="easyui-window"  style="width:700px;height:600px;padding:10px;">
 			<iframe src="" name="winframe" id="winframe" noresize="noresize"  marginwidth="0"  frameborder="0" style="width: 100%;height: 100%;"></iframe>
		</div>  	
	<!-- E 办理入住  -->
  </body>
</html>
