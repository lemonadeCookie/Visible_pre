import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


public class FinallyServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		resp.setContentType("text/html;charset=UTF-8");
		// 此处修改cars.csv的内容
		@SuppressWarnings("deprecation")
		String strFilePath = req.getRealPath("/") + "cars.csv";
		File file = new File(strFilePath);
		if(file.exists()) {
			// 读取JSP中选中的列的值
			String[] checkBox = req.getParameterValues("checkBox");
			int index = checkBox.length;
			// 存储为数组
			String[][] data = new String[index][];
			for(int i = 0; i < index; ++i) {
				data[i] = req.getParameterValues("hidden" + checkBox[i]);
			}
			// 写入文件
			BufferedWriter writer = new BufferedWriter(new FileWriter(file, false));
			for(int i = 0; i < 172; ++i) {
				for(int j = 0; j < index; ++j) {
					if(j != index - 1)
						writer.write(data[j][i] + ",");
					else
						writer.write(data[j][i]);
				}
				if(i != 229)
					writer.newLine();
			}
			writer.flush();
			writer.close();
		}
		RequestDispatcher rd = req.getRequestDispatcher("finally.jsp");
		rd.forward(req, resp);
	}

}
