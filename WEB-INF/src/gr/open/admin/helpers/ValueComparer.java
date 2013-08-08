package gr.open.admin.helpers;

import java.util.Comparator;
import java.util.Map;


public class ValueComparer implements Comparator<String> {
	private Map<String, String> _data = null;

	public ValueComparer(Map<String, String> data) {

		super();
		_data = data;
	}

	public int compare(String o1, String o2) {

		String e1 = (String) _data.get(o1);
		String e2 = (String) _data.get(o2);
		return e1.compareTo(e2);
	}
}
