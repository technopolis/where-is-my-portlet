
<%@ include file="/html/init.jsp" %>
<%
PortletPreferences prefs = renderRequest.getPreferences();
String popupWidth = prefs.getValue("popupWidth", "400");
String popupHeight = prefs.getValue("popupHeight", "400");
boolean enableFilters = Boolean.parseBoolean( prefs.getValue("enableFilters", "true"));

List<Layout> allLayouts = (List<Layout>) renderRequest.getAttribute("allLayouts");
List<Portlet> portlets = (List<Portlet>) renderRequest.getAttribute("portlets");
String selectedLayout = (String) renderRequest.getAttribute("selectedLayout");
boolean selectedPrivate = Boolean.parseBoolean( renderRequest.getParameter("selectedPrivate"));

String yesIcon = request.getContextPath() + "/images/tick.png";
String noIcon = request.getContextPath() + "/images/cross.png";
%>
 <liferay-portlet:actionURL name="showLayoutPortlets" var="showLayoutPortletsURL">
 	<liferay-portlet:param name="tab" value="layouts"/>
 </liferay-portlet:actionURL>
 
 <aui:form method="post" action="<%=showLayoutPortletsURL.toString()%>" name="layoutsForm">
	<aui:fieldset>
		<label><liferay-ui:message key="layouts.description"/></label>
	</aui:fieldset>

 	<aui:fieldset column="true" style="padding-right:30px;">
		<aui:select name="selectedPrivate" label="show-private-pages" onChange="submitLayoutsForm();">
			<aui:option name="Public" value="false" label="Public" selected="${selectedPrivate == false}"/>
			<aui:option name="Private" value="true" label="Private" selected="${selectedPrivate == true}"/>
		</aui:select>
	</aui:fieldset>

	<aui:fieldset column="true" >
		<aui:select name="selectedLayout" label="site-portlets-layout" onChange="submitLayoutsForm();">
			<%
				if (allLayouts!=null) {
					for (Layout l : allLayouts) {
			%>
					<aui:option selected="<%=String.valueOf(l.getPlid()).equals(selectedLayout) ? true : false%>" value="<%=l.getPlid()%>"><%=WhereIsMyPortletUtil.getLayoutHREF(l, themeDisplay, selectedPrivate)%> - <%=l.getName(themeDisplay.getLocale())%></aui:option>
			<%
				}
			}
			 %>
		 </aui:select>
	 </aui:fieldset>

 	<div style="clear:both;"></div>
 	
 </aui:form>
 
<script>
function submitLayoutsForm() {
	<portlet:namespace/>layoutsForm.submit();
}


</script>

<div id="<portlet:namespace/>results">

	<liferay-ui:search-container emptyResultsMessage="site-portlets-no-layouts-were-found">
	<liferay-ui:search-container-results results="<%=portlets %>" total="<%=portlets.size() %>"/>

	<liferay-ui:search-container-row
			className="gr.open.admin.portlet.views.PortletView"
			keyProperty="portletId"
			modelVar="portlet">
		
		<portlet:actionURL name="showPortletLayouts" var="showPortletLayoutsFromTableURL">
			<portlet:param name="selectedPortlet" value="<%= String.valueOf(portlet.getPortlet().getPortletName()) %>"/>
			<portlet:param name="selectedPrivate" value="${selectedPrivate}"/>
		</portlet:actionURL>
		
		<%
		String goToLayoutLinkIcon = "<a title='Find out on which pages this portlet is...' class='tooltip' href='" + showPortletLayoutsFromTableURL + "'><img src='" + request.getContextPath() + "/images/application_go.png'/> " + portlet.getPortlet().getDisplayName() + " </a>";
		String portletNameBar = portlet.getPortletBarName(themeDisplay);
		String iconUrl = WhereIsMyPortletUtil.getIconUrl(portlet.getPortlet());
		%>
		
			<liferay-ui:search-container-column-text name="site-portlets-portlet-id">
				<% if (iconUrl!=null){%>
					<img src="<%= iconUrl %>"/>
				<% }%>
				<portlet:renderURL var="portletPopUpURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
			   		<portlet:param name="portletId" value="<%=portlet.getPortlet().getPortletId()%>"/>
			   		<portlet:param name="layoutPlid" value="<%=Long.toString(portlet.getLayout().getPlid())%>"/>
			   		<portlet:param name="jspPage" value="/html/where-is-my-portlet/portletPopUp.jsp"/>
			   	</portlet:renderURL>
			   	
				<span id="<portlet:namespace/><%= portlet.getPortlet().getInstanceId()%>"><%= portletNameBar %></span>
				<a onClick="javascript:showPortletPopup<%=portlet.getPortletId()%>('<%= portletPopUpURL %>')" href="#" style="text-decoration: none;">
					<img src='<%=request.getContextPath()%>/images/information.png'/>
				</a>
				<br><span style="font-size:8px;"><%= portlet.getPortlet().getPortletId()%></span>
				
				<script type="text/javascript">
				function showPortletPopup<%=portlet.getPortletId()%>(url) {
				  AUI().use('aui-dialog', 'aui-io', 'event', 'event-custom', function(A) {
					  
				  	var dialog = new A.Dialog({
				            title: '<%= portletNameBar %>',
						   	height:<%=popupHeight%>,
						   	width:<%=popupWidth%>,
				            centered: true,
				            draggable: true,
				            destroyOnClose: true,
				            modal: true
				        }).plug(A.Plugin.IO, {uri: url}).render();     
				  	
				  	dialog.show();     
				 
				  });
				}
				</script>
			</liferay-ui:search-container-column-text>
			
			<liferay-ui:search-container-column-text
				name="site-portlets-portlet-display-name"
				value="<%= goToLayoutLinkIcon %>"
			/>	
	
			<liferay-ui:search-container-column-text
				name="site-portlets-portlet-instanciable">	
				<img src="<%= portlet.getPortlet().getInstanceable()?yesIcon:noIcon%>"/>
			</liferay-ui:search-container-column-text>
			
			<liferay-ui:search-container-column-text name="actions">		
				<liferay-ui:icon-menu >
					<liferay-ui:icon image="view_tasks" message="goToPortletsTab" url="<%=showPortletLayoutsFromTableURL.toString() %>" />
				</liferay-ui:icon-menu>
			</liferay-ui:search-container-column-text>
		
		</liferay-ui:search-container-row>
		
		<liferay-ui:search-iterator />
		
	</liferay-ui:search-container>
</div>	
	
<c:set var="enableFilters" value="<%= enableFilters %>"></c:set>
<c:if test="${enableFilters}">
<script>
AUI().use('get', function(A){     
	A.Get.script('<%=request.getContextPath()%>/js/jquery-1.10.0.min.js', {
		onSuccess: function(){
			A.Get.script('<%=request.getContextPath()%>/js/select2.js', {
			   onSuccess: function(){
			        $(document).ready(function() { $("#<portlet:namespace/>selectedPrivate").select2(); });
			        
			        $(document).ready(function() { $("#<portlet:namespace/>selectedLayout").select2(); });
			   }
			}); 
		}
	}); 
});
</script>
</c:if>