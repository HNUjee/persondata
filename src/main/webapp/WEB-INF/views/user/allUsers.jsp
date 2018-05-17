<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>用户总数</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
	<link rel="stylesheet" href="${ctx }/assets/css/user.css" media="all" />
</head>
<body class="childrenBody">
	<blockquote class="layui-elem-quote news_search">
		<div class="layui-inline">
		    <div class="layui-input-inline">
		    	<input type="text" value="" placeholder="请输入关键字" class="layui-input search_input">
		    </div>
		    <a class="layui-btn search_btn">查询</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-normal usersAdd_btn">添加用户</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
		</div>
	</blockquote>
	<div class="layui-form users_list">
	  	<table class="layui-table">
		    <colgroup>
				<col width="50">
				<col width="18%">
				<col width="18%">
				<col width="12%">
				<col width="12%">
				<col width="18%">
				<col width="15%">
		    </colgroup>
		    <thead>
				<tr>
					<th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
					<th>登录名</th>
					<th>邮箱</th>
					<th>性别</th>
					<th>用户状态</th>
					<th>最后登录时间</th>
					<th>操作</th>
				</tr> 
		    </thead>
		   
		    <tbody class="users_content"></tbody>
		</table>
	</div>
	<div id="page"></div>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<%-- <script type="text/javascript" src="${ctx }/assets/js/user/allUsers.js"></script> --%>
	<script type="text/javascript">
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery','laypage'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			laypage = layui.laypage,
			$ = layui.jquery;
			var g_rootPath="${ctx }";

		//加载页面数据
		var usersData = '';
		$.get("${ctx }/user/getlist", function(data){
			usersData = data;
			//执行加载数据的方法
			usersList();
		})

		//查询
		$(".search_btn").click(function(){
			var userArray = [];
			if($(".search_input").val() != ''){
				var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
	            setTimeout(function(){
	            	$.ajax({
						url :"${ctx }/user/getlist",
						type : "get",
						dataType : "json",
						success : function(data){
							usersData = data;
							for(var i=0;i<usersData.length;i++){
								var usersStr = usersData[i];
								var selectStr = $(".search_input").val();
			            		function changeStr(data){
			            			var dataStr = '';
			            			var showNum = data.split(eval("/"+selectStr+"/ig")).length - 1;
			            			if(showNum > 1){
										for (var j=0;j<showNum;j++) {
			            					dataStr += data.split(eval("/"+selectStr+"/ig"))[j] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>";
			            				}
			            				dataStr += data.split(eval("/"+selectStr+"/ig"))[showNum];
			            				return dataStr;
			            			}else{
			            				dataStr = data.split(eval("/"+selectStr+"/ig"))[0] + "<i style='color:#03c339;font-weight:bold;'>" + selectStr + "</i>" + data.split(eval("/"+selectStr+"/ig"))[1];
			            				return dataStr;
			            			}
			            		}
			            		//用户名
			            		if(usersStr.loginName.indexOf(selectStr) > -1){
				            		usersStr["loginName"] = changeStr(usersStr.loginName);
			            		}
			            		//用户邮箱
			            		if(usersStr.email.indexOf(selectStr) > -1){
				            		usersStr["email"] = changeStr(usersStr.email);
			            		}
			            		//性别
			            		if(usersStr.gender.indexOf(selectStr) > -1){
				            		usersStr["gender"] = changeStr(usersStr.gender);
			            		}
			            		if(usersStr.loginName.indexOf(selectStr)>-1 || usersStr.email.indexOf(selectStr)>-1 || usersStr.gender.indexOf(selectStr)>-1){
			            			userArray.push(usersStr);
			            		}
			            	}
			            	usersData = userArray;
			            	usersList(usersData);
						}
					})
	            	
	                layer.close(index);
	            },2000);
			}else{
				layer.msg("请输入需要查询的内容");
			}
		})

		//添加会员
		$(".usersAdd_btn").click(function(){
			var index = layui.layer.open({
				title : "添加会员",
				type : 2,
				content : "${ctx}/user/addUser",
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回会员列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})
			//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
			$(window).resize(function(){
				layui.layer.full(index);
			})
			layui.layer.full(index);
		})

		//批量删除
		$(".batchDel").click(function(){
			var $checkbox = $('.users_list tbody input[type="checkbox"][name="checked"]');
			var $checked = $('.users_list tbody input[type="checkbox"][name="checked"]:checked');
			if($checkbox.is(":checked")){
				layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){
					var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
		            setTimeout(function(){
		            	//删除数据
		            	// 获取所有被选中项的id列表
		            	var ids="";
		            	//循环遍历备选项
		            	for(var i=0;i<$checked.length;i++){
							ids +=$checked.eq(i).parents("tr").find(".users_del").attr("data-id")+",";
		            	}
		            	// 截取多余字符
		            	ids = ids.substr(0, ids.length - 1);
		            	//发送到服务器
		            	$.post("${ctx}/user/deletes?ids="+ids);
		            	$('.users_list thead input[type="checkbox"]').prop("checked",false);
		            	form.render();
		                layer.close(index);
						layer.msg("删除成功");
						parent.location.reload();
		            },2000);
		        })
			}else{
				layer.msg("请选择需要删除的文章");
			}
		})

	    //全选
		form.on('checkbox(allChoose)', function(data){
			var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
			child.each(function(index, item){
				item.checked = data.elem.checked;
			});
			form.render('checkbox');
		});

		//通过判断文章是否全部选中来确定全选按钮是否选中
		form.on("checkbox(choose)",function(data){
			var child = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"])');
			var childChecked = $(data.elem).parents('table').find('tbody input[type="checkbox"]:not([name="show"]):checked')
			if(childChecked.length == child.length){
				$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = true;
			}else{
				$(data.elem).parents('table').find('thead input#allChoose').get(0).checked = false;
			}
			form.render('checkbox');
		})

		//操作
		$("body").on("click",".users_edit",function(){  //编辑
			//编辑
			var $this = $(this);
			var id=$this.attr("data-id");
			var index = layui.layer.open({
				title : "编辑",
				type : 2,
				content : "${ctx}/user/edit?id="+id,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回列表', '.layui-layer-setwin .layui-layer-close', {
							tips: 3
						});
					},500)
				}
			})	
			$(window).resize(function(){
				layui.layer.full(index);
			})
			layui.layer.full(index);
		})
		//是否展示
		form.on('switch(isShow)', function(data){
			var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
			  var $this=$(this);
		       //获取当前表单id
		       var id=$this.attr("data-id");
			setTimeout(function(){
				//判断是否选中
				var status='';
	        	if($this.is(":checked")){
	        		status=1;
	        		//console.log(1)
	        		//console.log(id)
	        	}else{
	        		status=0;
	        		//console.log(0)
	        		//console.log(id)
	        	}
	        	$.post("${ctx}/user/changeStatus",{
	        		id:id,
	        		status:status
	        	})
	            layer.close(index);
				layer.msg("修改成功！");
	        },2000);
		})

		$("body").on("click",".users_del",function(){  //删除
			var _this = $(this);
			layer.confirm('确定删除此用户？',{icon:3, title:'提示信息'},function(index){
					var id=_this.attr("data-id");
					$.post("${ctx}/user/delete",{id:parseInt(id)})
					setTimeout(function(){
						layer.msg("删除成功")
						parent.location.reload();
						},500)
					layer.close(index);
			});
		})

		function usersList(){
			//渲染数据
			function renderDate(data,curr){
				var dataHtml = '';
				currData = usersData.concat().splice(curr*nums-nums, nums);
				if(currData.length != 0){
					for(var i=0;i<currData.length;i++){
						dataHtml += '<tr>'
				    	+  '<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose"></td>'
				    	+  '<td>'+currData[i].loginName+'</td>'
				    	+  '<td>'+currData[i].email+'</td>'
				    	+  '<td>'+currData[i].gender+'</td>';
				    	if(currData[i].status==1){
				    		dataHtml+= '<td><input type="checkbox" name="show" lay-skin="switch" lay-text="正常|限制" lay-filter="isShow" data-id="'+currData[i].id+'" checked></td>';
				    	}else{
				    		dataHtml+= '<td><input type="checkbox" name="show" lay-skin="switch" lay-text="正常|限制" lay-filter="isShow" data-id="'+currData[i].id+'"></td>'
				    	}
				    	dataHtml += '<td>'+currData[i].updateTime+'</td>'
				    	+  '<td>'
						+    '<a class="layui-btn layui-btn-mini users_edit" data-id="'+currData[i].id+'"><i class="iconfont icon-edit"></i> 编辑</a>'
						+    '<a class="layui-btn layui-btn-danger layui-btn-mini users_del" data-id="'+currData[i].id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
				        +  '</td>'
				    	+'</tr>';
					}
				}else{
					dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
				}
			    return dataHtml;
			}
			//分页
			var nums = 10; //每页出现的数据量
			laypage({
				cont : "page",
				pages : Math.ceil(usersData.length/nums),
				jump : function(obj){
					$(".users_content").html(renderDate(usersData,obj.curr));
					$('.users_list thead input[type="checkbox"]').prop("checked",false);
			    	form.render();
				}
			})
		}
	        
	})
	
	</script>
</body>
</html>