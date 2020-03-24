package uyd.utils;

import java.math.BigInteger;
import java.util.Random;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月14日
 * @version 1.0
 * @description 字符串工具类
 */
public class StringUtil {

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @param str
	 * @description 判断是空
	 */
	public static boolean isEmpty(String str) {
		if (str == null || "".equals(str.trim())) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @param str
	 * @description 判断不是空
	 */
	public static boolean isNotEmpty(String str) {
		if ((str != null) && !"".equals(str.trim())) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月14日
	 * @version 1.0
	 * @param str
	 * @description 生成唯一的资源标识符
	 */
	public static String getGUID() {
		return new BigInteger(165, new Random()).toString();
	}
}
