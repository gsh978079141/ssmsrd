package com.gsh.ssmsrd.util;
import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.HttpException;
import org.apache.commons.httpclient.NameValuePair;
import org.apache.commons.httpclient.methods.PostMethod;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import java.io.IOException;


/**
    * @Title: SmsUtil
    * @Package com.gsh.ssmsrd.util
    * @Description: 通过短信接口发送短信
    * @author gsh
    * @date 2018/7/10 16:00
    */
@SuppressWarnings("ALL")
public class SmsUtil {


	/*public static void main(String [] args) {
		sendSms2("15206123630","您的验证码是：1111。请不要把验证码泄露给其他人。");
		//sendSmsAll(List<PageData> list)
		//sendSms1();
	}*/







	/**
	 *
	 * 短信商 http://www.ihuyi.com/ =====================================================================================
	 *
	 */
	private static String Url = "http://106.ihuyi.com/webservice/sms.php?method=Submit";



	/**
	 * 给一个人发送单条短信
	 * @param mobile 手机号
	 * @param code  短信内容
	 */
	public static void sendSms2(String mobile,String code){
		HttpClient client = new HttpClient();
		PostMethod method = new PostMethod(Url);
		client.getParams().setContentCharset("UTF-8");
		method.setRequestHeader("ContentType","application/x-www-form-urlencoded;charset=UTF-8");
	    String content = new String(code);
	    String account = "cf_978079141", password = "wddgsh1314.";
//	    String strSMS2 = Tools.readTxtFile("config/SMS2.txt");			//读取短信2配置
//		if(null != strSMS2 && !"".equals(strSMS2)){
//			String strS2[] = strSMS2.split(",gsh,");
//			if(strS2.length == 2){
//				account = strS2[0];
//				password = strS2[1];
//			}
//		}

		NameValuePair[] data = {//提交短信
		    new NameValuePair("account", account),
				//密码可以使用明文密码或使用32位MD5加密
		    new NameValuePair("password", password),
		    new NameValuePair("mobile", mobile),
		    new NameValuePair("content", content),
		};
		method.setRequestBody(data);
		try {
			client.executeMethod(method);

			String submitResult =method.getResponseBodyAsString();

			Document doc = DocumentHelper.parseText(submitResult);
			Element root = doc.getRootElement();


			code = root.elementText("code");
			String msg = root.elementText("msg");
			String smsid = root.elementText("smsid");


			System.out.println(code);
			System.out.println(msg);
			System.out.println(smsid);

			if(code == "2"){
				System.out.println("短信提交成功");
			}

		} catch (HttpException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (DocumentException e) {
			e.printStackTrace();
		}

	}

	/**
	 * 给多个人发送单条短信
	 * @param list 手机号验证码
	 */
	/*public static void sendSmsAll(List<PageData> list){
		String code;
		String mobile;
		for(int i=0;i<list.size();i++){
			code=list.get(i).get("code").toString();
			mobile=list.get(i).get("mobile").toString();
			sendSms2(mobile,code);
		}
	}*/
	// =================================================================================================



}

