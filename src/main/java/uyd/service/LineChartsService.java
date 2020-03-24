package uyd.service;

import java.util.List;
import java.util.Map;

import uyd.entity.WsdData;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月20日,下午5:48:51
 * @version 1.0
 * @description
 */
public interface LineChartsService {

	List<WsdData> createWsdLineCharts(Map<String, Object> map);

}
