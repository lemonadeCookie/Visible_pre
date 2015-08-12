<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>进击的可视化小组</title>
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<style type="text/css">
		table.gridtable {
			font-family: verdana,arial,sans-serif;
			font-size:11px;
			color:#333333;
			border-width: 1px;
			border-color: #666666;
			border-collapse: collapse;
		}
		table.gridtable th {
			border-width: 1px;
			padding: 8px;
			border-style: solid;
			border-color: #666666;
			background-color: #dedede;
		}
		table.gridtable td {
			border-width: 1px;
			padding: 8px;
			border-style: solid;
			border-color: #666666;
			background-color: #ffffff;
		}
		#mainCanvas{
      		width:100%;
      		height:100%;
        }
	 </style>
  </head>
  <% String path2 = request.getRealPath("/");
     File fp = new File(path2, "data2.csv");
     String str= null;
     String country[] = new String[230];
     String data[][] = new String[230][52];
     for(int x = 0; x < 230; ++x) {
     	for(int y = 0; y < 52; ++y) {
     		data[x][y] = "0";
     	}
     }
     int count = 0;
     if(fp.exists()) {
     	InputStream input = new FileInputStream(fp);
     	BufferedReader reader = new BufferedReader(new InputStreamReader(input));
     	String s = new String();
     	do {
     		s = reader.readLine();
     		if(count > 0 && s != null) {
     			if(s.indexOf(",") >= 0) {
     				country[count - 1] = s.substring(0, s.indexOf(","));
     				s = s.substring(s.indexOf(",") + 1, s.length());
     			}
     			int temp = 0;
     			while(s.indexOf(",") >= 0) {
     				data[count - 1][temp] = s.substring(0, s.indexOf(","));
     				s = s.substring(s.indexOf(",") + 1, s.length());
     				++temp;
     			}
     			data[count - 1][temp] = s;
     		}
     		++count;
     	} while(s != null);
     }
  %>
  <body>
     <h1>数据原型为50*230数据，维度为50</h1>
  	 <table class="gridtable" id="displayTable">
  	   <tr>
  	     <td>国家\年份</td>
  	   	 <%for(int x = 0; x <= 50; ++x) { %>
  	   	 <td><%=2010 - x %></td>
  	   	 <%} %>
  	   </tr>
  	   <%for(int i = 0; i < 172; ++i) { %>
  	   <tr>
  	     <td>
  	         <%=country[i] %>
  	     </td>
  	     <%for(int j = 0; j <= 50; ++j) { %>
  	     <td><%=data[i][j] %>
  	     </td>
  	     <%} %>
  	   </tr>
  	   <%} %>
  	 </table>
  	 <br>
  	 <form action="finally" method="post">
  	 <table class="gridtable" id="myTable">
  	   <tr>
  	     <td>年份</td>
  	   	 <td>选择</td>
  	   	 <%for(int k = 0; k < 172; ++k) {%>
  	   	 <td><%=country[k] %></td>
  	   	 <% }%>
  	   </tr>
  	   <%for(int i = 0; i < 51; ++i) {%>
  	   <tr>
	     <td><%=2010 - i %><input type="hidden" name="hidden<%=i %>" value="<%=2010 - i %>" /></td>
	     <td><input type="checkBox" id="cb<%=i %>" name="checkBox" value="<%=i %>"></td>
	     <%for(int j = 0; j < 172; ++j) {%>
	     	<td><%=data[j][i] %>
	     		<input type="hidden" name="hidden<%=i %>" value="<%=data[j][i] %>" />
	     	</td>
	     <%} %>  	     
  	   </tr>
  	   <%} %> 
  	 </table>
  	 </br>   
     <button type="button" id="zero">降维处理=>GO</button><br><br>
     <button type="button" id="one">两列散点图=>GO</button><br><br>
     <button type="submit" id="two">两列及以上数据处理=>GO</button>
     </form>
     <div id="mainCanvas">
     </div>
     <script src="js/jquery.min.js"></script>
     <script src="js/excanvas.min.js"></script>
     <script src="js/onePage.js"></script>
     <script src="js/jquery.flot.min.js"></script>
  </body>
</html>
