package uyd.utils;

import java.util.Date;

import org.apache.commons.lang.time.DateFormatUtils;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月14日
 * @version 1.0
 * @description
 */
public class CodeGenerator {
	public static String generateCode(String initial) {
		StringBuilder code = new StringBuilder(initial);
		StringBuilder year = new StringBuilder(DateFormatUtils.format(new Date(), "yy"));
		code.append(year);
		code.append(DateFormatUtils.format(new Date(), "MMdd"));
		code.append(DateFormatUtils.format(new Date(), "HHmmss"));
		return code.toString();
	}

}
