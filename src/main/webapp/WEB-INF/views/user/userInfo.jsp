<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>个人资料</title>
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="${ctx }/assets/css/user.css" media="all" />
</head>
<body class="childrenBody">
	<form class="layui-form" action="">
		<input type="hidden" name="id" class="id" value="1">
		<div class="user_left">
			<div class="layui-form-item">
			    <label class="layui-form-label">用户名</label>
			    <div class="layui-input-block">
			    	<input type="text" name="name" value="admin" disabled class="layui-input layui-disabled name">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">用户组</label>
			    <div class="layui-input-block">
			    	<input type="text" name="userGrade" value="超级管理员" disabled class="layui-input layui-disabled userGrade">
			    </div>
			</div>
			<div class="layui-form-item" pane="">
			    <label class="layui-form-label">性别</label>
			    <div class="layui-input-block userSex">
			    	<input type="radio" name="gender" value="男" title="男" checked="">
	     			<input type="radio" name="gender" value="女" title="女">
	     			<input type="radio" name="gender" value="保密" title="保密">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">手机号码</label>
			    <div class="layui-input-block">
			    	<input type="tel" name="mobile" value="${sys.mobile }" placeholder="请输入手机号码" lay-verify="required|phone" class="layui-input userPhone">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">出生年月</label>
			    <div class="layui-input-block">
			    	<input type="text" name="birthday" value="${sys.birthday }" placeholder="请输入出生年月" lay-verify="required|date" onclick="layui.laydate({elem: this,max: laydate.now()})" class="layui-input userBirthday">
			    </div>
			</div>
			<div class="layui-form-item userAddress">
			    <label class="layui-form-label">家庭住址</label>
			    <div class="layui-input-inline">
	                <select name="province" lay-filter="province">
	                    <option value="${sys.province }">${sys.province }</option>
	                </select>
	            </div>
	            <div class="layui-input-inline">
	                <select name="city" lay-filter="city" disabled>
	                    <option value="${sys.city }">${sys.city }</option>
	                </select>
	            </div>
	            <div class="layui-input-inline">
	                <select name="area" lay-filter="area" disabled>
	                    <option value="${sys.area }">${sys.area }</option>
	                </select>
	            </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">邮箱</label>
			    <div class="layui-input-block">
			    	<input type="text"name="email" value="${sys.email }" placeholder="请输入邮箱" lay-verify="required|email" class="layui-input userEmail">
			    </div>
			</div>
			<div class="layui-form-item">
			    <label class="layui-form-label">自我评价</label>
			    <div class="layui-input-block">
			    	<textarea placeholder="请输入内容" name="myself" class="layui-textarea myself">${sys.myself }</textarea>
			    </div>
			</div>
		</div>
		<div class="user_right">
			<input type="file" name="file" class="layui-upload-file" lay-title="点击更换头像">
			<img src="${ctx }/${sys.userFace }" class="layui-circle" id="userFace">
		</div>
		<div class="layui-form-item" style="margin-left: 5%;">
		    <div class="layui-input-block">
		    	<button class="layui-btn" lay-submit="" lay-filter="changeUser">立即提交</button>
				<button type="reset" class="layui-btn layui-btn-primary">重置</button>
		    </div>
		</div>
	</form>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript" src="${ctx }/assets/js/user/address.js"></script>
	<script>
	var areaData = address;
	var $form;
	var form;
	var $;
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','upload','laydate'],function(){
		form = layui.form();
		var layer = parent.layer === undefined ? layui.layer : parent.layer;
			$ = layui.jquery;
			$form = $('form');
			laydate = layui.laydate;
	        loadProvince(); //加载省信息

	        var g_rootPath = "${pageContext.request.contextPath}";
	    layui.upload({
	    	url : g_rootPath+"/sysuser/uploadFace",
	    	success: function(res){
	    		 layer.msg(res.msg);
	    		var src=g_rootPath+"/"+res.data.src;
	    		$("img").attr("src",src);
		    }
	    });
	    //提交个人资料
	    form.on("submit(changeUser)",function(data){
	      		var  userInfo= {
	      		'id':$(".id").val(),
	      		'name':$(".name").val(),
	      		'userGrade':$(".userGrade").val(),
	            'gender' : data.field.gender,
	            'mobile' : $(".userPhone").val(),
	            'birthday' : $(".userBirthday").val(),
	            'province' : data.field.province,
	            'city' : data.field.city,
	            'area' : data.field.area,
	            'email' : $(".userEmail").val(),
	            'myself' : $(".myself").val()
	        };
	        $.ajax({
	 			url : g_rootPath+"/sysuser/save",
	 			data : JSON.stringify(userInfo),
	 			type:'POST',//默认以get提交，以get提交如果是中文后台会出现乱码
	 			contentType:'application/json;charset=utf-8',
	 			dataType : 'json',
	 			success : function(obj) {
	 			}
	 		});
	    	var index = layer.msg('提交中，请稍候',{icon: 16,time:false,shade:0.8});
	        setTimeout(function(){
	            layer.close(index);
	            layer.msg("提交成功！");
	        },2000);
	    	return false; //阻止表单跳转。如果需要表单跳转，去掉这段即可。
	    })
	})

	//加载省数据
	function loadProvince() {
	    var proHtml = '';
	    for (var i = 0; i < areaData.length; i++) {
	        proHtml += '<option value="' + areaData[i].provinceName +'">' + areaData[i].provinceName + '</option>';
	    }
	    //初始化省数据
	    $form.find('select[name=province]').append(proHtml);
	    form.render();
	    form.on('select(province)', function(data) {
	        $form.find('select[name=area]').html('<option value="">请选择县/区</option>');
	        var index =$('select[name=province]').get(0).selectedIndex;
	        if (index > 0) {
	            loadCity(areaData[index-1].mallCityList);
	        } else {
	            $form.find('select[name=city]').attr("disabled","disabled");
	        }
	    });
	}
	//加载市数据
	function loadCity(citys) {
	    var cityHtml = '<option value="">请选择市</option>';
	    for (var i = 0; i < citys.length; i++) {
	        cityHtml += '<option value="' + citys[i].cityName + '">' + citys[i].cityName + '</option>';
	    }
	    $form.find('select[name=city]').html(cityHtml).removeAttr("disabled");
	    form.render();
	    form.on('select(city)', function(data) {
	        var index =$('select[name=city]').get(0).selectedIndex;
	        if (index > 0) {
	            loadArea(citys[index-1].mallAreaList);
	        } else {
	            $form.find('select[name=area]').attr("disabled","disabled");
	        }
	    });
	}
	//加载县/区数据
	function loadArea(areas) {
	    var areaHtml = '<option value="">请选择县/区</option>';
	    for (var i = 0; i < areas.length; i++) {
	        areaHtml += '<option value="' + areas[i].areaName + '">' + areas[i].areaName + '</option>';
	    }
	    $form.find('select[name=area]').html(areaHtml).removeAttr("disabled");
	    form.render();
	    form.on('select(area)', function(data) {});
	}
	</script>
</body>
</html>