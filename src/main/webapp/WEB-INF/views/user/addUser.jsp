<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>会员添加</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<style type="text/css">
		.layui-form-item .layui-inline{ width:33.333%; float:left; margin-right:0; }
		@media(max-width:1240px){
			.layui-form-item .layui-inline{ width:100%; float:none; }
		}
	</style>
</head>
<body class="childrenBody">
	<form class="layui-form" style="width:80%;" method="post" action="${ctx }/user/save">
		<input type="hidden" value="${user.id }">
		<div class="layui-form-item">
			<label class="layui-form-label">登录名</label>
			<div class="layui-input-block">
				<input type="text" value="${user.loginName }" class="layui-input loginName" name="loginName" lay-verify="required" placeholder="请输入登录名">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">邮箱</label>
			<div class="layui-input-block">
				<input type="text"  value="${user.email}" class="layui-input userEmail" name="email" lay-verify="email" placeholder="请输入邮箱">
			</div>
		</div>
		<div class="layui-form-item">
			<label class="layui-form-label">密码</label>
			<div class="layui-input-block">
				<input type="text" value="${user.password }" class="layui-input password" name="password" lay-verify="password" placeholder="请输入密码">
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
			    <label class="layui-form-label">性别</label>
			    <div class="layui-input-block userSex">
			      	<input type="radio" name="gender" value="男" title="男" checked>
			      	<input type="radio" name="gender" value="女" title="女">
			    </div>
		    </div>
		 </div>    
		<div class="layui-form-item">	    
		    <div class="layui-inline">
			    <label class="layui-form-label">会员状态</label>
				<div class="layui-input-block">
					<select name="status" class="status" lay-filter="userStatus">
						<option value="0">正常使用</option>
						<option value="1">限制用户</option>
				    </select>
				</div>
		    </div>
		</div>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn save_btn" lay-submit="" lay-filter="addUser">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<%-- <script type="text/javascript" src="${ctx }/assets/js/user/addUser.js"></script> --%>
	<script>
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			$ = layui.jquery;
			var g_rootPath="${ctx }";
		
	    //登录按钮
	 form.on("submit(addUser)",function(data){
		 $.ajax({
	 			url : g_rootPath+"/user/save",
	 			data :JSON.stringify(data.field),
	 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
	 			contentType:'application/json;charset=utf-8',
	 			dataType : 'json',
	 			success : function(obj) {
	 			}
	 		});
			var index = top.layer.msg('数据提交中，请稍候',{icon: 16,time:false,shade:0.8});
	       	 setTimeout(function(){
	       		top.layer.close(index);
	 			top.layer.msg("添加成功！");
	  			layer.closeAll("iframe");
	 	 		//刷新父页面
	 	 		parent.location.reload();
	        },2000);
	        return false;
	  }) 
	})
	</script>
</body>
</html>