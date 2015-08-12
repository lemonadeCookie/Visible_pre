$(document).ready(function() {
	$("#one").click(function() {
		var d1 = new Array();
		var d2 = new Array();
		var flag = 0;
		for(var i = 0; i < 51; ++i) {
			if($("#cb" + i).is(':checked')) {
				flag++;
				if(flag == 1) {
					$("#myTable tr:eq(" + (i + 1) + ")").children().each(function(x) {
						if(x != 0 && x != 1) {
							d1[x] = parseFloat($(this).text());
						}
					})
				} else if(flag == 2) {
					$("#myTable tr:eq(" + (i + 1) + ")").children().each(function(y) {
						if(y != 0 && y != 1) {
							d2[y] = parseFloat($(this).text());
						}
					});
				}
			}
		}
		if(flag == 2) {
			// 整合数组
			var df = [];
			for(var num = 0; num < 179; ++num) {
				df.push([d1[num + 2], d2[num + 2]]);
			}
			var options = {points:{show:true}};
			$.plot($("#mainCanvas"), [df], options);
		} else {
			alert("请选择两列进行二维散点图的生成");
		}
	});
    $("#two").click(function() {
    	var flag = 0;
    	for(var i = 0; i < 51; ++i) {
    		if($("#cb" + i).is(':checked')) {
    			++flag;
    		}
    	}
    	if(flag <= 1) {
    		alert("请选择至少两列数据");
    		return false;
    	}
    });
});
