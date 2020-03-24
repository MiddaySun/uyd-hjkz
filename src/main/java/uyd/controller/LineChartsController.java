package uyd.controller;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import uyd.entity.PageBean;
import uyd.entity.WsdData;
import uyd.service.LineChartsService;
import uyd.utils.DateJsonValueProcessor;
import uyd.utils.DateUtil;
import uyd.utils.ResponseUtil;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月19日,下午2:35:00
 * @version 1.0
 * @description
 */
@Controller
@RequestMapping("/charts")
public class LineChartsController {

	@Autowired
	private LineChartsService lineChartsService;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月20日,上午15:25:56
	 * @version 1.0
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws Exception
	 * @description 分页查询温湿度数据
	 */
	@RequestMapping("/loadWsdData")
	@ResponseBody()
	public String getColumnChart(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "startDatetime", required = false) String startDatetime,
			@RequestParam(value = "page", required = false) String page, @RequestParam(value = "rows", required = false) String rows,
			@RequestParam(value = "endDatetime", required = false) String endDatetime) throws Exception {

		PageBean pageBean = new PageBean(Integer.parseInt(page), Integer.parseInt(rows));
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("page", pageBean.getPage());
		map.put("start", pageBean.getStart());
		map.put("pageSize", pageBean.getPageSize());

		if (startDatetime == null && endDatetime == null) {
			Calendar calen = Calendar.getInstance();// 可以对每个时间域单独修改
			calen.setTime(new Date());
			calen.set(Calendar.HOUR_OF_DAY, calen.get(Calendar.HOUR_OF_DAY) - 4);
			startDatetime = DateUtil.formatDate(calen.getTime(), "yyyy-MM-dd HH:mm:ss");
			calen.add(Calendar.DATE, 1);
			endDatetime = DateUtil.formatDate(calen.getTime(), "yyyy-MM-dd HH:mm:ss");
		}
		map.put("startDatetime", startDatetime);
		map.put("endDatetime", endDatetime);
		// 获取总记录数
		int total = lineChartsService.getCount(map);
		// 获取分页集合
		List<WsdData> wsdList = lineChartsService.loadWsdData(map);
		/**
		 * 如果集合里面含有时间类型的数据，可以通过以下方式格式化Date类型
		 */
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.setExcludes(new String[] { "orderList" });
		jsonConfig.registerJsonValueProcessor(java.sql.Timestamp.class, new DateJsonValueProcessor("yyyy-MM-dd HH:mm:ss"));
		JSONArray rows1 = JSONArray.fromObject(wsdList, jsonConfig);

		JSONObject result = new JSONObject();
		result.put("total", total);
		result.put("rows", rows1);
		ResponseUtil.write(response, result);
		return null;
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午4:00:18
	 * @version 1.0
	 * @param request
	 * @param response
	 * @param startDatetime
	 * @param endDatetime
	 * @return
	 * @throws Exception
	 * @description 生成折线图表
	 */
	@RequestMapping("/createLineCharts")
	@ResponseBody()
	public String createLineCharts(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "startDatetime", required = false) String startDatetime,
			@RequestParam(value = "endDatetime", required = false) String endDatetime) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		if (startDatetime == null && endDatetime == null) {
			Calendar calen = Calendar.getInstance();// 可以对每个时间域单独修改
			calen.setTime(new Date());
			calen.set(Calendar.HOUR_OF_DAY, calen.get(Calendar.HOUR_OF_DAY) - 4);
			startDatetime = DateUtil.formatDate(calen.getTime(), "yyyy-MM-dd HH:mm:ss");
			calen.add(Calendar.DATE, 1);
			endDatetime = DateUtil.formatDate(calen.getTime(), "yyyy-MM-dd HH:mm:ss");
		}
		map.put("startDatetime", startDatetime);
		map.put("endDatetime", endDatetime);
		List<WsdData> wsdList = lineChartsService.createWsdLineCharts(map);

		String json = JSON.toJSONString(wsdList);// 将list中的对象转换为Json格 式的数组
		return json;
	}
}
