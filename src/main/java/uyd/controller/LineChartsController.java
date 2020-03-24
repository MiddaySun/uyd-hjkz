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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;

import uyd.entity.WsdData;
import uyd.service.LineChartsService;

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
	 * @description 生成折线图表
	 */
	@RequestMapping("/lineCharts")
	@ResponseBody()
	public String getColumnChart(HttpServletRequest request, HttpServletResponse response, @RequestParam(value = "startDatetime", required = false) String startDatetime,
			@RequestParam(value = "endDatetime", required = false) String endDatetime) throws Exception {

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("startDate", "2020-3-19");
		map.put("endDate", "2020-3-20");
		map.put("startTime", "10:12:00");
		map.put("endTime", "10:30:00.000");
		List<WsdData> wsdData = lineChartsService.createWsdLineCharts(map);
		String json = JSON.toJSONString(wsdData);// 将list中的对象转换为Json格 式的数组
		return json;

	}
}
