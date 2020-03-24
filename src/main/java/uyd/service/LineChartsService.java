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

	List<WsdData> loadWsdData(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午3:45:51
	 * @version 1.0
	 * @description 查询分页数据总数量
	 */
	Integer getCount(Map<String, Object> map);

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午5:03:45
	 * @version 1.0
	 * @param map
	 * @return
	 * @description 查询创建折线图
	 */
	List<WsdData> createWsdLineCharts(Map<String, Object> map);

}
