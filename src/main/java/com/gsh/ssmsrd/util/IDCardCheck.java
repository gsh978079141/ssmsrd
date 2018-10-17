package com.gsh.ssmsrd.util;

import org.apache.http.HttpResponse;
import org.apache.http.util.EntityUtils;

import javax.servlet.http.HttpServlet;
import java.util.HashMap;
import java.util.Map;


/**
 *<p>Title:IDCardCheck</p>
 *<p style="color:red;">Description :身份证校验工具类</p>
 * @Company jxxkhotel
 * @author gsh
 * @date 2017-12-31 下午12:40:52
 */

public class  IDCardCheck extends HttpServlet {
	/**
	 *
	 */
	private static final long serialVersionUID = 1L;
	/**
	 *
	<p style="color:green;">Description :外部接口身份校验</p>
	 * Map<String,String>
	 * @param id 身份证号
	 * @return map类型提示信息
	 */
	public static String checkid(String id) {
	    String host = "http://jisuidcard.market.alicloudapi.com";
	    String path = "/idcard/query";
	    String method = "GET";
	    Map<String, String> headers = new HashMap<String, String>();
	    //最后在header中的格式(中间是英文空格)为Authorization:APPCODE 83359fd73fe94948385f570e3c139105
	    headers.put("Authorization", "APPCODE e958fe82d9514bd28b2d379b7f192a91");
	    Map<String, String> querys = new HashMap<String, String>();
	    querys.put("idcard", id);
	    try {
	    	/**
	    	* 重要提示如下:
	    	* HttpUtils请从
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/src/main/java/com/aliyun/api/gateway/demo/util/HttpUtils.java
	    	* 下载
	    	*
	    	* 相应的依赖请参照
	    	* https://github.com/aliyun/api-gateway-demo-sign-java/blob/master/pom.xml
	    	*/

//	    	HttpResponse response = HttpUtils.doGet(host, path, method, headers, querys);
	    	//System.out.println(response.toString());
	    	//获取response的body
//	    	return EntityUtils.toString(response.getEntity());
	    } catch (Exception e) {
	    	e.printStackTrace();
	    }
    	return "";
	}
}
