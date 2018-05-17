<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>修改密码</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/assets/css/user.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form changePwd">
		<input type="hidden" name="id" value="1" class="id">
		<div style="margin:0 0 15px 110px;color:#f00;">新密码必须两次输入一致才能提交</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">用户名</label>
		    <div class="layui-input-block">
		    	<input type="text" value="admin" disabled class="layui-input layui-disabled">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">旧密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" placeholder="请输入旧密码" lay-verify="required|oldPwd" class="layui-input">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">新密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" placeholder="请输入新密码" lay-verify="required|newPwd" id="oldPwd" class="layui-input">
		    </div>
		</div>
		<div class="layui-form-item">
		    <label class="layui-form-label">确认密码</label>
		    <div class="layui-input-block">
		    	<input type="password" value="" name="password" placeholder="请确认密码" lay-verify="required|confirmPwd" class="layui-input pwd">
		    </div>
		</div>
		<div class="layui-form-item">
		    <div class="layui-input-block">
		    	<button class="layui-btn" lay-submit="" lay-filter="changePwd">立即修改</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${ctx }/assets/MD5.js"></script>
	<script>
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			$ = layui.jquery;
		  var g_rootPath = "${pageContext.request.contextPath}";
		//添加验证规则
	    form.verify({
	        oldPwd : function(value, item){
	            if($.md5(value) != "${pwd.password }"){
	                return "密码错误，请重新输入！";
	            }
	        },
	        newPwd : function(value, item){
	            if(value.length < 6){
	                return "密码长度不能小于6位";
	            }
	        },
	        confirmPwd : function(value, item){
	            if(!new RegExp($("#oldPwd").val()).test(value)){
	                return "两次输入密码不一致，请重新输入！";
	            }
	        }
	    })
		
	 	form.on("submit(changePwd)",function(data){
	 		var password=$.md5($(".pwd").val());
	 		var str={"id":$(".id").val(),
	 				"password":password,
				}
	 		 $.ajax({
	 			url : g_rootPath+'/sysuser/updatePwd',
	 			data : JSON.stringify(str),
	 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
	 			contentType:'application/json;charset=utf-8',
	 			dataType : 'json',
	 			success : function(obj) {
	 				
	 			}
	 		});
	 		//弹出loading
	 		var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	        setTimeout(function(){
	            top.layer.close(index);
				top.layer.msg("添加成功！");
	 			layer.closeAll("iframe");
		 		//刷新父页面
		 		//parent.location.reload();
	        },2000);
	 		return false;
	 	})
	})
	</script>
</body>
</html>