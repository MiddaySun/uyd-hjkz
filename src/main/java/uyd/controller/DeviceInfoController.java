package uyd.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import uyd.entity.DeviceInfo;
import uyd.entity.PageBean;
import uyd.service.DeviceInfoService;
import uyd.utils.DateJsonValueProcessor;
import uyd.utils.ResponseUtil;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月24日,下午5:35:27
 * @version 1.0
 * @description
 */
@Controller
@RequestMapping("deviceInfo")
public class DeviceInfoController {

	@Autowired
	private DeviceInfoService deviceInfoService;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月24日,下午5:37:55
	 * @version 1.0
	 * @description
	 */
	@RequestMapping("/findList")
	public void findList(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "devName", required = false) String devName,
			@RequestParam(value = "page", required = false) String page, @RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "devModelNumber", required = false) String devModelNumber) throws Exception {
		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", pageBean.getPage());
		map.put("start", pageBean.getStart());
		map.put("pageSize", pageBean.getPageSize());
		map.put("devName", devName);
		map.put("devModelNumber", devModelNumber);

		// 获取总记录数
		int total = deviceInfoService.getCount(map);
		// 获取分页集合
		List<DeviceInfo> resultList = deviceInfoService.findList(map);
		// 格式化Date类型
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "orderList" });
		jsonConfig.registerJsonValueProcessor(java.sql.Timestamp.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray rows1 = JSONArray.fromObject(resultList, jsonConfig);

		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("rows", rows1);
		ResponseUtil.write(response, result);
	}

}
