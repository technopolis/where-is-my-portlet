package gr.open.admin.helpers;


public interface Constants {

	public static final String TAB_PORTLETS 					= "portlets";
	public static final String TAB_LAYOUTS 						= "layouts";
	
	public static final String ATTRIBUTE_ACTION 				= "actions";
	public static final String ATTRIBUTE_TAB 					= "tab";
	public static final String ATTRIBUTE_PORTLET_LAYOUTS 		= "portletLayouts";
	public static final String ATTRIBUTE_ALL_LAYOUTS 			= "allLayouts";
	public static final String ATTRIBUTE_PORTLET_LAYOUTS_SIZE 	= "portletLayoutsSize";
	public static final String ATTRIBUTE_SEARCH_DONE 			= "searchDone";
	public static final String ATTRIBUTE_SELECTED_PORTLET 		= "selectedPortlet";
	public static final String ATTRIBUTE_SELECTED_LAYOUT 		= "selectedLayout";
	public static final String ATTRIBUTE_SELECTED_PAGES_SCOPE 	= "selectedPrivate";
	public static final String ATTRIBUTE_PORTLET_NAMES 			= "portletNames";
	
	public static final String PREFERENCE_IGNORE_SCOPE_GROUP_ID = "ignoreScopeGroupIdFlag";
	
	public static final int ACTION_PAGE_SCOPE_PORTLETS 			= 1;
	public static final int ACTION_PAGE_SCOPE_LAYOUTS 			= 2;
	
	public static final boolean VALUE_PUBLIC 					= false;
	public static final boolean VALUE_PRIVATE 					= true;
	
	public static final String JSON_PORTLET_NAME 				= "portletName";
	public static final String JSON_PORTLET_DISPLAY_NAME 		= "portletDisplayName";
}
