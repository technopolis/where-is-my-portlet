<%@ page contentType="text/html; charset=UTF-8" isELIgnored="false" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/portlet_2_0" prefix="portlet" %>
<%@ taglib uri="http://alloy.liferay.com/tld/aui" prefix="aui" %>
<%@ taglib uri="http://liferay.com/tld/portlet" prefix="liferay-portlet" %>
<%@ taglib uri="http://liferay.com/tld/security" prefix="liferay-security" %>
<%@ taglib uri="http://liferay.com/tld/theme" prefix="liferay-theme" %>
<%@ taglib uri="http://liferay.com/tld/ui" prefix="liferay-ui" %>
<%@ taglib uri="http://liferay.com/tld/util" prefix="liferay-util" %>

<%@ page import="com.liferay.portal.kernel.portlet.LiferayWindowState"%>
<%@ page import="com.liferay.portal.util.PortletKeys"%>
<%@ page import="com.liferay.portal.service.PortletPreferencesLocalServiceUtil"%>
<%@ page import="com.liferay.portal.service.PortletLocalServiceUtil"%>
<%@ page import="com.liferay.portal.kernel.exception.SystemException"%>
<%@ page import="com.liferay.portal.kernel.exception.PortalException"%>
<%@ page import="com.liferay.portal.util.PortalUtil"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@ page import="com.liferay.portal.model.Group"%>
<%@ page import="com.liferay.portal.model.Layout"%>
<%@ page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@ page import="com.liferay.portal.service.LayoutLocalServiceUtil"%>
<%@ page import="com.liferay.portal.kernel.util.GetterUtil"%>
<%@ page import="com.liferay.portal.kernel.util.HtmlUtil" %>
<%@ page import="com.liferay.portal.kernel.util.ParamUtil" %>
<%@ page import="com.liferay.portal.kernel.util.CalendarFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.dao.search.SearchEntry" %>
<%@ page import="com.liferay.portal.kernel.dao.search.ResultRow" %>
<%@ page import="com.liferay.portal.kernel.exception.SystemException" %>
<%@ page import="com.liferay.portal.kernel.util.WebKeys" %>
<%@ page import="com.liferay.portal.security.permission.ActionKeys" %>
<%@ page import="com.liferay.portal.kernel.util.ListUtil" %>
<%@ page import="com.liferay.portal.service.permission.PortalPermissionUtil" %>
<%@ page import="com.liferay.portal.service.permission.PortletPermissionUtil" %>
<%@ page import="com.liferay.portlet.journal.service.JournalArticleLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.journal.service.JournalArticleResourceLocalServiceUtil"%>
<%@ page import="com.liferay.portal.service.GroupServiceUtil"%>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.service.LayoutLocalServiceUtil" %>
<%@ page import="com.liferay.portal.model.Layout" %>
<%@ page import="com.liferay.portal.util.PortalUtil" %>
<%@ page import="com.liferay.portal.kernel.servlet.BrowserSnifferUtil" %>
<%@ page import="com.liferay.portal.theme.PortletDisplay" %>
<%@ page import="com.liferay.portal.model.Group" %>
<%@ page import="com.liferay.portal.model.GroupConstants" %>
<%@ page import="com.liferay.portal.service.GroupLocalServiceUtil" %>
<%@ page import="com.liferay.portal.service.UserLocalServiceUtil" %>
<%@ page import="com.liferay.portlet.PortletPreferencesFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.util.Validator" %>
<%@ page import="com.liferay.portal.kernel.dao.orm.QueryUtil"%>
<%@ page import="com.liferay.portal.theme.PortletDisplay"%>
<%@ page import="com.liferay.portal.theme.ThemeDisplay"%>
<%@ page import="com.liferay.portal.kernel.util.WebKeys"%>
<%@ page import="com.liferay.portal.kernel.util.StringUtil"%>
<%@ page import="com.liferay.portal.model.LayoutTemplate"%>
<%@ page import="com.liferay.portal.model.LayoutTypePortlet"%>
<%@ page import="com.liferay.portal.model.Portlet"%>
<%@ page import="com.liferay.portal.kernel.dao.orm.QueryUtil"%>
<%@ page import="com.liferay.portlet.PortletURLFactoryUtil" %>
<%@ page import="com.liferay.portal.kernel.portlet.LiferayPortletURL"%>

<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Map.Entry" %>
<%@ page import="java.util.Locale" %>
<%@ page import="java.util.Collections" %>
<%@ page import="java.util.Enumeration" %>

<%@ page import="javax.portlet.PortletRequest"%>
<%@ page import="javax.portlet.WindowState" %>
<%@ page import="javax.portlet.PortletMode" %>
<%@ page import="javax.portlet.PortletPreferences" %>
<%@ page import="javax.portlet.PortletURL" %>
<%@ page import="javax.portlet.PortletSession" %>

<%@ page import="gr.open.admin.helpers.WhereIsMyPortletUtil"%>

<portlet:defineObjects />
<liferay-theme:defineObjects />
