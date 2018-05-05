package com.gsh.ssmsrd.controller;
import java.util.HashMap;
import java.util.Map;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import javax.servlet.http.HttpSession;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gsh.ssmsrd.model.Log;
import com.gsh.ssmsrd.service.LogService;
import com.gsh.ssmsrd.service.UserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@SuppressWarnings("ALL")
@Controller
@RequestMapping("sys")
public class SystemControl {
	private UserService userService;
	private LogService logService;



	/**
	 * 导出Execel文件
	 * @param theadname
	 * @param tablename
	 * @param output
	 */
	
	
//	@RequestMapping("/outExcel.do")
//	public void outExcel(String theadname,String tablename,OutputStream output) {
//		HSSFWorkbook wb = new HSSFWorkbook();
//		//生成表
//		HSSFSheet sheet1 = wb.createSheet("sheet1");
//		//根据表名生成要导出的数据 list
//		HSSFRow row = sheet1.createRow((short) 0);		//创建表的第一行，index=0
//		String th[]=theadname.split(",");
//		for(int i=0;i<th.length;i++){
//			row.createCell((short) i).setCellValue(th[i]);
//		}
//		List<User> list=this.userService.find("from"+" "+tablename);
//		for(int i=0;i<list.size();i++){
//			User user=(User)list.get(i);
//			/*test*/
//			/*Field[] fields = user.getClass().getDeclaredFields();
//			String name="";
//			Object value=null;
//			for (Field f : fields) {
//				 f.setAccessible(true);
//				 if(!f.getType().toString().endsWith("Set")){
//					name = f.getName();
//					value = f.get(user);
//				 }
//				if (null!=value &&!("").equals(value)) {
//					if(name.endsWith("name")){
//
//					 }
//					else
//					 }
//
//			}
//			/*test*/
//			row = sheet1.createRow((short) i+1);		//创建表的第一行，index=0
//			row.createCell((short) 0).setCellValue(user.getUsernum());		//第一行第一列...
//			row.createCell((short) 1).setCellValue(user.getUsername());		//第一行第一列...
//			row.createCell((short) 2).setCellValue("*****");		//创建第二列并赋值.....
//			row.createCell((short) 3).setCellValue(user.getAge());		//。。。。
//			row.createCell((short) 4).setCellValue(user.getSex());
//			//row.createCell((short) 5).setCellValue(user.getCity().getProvince().getName()+"  "+user.getCity().getName());
//			row.createCell((short) 5).setCellValue("test");
//			row.createCell((short) 6).setCellValue(user.getBirthday());
//			row.createCell((short) 7).setCellValue(user.getStarttime());
//			row.createCell((short) 8).setCellValue(user.getEndtime());
//			row.createCell((short) 9).setCellValue(user.getSalary());
//			row.createCell((short) 10).setCellValue(user.getDescription());
//		}
//
//		//自适应列宽
//		for(int i=0;i<th.length;i++){
//			sheet1.autoSizeColumn((short)i);
//		}
//		// FileOutputStream fileout=new FileOutputStream("workbook.xls");
//		try {
//			output.flush();
//			wb.write(output);
//			output.close();
//		} catch (IOException e) {
//			e.printStackTrace();
//		}
//	}
//
	
	/**
	 * 导入exel文件。工具类 ：workbook
	 * @param filePath
	 * @return
	 * @throws Exception
	 */
//	@RequestMapping("/inExcel.do")
//	public void inExcel(@RequestParam(required=false)MultipartFile file) throws Exception{
//		InputStream is= file.getInputStream();
//		jxl.Workbook book=jxl.Workbook.getWorkbook(is);
//		Sheet sheet=book.getSheet(0);
//		int rows=sheet.getSize();
//					for(int i=1;i<rows;i++){
//					Cell[] cells=sheet.getRow(i);
//					String usernum=cells[0].getContents();
//					String username=cells[1].getContents();
//					String password=cells[2].getContents();
//					int age=Integer.parseInt(cells[3].getContents());
//					String sex=cells[4].getContents();
//					int city=Integer.parseInt(cells[5].getContents());
//					String birthday=cells[6].getContents();
//					String starttime=cells[7].getContents();
//					String endtime=cells[8].getContents();
//					String salary=cells[9].getContents();
//					String description=cells[10].getContents();
//					City c=new City();
//					c.setId(city);
//					User user=new User(c, usernum, username, password, sex, age, birthday, salary, starttime, endtime, description);
//					this.userService.save(user);
//					}
//	}
	/**
	  * 数据库备份
	  * @param :备份的文件储存的路径
	  * @return
	  */
	@RequestMapping("/backup.do")
	@ResponseBody
	 public static Map backup() {
		Map map=new HashMap();
	  try {
	   Runtime rt = Runtime.getRuntime();
	   // 调用 调用mysql的安装目录的命令
	   Process child = rt.exec(" C://Program Files//MySQL//MySQL Server 5.0//bin//mysqldump -h localhost -uroot -p123  jxxkhotel");
	   // 设置导出编码为utf-8。这里必须是utf-8
	   // 把进程执行中的控制台输出信息写入.sql文件，即生成了备份文件。注：如果不对控制台信息进行读出，则会导致进程堵塞无法运行
	   InputStream in = child.getInputStream();// 控制台的输出信息作为输入流

	   InputStreamReader xx = new InputStreamReader(in, "utf-8");
	   // 设置输出流编码为utf-8。这里必须是utf-8，否则从流中读入的是乱码

	   String inStr;
	   StringBuffer sb = new StringBuffer("");
	   String outStr;
	   // 组合控制台输出信息字符串
	   BufferedReader br = new BufferedReader(xx);
	   while ((inStr = br.readLine()) != null) {
	    sb.append(inStr + "\r\n");
	   }
	   outStr = sb.toString();

	   // 要用来做导入用的sql目标文件：
	   FileOutputStream fout = new FileOutputStream("d:/jxxkhotel.sql");
	   OutputStreamWriter writer = new OutputStreamWriter(fout, "utf-8");
	   writer.write(outStr);
	   writer.flush();
	   in.close();
	   xx.close();
	   br.close();
	   writer.close();
	   fout.close();
	  } catch (Exception e) {
	   e.printStackTrace();
	  }
	  map.put("status", "ok");
	  return map ;
	 }

	 /**
	  * 数据库还原的信息，输出到控制台
	  * @return null
	  * <p style="color:red;">必须要是mysql的bin目录的全路径</p>
	  */
	 public static void load() {
	  try {
	   String fPath = "d:/jxxkhotel.sql";
	   Runtime rt = Runtime.getRuntime();
	   // 调用 mysql 安装目录的命令
	   Process child = rt.exec("C://Program Files//MySQL//MySQL Server 5.0//bin//mysql -u root -p 123 jxxkhotel");
	   OutputStream out = child.getOutputStream();// 控制台的输入信息作为输出流
	   String inStr;
	   StringBuffer sb = new StringBuffer("");
	   String outStr;
	   BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fPath), "utf-8"));
	   while ((inStr = br.readLine()) != null) {
	    sb.append(inStr + "\r\n");
	   }
	   outStr = sb.toString();
	   OutputStreamWriter writer = new OutputStreamWriter(out, "utf-8");
	   writer.write(outStr);
	   writer.flush();
	   out.close();
	   br.close();
	   writer.close();
	  } catch (Exception e) {
	   e.printStackTrace();
	  }

	 }
	 /**
	  * 数据库还原
	  * @param ：sql文件的路径
	  * <p style="color:red;">必须要是mysql的bin目录的全路径</p>
	  * @return null
	  */
	 @RequestMapping("/load.do")
	 public static void load1() {      
	        try {      
	            String fPath = "d:/jxxkhotel.sql";    
	            Runtime rt = Runtime.getRuntime();      
	            // 调用 mysql 的 cmd:      
	            Process child = rt.exec("C://Program Files//MySQL//MySQL Server 5.0//bin//mysql.exe -uroot -p123 jxxkhotel ");      
	            OutputStream out = child.getOutputStream();//控制台的输入信息作为输出流      
	            String inStr;      
	            StringBuffer sb = new StringBuffer("");      
	            String outStr;      
	            BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fPath), "utf8"));      
	            while ((inStr = br.readLine()) != null) {      
	                sb.append(inStr + "\r\n");      
	            }      
	            outStr = sb.toString();      
	            OutputStreamWriter writer = new OutputStreamWriter(out, "utf8");      
	            writer.write(outStr);      
	            // 注：这里如果用缓冲方式写入文件的话，会导致中文乱码，用flush()方法则可以避免      
	            writer.flush();      
	            // 别忘记关闭输入输出流      
	            out.close();      
	            br.close();      
	            writer.close();      
	        } catch (Exception e) {      
	            e.printStackTrace();      
	        }      
	     
	    }

	/**
	  * 操作日志
	  * @param log：日志实体
	  * @return null
	  */
	@RequestMapping("/getloglist.do")
	@ResponseBody
		public Map<String, Object> getlist(Log log, HttpSession session) throws Exception{
			Map<String, Object> map=new HashMap<String, Object>();
			EntityWrapper<Log> ew=new EntityWrapper<>();
			ew.setEntity(log);
			map.put("total", logService.selectList(ew));
			return map;
		}
	 
}
