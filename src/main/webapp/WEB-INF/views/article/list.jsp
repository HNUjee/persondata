<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/commons/taglibs.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>文章列表</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="${ctx }/assets/layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="//at.alicdn.com/t/font_tnyc012u2rlwstt9.css" media="all" />
	<link rel="stylesheet" href="${ctx }/assets/css/news.css" media="all" />
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
			<a class="layui-btn layui-btn-normal newsAdd_btn">添加文章</a>
		</div>
		<div class="layui-inline">
			<a class="layui-btn layui-btn-danger batchDel">批量删除</a>
		</div>
		
	</blockquote>
	<div class="layui-form news_list">
	  	<table class="layui-table">
		    <colgroup>
				<col width="50">
				<col>
				<col width="9%">
				<col width="9%">
				<col width="9%">
				<col width="10%">
				<col width="20%">
		    </colgroup>
		    <thead>
				<tr>
					<th><input type="checkbox" name="" lay-skin="primary" lay-filter="allChoose" id="allChoose"></th>
					<th style="text-align:left;">文章标题</th>
					<th>发布人</th>
					<th>浏览权限</th>
					<th>类型</th>
					<th>发布时间</th>
					<th>操作</th>
				</tr> 
		    </thead>
		    <tbody class="news_content"></tbody>
		</table>
	</div>
	<div id="page"></div>
	<script type="text/javascript" src="${ctx }/assets/layui/layui.js"></script>
	<script type="text/javascript">
	layui.config({
		base : "assets/js/"
	}).use(['form','layer','jquery','laypage'],function(){
		var form = layui.form(),
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			laypage = layui.laypage,
			$ = layui.jquery;
		var g_rootPath = "${ctx}";
		//加载页面数据
		var newsData = '';
		$.get(g_rootPath+"/article/getArticle", function(data){
			var newArray = [];
			   //正常加载信息
				newsData = data;
			   console.log(data)
				//执行加载数据的方法
				newsList();
		})

		//查询
		$(".search_btn").click(function(){
			var newArray = [];
			if($(".search_input").val() != ''){
				var index = layer.msg('查询中，请稍候',{icon: 16,time:false,shade:0.8});
	            setTimeout(function(){
	            	$.ajax({
						url : "${ctx}/article/getArticle",
						type : "get",
						dataType : "json",
						success : function(data){
								newsData = data;
							for(var i=0;i<newsData.length;i++){
								var newsStr = newsData[i];
								var selectStr = $(".search_input").val();
								console.log(newsStr.title)
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
								
			            		//文章标题
			            		if(newsStr.title.indexOf(selectStr) > -1){
				            		newsStr["title"] = changeStr(newsStr.title);
			            		}
			            		//发布人
			            		if(newsStr.author.indexOf(selectStr) > -1){
				            		newsStr["author"] = changeStr(newsStr.author);
			            		}
			            		
			            		//浏览权限
			            		if(newsStr.look.indexOf(selectStr) > -1){
				            		newsStr["look"] = changeStr(newsStr.look);
			            		}
			            		if(newsStr.type.indexOf(selectStr) > -1){
				            		newsStr["type"] = changeStr(newsStr.type);
			            		}
			            		//发布时间
			            		if(newsStr.createTime.indexOf(selectStr) > -1){
				            		newsStr["createTime"] = changeStr(newsStr.createTime);
			            		}
			            		if(newsStr.title.indexOf(selectStr)>-1 || newsStr.author.indexOf(selectStr)>-1 || newsStr.look.indexOf(selectStr)>-1 || newsStr.type.indexOf(selectStr)>-1 || newsStr.createTime.indexOf(selectStr)>-1){
			            			newArray.push(newsStr);
			            		}
			            	}
			            	newsData = newArray;
			            	newsList(newsData);
						}
					})
	            	
	                layer.close(index);
	            },2000);
			}else{
				layer.msg("请输入需要查询的内容");
			}
		})
		//添加文章
		//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
		$(window).one("resize",function(){
			$(".newsAdd_btn").click(function(){
				var index = layui.layer.open({
					title : "添加文章",
					type : 2,
					content : "${ctx}/article/add",
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})			
				layui.layer.full(index);
			})
		}).resize();



		//批量删除
		$(".batchDel").click(function(){
			var $checkbox = $('.news_list tbody input[type="checkbox"][name="checked"]');
			var $checked = $('.news_list tbody input[type="checkbox"][name="checked"]:checked');
			if($checkbox.is(":checked")){
				layer.confirm('确定删除选中的信息？',{icon:3, title:'提示信息'},function(index){
					var index = layer.msg('删除中，请稍候',{icon: 16,time:false,shade:0.8});
		            setTimeout(function(){
		            	// 获取所有被选中项的id列表
		            	var ids="";
		            	//循环遍历备选项
		            	for(var i=0;i<$checked.length;i++){
							ids +=$checked.eq(i).parents("tr").find(".news_del").attr("data-id")+",";
		            	}
		            	// 截取多余字符
		            	ids = ids.substr(0, ids.length - 1);
		            	//发送到服务器
		            	$.post("${ctx}/article/deletes?ids="+ids);
		            	$('.news_list thead input[type="checkbox"]').prop("checked",false);
		            	form.render();
		            	//刷新页面
						window.location.reload();
		                layer.close(index);
						layer.msg("删除成功");
					
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
		$("body").on("click",".news_edit",function(){ 
			//编辑
			var $this = $(this);
			var id=$this.attr("data-id");
			var index = layui.layer.open({
				title : "编辑文章",
				type : 2,
				content :"${ctx}/article/edit?id="+id,
				success : function(layero, index){
					setTimeout(function(){
						layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
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

		
		 //删除
		$("body").on("click",".news_del",function(){ 
			var $this = $(this);
			layer.confirm('确定删除此信息？',{icon:3, title:'提示信息'},function(index){
				var id=$this.attr("data-id");
				$.ajax({
					url:"${ctx}/article/delete",
					type : "post",
					dataType : "json",
					data:{id:id},
					success : function(data){
						
					}
				})
				//刷新页面
				window.location.reload();
				layer.close(index);
			});
		});
		
		//查看
			$("body").on("click",".news_show",function(){ 
				var $this = $(this);
				var id=$this.attr("data-id");
				var index = layui.layer.open({
					title : "查看文章",
					type : 2,
					content : "${ctx}/article/show?id="+id,
					success : function(layero, index){
						setTimeout(function(){
							layui.layer.tips('点击此处返回文章列表', '.layui-layer-setwin .layui-layer-close', {
								tips: 3
							});
						},500)
					}
				})		
				$(window).resize(function(){
					layui.layer.full(index);
				});
				layui.layer.full(index);
			});
			//是否展示
			form.on('switch(isShow)', function(data){
				var index = layer.msg('修改中，请稍候',{icon: 16,time:false,shade:0.8});
		       var $this=$(this);
		       //获取当前表单id
		       var id=$this.attr("data-id");
				setTimeout(function(){
					//判断是否选中
					var islook='';
		        	if($this.is(":checked")){
		        		islook=1;
		        		//console.log(1)
		        		//console.log(id)
		        	}else{
		        		islook=0;
		        		//console.log(0)
		        		//console.log(id)
		        	}
		        	$.post("${ctx}/article/change",{
		        		id:id,
		        		islook:islook
		        	})
		            layer.close(index);
					layer.msg("修改成功！");
		        },2000);
			})
		
		function newsList(that){
			//渲染数据
			function renderDate(data,curr){
				var dataHtml = '';
				
				if(!that){
					currData = newsData.concat().splice(curr*nums-nums, nums);
				}else{
					currData = that.concat().splice(curr*nums-nums, nums);
				}
				if(currData.length != 0){
					for(var i=0;i<currData.length;i++){
						dataHtml += '<tr>'
				    	+'<td><input type="checkbox" name="checked" lay-skin="primary" lay-filter="choose"></td>'
				    	+'<td align="left">'+currData[i].title+'</td>'
				    	+'<td>'+currData[i].author+'</td>';
				    	if(currData[i].look==1){
				    		dataHtml+= '<td><input type="checkbox" name="show" lay-skin="switch" lay-text="开放|限制" lay-filter="isShow" data-id="'+currData[i].id+'" checked></td>';
				    	}else{
				    		dataHtml+= '<td><input type="checkbox" name="show" lay-skin="switch" lay-text="开放|限制" lay-filter="isShow" data-id="'+currData[i].id+'"></td>';
				    	}
				    	dataHtml+='<td>'+currData[i].articletype.typeName+'</td>'
				    	+'<td>'+currData[i].createTime+'</td>'
				    	+'<td>'
						+  '<a class="layui-btn layui-btn-mini news_edit" data-id="'+currData[i].id+'"><i class="iconfont icon-edit"></i>编辑</a>'
						+  '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="'+currData[i].id+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
						+  '<a class="layui-btn layui-btn-normal layui-btn-mini news_show" data-id="'+currData[i].id+'"><i class="layui-icon">&#xe615;</i> 查看</a>'
						+'</td>'
				    	+'</tr>';
				    	
					}
				}else{
					dataHtml = '<tr><td colspan="8">暂无数据</td></tr>';
				}
			    return dataHtml;
			}

			//分页
			var nums = 5; //每页出现的数据量
			if(that){
				newsData = that;
			}
			
			laypage({
				cont : "page",
				pages : Math.ceil(newsData.length/nums),
				skin:'#1E9FFF',
				groups: 5,
				skip: true,
				first: '首页',
				last: '尾页',
				prev: '上一页',
			    next: '下一页', 
				jump : function(obj){
					$(".news_content").html(renderDate(newsData,obj.curr));
					$('.news_list thead input[type="checkbox"]').prop("checked",false);
			    	form.render();
				}
			})
		}
	})
	
	</script>
</body>
</html>