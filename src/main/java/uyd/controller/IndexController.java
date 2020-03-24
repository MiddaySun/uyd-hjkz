package uyd.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月12日
 * @version 1.0
 * @description 跳转作用的Controller
 */
@Controller
@RequestMapping("/index")
public class IndexController {

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月12日
	 * @version 1.0
	 * @description 前往系统登陆界面
	 */
	@RequestMapping("/goLogin")
	public String goLogin() {
		return "pages/login/login";
	}
}
