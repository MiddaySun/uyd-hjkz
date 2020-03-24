package uyd.service.imp;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import uyd.dao.WsdDataDao;
import uyd.entity.WsdData;
import uyd.service.LineChartsService;

/**
 * @author CC , Asa4CC@126.com
 * @time 2020年3月20日,下午5:49:56
 * @version 1.0
 * @description
 */
@Service
public class LineChartsServiceImp implements LineChartsService {

	@Resource
	private WsdDataDao wsdDataDao;

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月20日,下午5:50:15
	 * @version 1.0
	 * @return
	 * @description
	 */
	@Override
	public List<WsdData> loadWsdData(Map<String, Object> map) {
		return wsdDataDao.loadWsdData(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午3:47:06
	 * @version 1.0
	 * @param map
	 * @return
	 * @description
	 */
	@Override
	public Integer getCount(Map<String, Object> map) {
		return wsdDataDao.getCount(map);
	}

	/**
	 * @author CC , Asa4CC@126.com
	 * @time 2020年3月23日,下午5:03:28
	 * @version 1.0
	 * @param map
	 * @return
	 * @description
	 */
	@Override
	public List<WsdData> createWsdLineCharts(Map<String, Object> map) {
		return wsdDataDao.createWsdLineCharts(map);
	}

}
