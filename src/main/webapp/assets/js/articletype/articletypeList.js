layui.config({
	base : "assets/js/"
}).use(['form','layer','jquery','laypage'],function(){
	var form = layui.form(),
		layer = parent.layer === undefined ? layui.layer : parent.layer,
		laypage = layui.laypage,
		$ = layui.jquery;

	//加载页面数据
	var newsData = '';
	$.get("articletypelist", function(data){
		var newArray = [];
		//单击首页“待审核文章”加载的信息
		if($(".top_tab li.layui-this cite",parent.document).text() == "待审核文章"){
			if(window.sessionStorage.getItem("addNews")){
				var addNews = window.sessionStorage.getItem("addNews");
				newsData = JSON.parse(addNews).concat(data);
			}else{
				newsData = data;
			}
        	newsData = newArray;
        	newsList(newsData);
		}else{    //正常加载信息
			newsData = data;
			if(window.sessionStorage.getItem("addNews")){
				var addNews = window.sessionStorage.getItem("addNews");
				newsData = JSON.parse(addNews).concat(newsData);
			}
			//执行加载数据的方法
			newsList();
		}
	})
	//添加文章
	//改变窗口大小时，重置弹窗的高度，防止超出可视区域（如F12调出debug的操作）
	$(window).one("resize",function(){
		$(".newsAdd_btn").click(function(){
			var index = layui.layer.open({
				title : "添加文章",
				type : 2,
				content : "articletypeadd",
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
	            	$.get("articleTypeDeletes?ids="+ids);
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
		var typeId=$this.attr("data-id");
		var index = layui.layer.open({
			title : "编辑文章",
			type : 2,
			content : "articletypeedit?typeId="+typeId,
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
		//window.location.href="add?id="+id;
	})

	
	 //删除
	$("body").on("click",".news_del",function(){ 
		var $this = $(this);
		layer.confirm('确定删除此信息？',{icon:3, title:'提示信息'},function(index){
			var id=$this.attr("data-id");
			$.ajax({
				url:"articletypedelete",
				type : "get",
				dataType : "json",
				data:{typeId:id},
				success : function(data){
					
				}
			})
			//刷新页面
			window.location.reload();
			layer.close(index);
		});
	});
	
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
			    	+'<td align="left">'+currData[i].typeName+'</td>'
			    	+'<td>'+currData[i].createTime+'</td>'
			    	+'<td>'
					+  '<a class="layui-btn layui-btn-mini news_edit" data-id="'+currData[i].typeId+'"><i class="iconfont icon-edit"></i>编辑</a>'
					+  '<a class="layui-btn layui-btn-danger layui-btn-mini news_del" data-id="'+currData[i].typeId+'"><i class="layui-icon">&#xe640;</i> 删除</a>'
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
