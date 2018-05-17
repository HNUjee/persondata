<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>后台管理</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8" />
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form layui-form-pane" action="${ctx }/contact/save" method="post" enctype="multipart/form-data">
		<input type="hidden" class="layui-input id" name="id"  value=${contact.id }>
		<%-- <div class="layui-form-item">
		<div style="position: absolute;left:400px;border: 1px solid #ccc;">
			<img id="upload" src="${ctx }/assets/images/upload1.jpg" style="width:245px;height:245px;">
			  <div class="upbar" style="position: absolute;bottom: 0px">
			    	<input type="file"  name="file" class="layui-upload-file" id="test" title="上传图片" style="width:245px;height:245px">
			  </div>
		</div>
		</div> --%>
		<div class="layui-form-item">
		<div class="layui-inline">
			<label class="layui-form-label">姓名</label>
			<div class="layui-input-block">
				<input type="text" class="layui-input name" name="name" lay-verify="required|name" placeholder="请输入姓名" value=${contact.name }>
			</div>
		</div>
		</div>
		<div class="layui-inline">
			<label class="layui-form-label">性别</label>
			<div class="layui-input-inline">
				<input type="radio" name="Gender" value="男" title="男" checked>
      			<input type="radio" name="Gender" value="女" title="女" >
			</div>
		</div>
	
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">邮箱</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input email" name="email" placeholder="请输入邮箱" value=${contact.email }>
				</div>
			</div>
		</div>                                                                      
		<div class="layui-form-item">
			<div class="layui-inline">		
				<label class="layui-form-label">职位</label>
				<div class="layui-input-inline">
					<input type="text" class="layui-input position" name="position" lay-verify="required" placeholder="请输入职位" value=${contact.position }>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">电话</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input mobile" name="mobile" placeholder="请输入电话" value=${contact.mobile }>
				</div>
			</div>
		</div>
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">地址</label>
				<div class="layui-input-block">
					<input type="text" class="layui-input address" name="address" placeholder="请输入地址" value=${contact.address }>
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">分类</label>
				<div class="layui-input-block">
					<select name="category.id" class="category">
					<c:forEach var="cate" items="${category }" varStatus="status">
						 <option value="${cate.id}">${cate.name}</option>
					</c:forEach>
				    </select>
				</div>
			</div>
		</div>
		</form>
		<div class="layui-form-item">
			<div class="layui-input-block">
				<button class="layui-btn addNews" lay-submit="" lay-filter="addNews">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-2.1.3.min.js"></script>
	<script type="text/javascript" src="${ctx }/assets/jquery-form/jquery.form.min.js"></script>
	<script type="text/javascript">
	layui.use(['form', 'layer','upload'], function(){
		  var layer = layui.layer,
		  	  upload = layui.upload,
		  	   form = layui.form();
		  form.render();
		  
	 $("form").on("submit", function(e) {
		 // 阻止表单默认提交事件
			e.preventDefault();
			var $this = $(this);
			// jquery-form的异步提交方式
			$this.ajaxSubmit({
				beforeSubmit : function(data, $form) {
					var name = $form.find("input[name='name']");
					if ($.trim(name.val()) === "") {
						 layer.tips('请输入名字', '.name');
						return false; 
					}
					var email = $form.find("input[name='email']");
					if ($.trim(email.val()) === "") {
						 layer.tips('请输入邮箱', '.email');
						return false; 
					}
					var position = $form.find("input[name='position']");
					if ($.trim(position.val()) === "") {
						 layer.tips('请输入职位', '.position');
						return false; 
					}
					var mobile = $form.find("input[name='mobile']");
					if ($.trim(mobile.val()) === "") {
						 layer.tips('请输入电话', '.mobile');
						return false; 
					}
					var address = $form.find("input[name='address']");
					if ($.trim(address.val()) === "") {
						 layer.tips('请输入地址', '.address');
						return false; 
					}
					/* var file = $form.find("input[name='file']");
					if ($.trim(file.val()) === "") {
						 layer.msg('请选择头像');
						return false; 
					} */
				},
				success : function() {
					$("form").find(".addNews").attr("disabled",true); 
					 layer.alert('添加成功',{icon: 1}); 
					 setTimeout(function(){
						parent.location.reload();
					 },2000);
				}
			});
		});
	// 保存用户
	 $(".childrenBody").find(".addNews").on("click", function() {
		$(".childrenBody").find("form").trigger("submit");
	});

	$("#test").change(function(){  
		  // getObjectURL是自定义的函数，见下面  
		  // this.files[0]代表的是选择的文件资源的第一个，因为上面写了 multiple="multiple" 就表示上传文件可能不止一个  
		  // ，但是这里只读取第一个   
		  var objUrl = getObjectURL(this.files[0]);  
		  if (objUrl) {  
		    // 在这里修改图片的地址属性  
		    $("#upload").attr("src", objUrl) ;  
		  }  
		}) ;  
	
		//建立一個可存取到該file的url  
		function getObjectURL(file) {  
		  var url = null ;   
		  // 下面函数执行的效果是一样的，只是需要针对不同的浏览器执行不同的 js 函数而已  
		  if (window.createObjectURL!=undefined) { // basic  
		    url = window.createObjectURL(file) ;  
		  } else if (window.URL!=undefined) { // mozilla(firefox)  
		    url = window.URL.createObjectURL(file) ;  
		  } else if (window.webkitURL!=undefined) { // webkit or chrome  
		    url = window.webkitURL.createObjectURL(file) ;  
		  }  
		  return url;  
		}  
});   
	</script>
</body>
</html>