package uyd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import uyd.entity.PageBean;
import uyd.entity.SysInfo;
import uyd.entity.User;
import uyd.service.SysInfoService;
import uyd.service.UserService;
import uyd.utils.CodeGenerator;
import uyd.utils.DateJsonValueProcessor;
import uyd.utils.ResponseUtil;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月13日
 * @version 1.0
 * @description 用户信息controller
 */

@Controller
@RequestMapping("/user")
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private SysInfoService sysInfoService;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 用户登陆验证
	 */
	@RequestMapping("/login.html")
	public String login(User user, HttpServletRequest request) {
		HttpSession session = request.getSession();
		User currentUser = userService.login(user);
		SysInfo currentSysInfo = sysInfoService.getSysInfo();
		if (currentUser == null) {
			request.setAttribute("errorMsg", "用户名或密码错误");
			request.setAttribute("user", user);
			return "login/login";
		} else {
			session.setAttribute("currentUser", currentUser);

			session.setAttribute("currentSysInfo", currentSysInfo);

			return "redirect:/pages/main/mainTemp.jsp";
		}
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 修改密码
	 */
	@RequestMapping("/modifypwd")
	@Transactional(rollbackFor = { Exception.class })
	public String modifyPassword(@RequestParam(value = "newPassword", required = false) String newPassWord, @RequestParam(value = "userId", required = false) String userId,
			HttpServletResponse response) throws Exception {
		User user = new User();
		user.setUserId(userId);
		user.setPassword(newPassWord);
		int resultNum = userService.updatePwd(user);

		JSONObject result = new JSONObject();
		if (resultNum > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		} else {
			result.put("success", false);
			ResponseUtil.write(response, result);
		}

		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 退出登录
	 */
	@RequestMapping("/exit")
	public String exit(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.removeAttribute("currentUser");

		return "redirect:/pages/main/mainTemp.jsp";
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 根据条件分页查询所有用户信息
	 */
	@RequestMapping("/userlist")

	public String userlist(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "page", required = false) String page,
			@RequestParam(value = "rows", required = false) String rows, @RequestParam(value = "trueName", required = false) String trueName) throws Exception {

		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", pageBean.getPage());
		map.put("start", pageBean.getStart());
		map.put("pageSize", pageBean.getPageSize());
		map.put("trueName", trueName);

		// 获取总记录数
		int total = userService.getCount(map);

		// 获取分页后的集合
		List<User> list = userService.list(map);

		/**
		 * 如果集合里面含有时间类型的数据，可以通过以下方式格式化Date类型
		 */
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "orderList" });
		jsonConfig.registerJsonValueProcessor(java.util.Date.class, new DateJsonValueProcessor("yyyy-MM-dd"));
		JSONArray rows1 = JSONArray.fromObject(list, jsonConfig);

		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("rows", rows1);

		ResponseUtil.write(response, result);

		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 删除用户信息
	 */
	@RequestMapping("/deleteUser")
	@Transactional(rollbackFor = { Exception.class })
	public String deleteUser(HttpSession session, HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "ids", required = false) String ids) throws Exception {

		int resultNum = 0;
		String[] userIds = ids.split(",");
		User currentUser = (User) session.getAttribute("currentUser");
		boolean flag = false;
		for (int i = 0; i < userIds.length; i++) {
			if (userIds[i].equals(currentUser.getUserId())) {
				flag = true;
				break;
			}
		}
		if (!flag) {
			for (int i = 0; i < userIds.length; i++) {
				resultNum = userService.delete(userIds[i]);
			}
		}
		JSONObject result = new JSONObject();
		if (resultNum > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		} else {
			result.put("success", false);
			ResponseUtil.write(response, result);
		}

		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 添加管理员用户信息
	 */
	@RequestMapping("/saveUser")
	@Transactional(rollbackFor = { Exception.class })
	public String saveUser(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password, @RequestParam(value = "gender", required = false) String gender,
			@RequestParam(value = "idCardNo", required = false) String idCardNo, @RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "trueName", required = false) String trueName, @RequestParam(value = "address", required = false) String address,
			@RequestParam(value = "postId", required = false) String postId, @RequestParam(value = "jobNumber", required = false) String jobNumber) throws Exception {
		int resultNum = 0;
		User user = new User();
		user.setIdCardNo(idCardNo);
		user.setPassword(password);
		user.setPhone(phone);
		user.setTrueName(trueName);
		user.setUsername(username);
		user.setAddress(address);
		user.setJobNumber(jobNumber);
		user.setGender(gender);
		user.setPostId(postId);

		int flag = userService.findByUsername(username);
		if (flag <= 0) {
			user.setUserId(CodeGenerator.generateCode("U"));
			if (postId.equals("admin")) {
				user.setPostName("管理员");
			} else {
				user.setPostName("常规用户");
			}

			resultNum = userService.save(user);
		}

		JSONObject result = new JSONObject();
		if (resultNum > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		} else {
			result.put("success", false);
			ResponseUtil.write(response, result);
		}
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 更新管理员用户信息
	 */
	@RequestMapping("/update")
	@Transactional(rollbackFor = { Exception.class })
	public String update(HttpServletRequest request, HttpSession session, HttpServletResponse response, @RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password, @RequestParam(value = "gender", required = false) String gender,
			@RequestParam(value = "idCardNo", required = false) String idCardNo, @RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "trueName", required = false) String trueName, @RequestParam(value = "userId", required = false) String userId,
			@RequestParam(value = "postId", required = false) String postId, @RequestParam(value = "jobNumber", required = false) String jobNumber,
			@RequestParam(value = "address", required = false) String address) throws Exception {

		User user = new User();
		user.setIdCardNo(idCardNo);
		user.setPassword(password);
		user.setPhone(phone);
		user.setTrueName(trueName);
		user.setUsername(username);
		user.setAddress(address);
		user.setJobNumber(jobNumber);
		user.setGender(gender);
		user.setPostId(postId);
		user.setUserId(userId);
		if (postId.equals("admin")) {
			user.setPostName("管理员");
		} else {
			user.setPostName("常规用户");
		}
		int resultNum;
		User currentUser = (User) session.getAttribute("currentUser");
		if (currentUser.getUserId() == user.getUserId() && currentUser.getPostId() != user.getPostId()) {
			resultNum = 0;
		} else {
			resultNum = userService.update(user);
		}
		JSONObject result = new JSONObject();
		if (resultNum > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		} else {
			result.put("success", false);
			ResponseUtil.write(response, result);
		}
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月13日
	 * @version 1.0
	 * @description 修改个人信息，无法修改身份
	 */
	@RequestMapping("/update_personal")
	@Transactional(rollbackFor = { Exception.class })
	public String update_personal(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "username", required = false) String username,
			@RequestParam(value = "password", required = false) String password, @RequestParam(value = "gender", required = false) String gender,
			@RequestParam(value = "idCardNo", required = false) String idCardNo, @RequestParam(value = "phone", required = false) String phone,
			@RequestParam(value = "trueName", required = false) String trueName, @RequestParam(value = "address", required = false) String address,
			@RequestParam(value = "postId", required = false) String postId, @RequestParam(value = "postName", required = false) String postName,
			@RequestParam(value = "userId", required = false) String userId, @RequestParam(value = "jobNumber", required = false) String jobNumber) throws Exception {

		User user = new User();
		user.setIdCardNo(idCardNo);
		user.setPassword(password);
		user.setPhone(phone);
		user.setGender(gender);
		user.setTrueName(trueName);
		user.setUsername(username);
		user.setJobNumber(jobNumber);
		user.setAddress(address);
		user.setPostId(postId);
		user.setPostName(postName);
		user.setUserId(userId);

		int resultNum = userService.update(user);

		User currentUser = userService.findById(userId);
		request.getSession().setAttribute("currentUser", currentUser); // 更新session信息

		JSONObject result = new JSONObject();
		if (resultNum > 0) {
			result.put("success", true);
			ResponseUtil.write(response, result);
		} else {
			result.put("success", false);
			ResponseUtil.write(response, result);
		}
		return null;
	}
}
