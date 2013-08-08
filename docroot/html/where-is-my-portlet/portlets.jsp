<%@page import="gr.open.admin.portlet.views.PortletView"%>
<%@page import="gr.open.admin.helpers.Constants"%>
<%@page import="gr.open.admin.portlet.views.LayoutView"%>
<%@ include file="/html/init.jsp" %>

<%
PortletPreferences prefs = renderRequest.getPreferences();
String popupWidth = prefs.getValue("popupWidth", "400");
String popupHeight = prefs.getValue("popupHeight", "400");
boolean enableFilters = Boolean.parseBoolean( prefs.getValue("enableFilters", "true"));

boolean showBaseUrl = Boolean.parseBoolean(prefs.getValue("showBaseUrl", "false"));		
boolean selectedPrivate = Boolean.parseBoolean( renderRequest.getParameter("selectedPrivate"));

%>
<liferay-portlet:actionURL name="showPortletLayouts" var="showPortletLayoutsURL"/>

<div id="<portlet:namespace/>portletsFormContainer">
	<aui:form method="post" action="<%=showPortletLayoutsURL.toString()%>" name="portletsForm">
		<aui:fieldset>
			<label><liferay-ui:message key="portlets.description"/></label>
		</aui:fieldset>
		
		<aui:fieldset column="true" style="padding-right:30px;">
			<aui:select name="selectedPrivate" label="show-private-pages" id="pageScope" onChange="submitPortletsForm();">
				<aui:option name="Public" value="false" label="Public" selected="${selectedPrivate == false}"/>
				<aui:option name="Private" value="true" label="Private" selected="${selectedPrivate == true}"/>
			</aui:select>
		</aui:fieldset>
		
		<aui:fieldset column="true" >
			<aui:select name="selectedPortlet" label="site-portlets-portlet" onChange="submitPortletsForm();" id="selectedPortlet">
				<c:forEach items="${portletNames}" var="portletName">
					<aui:option selected="${selectedPortlet == portletName.key}" value="${portletName.key}" label="${portletName.value}"/>
				</c:forEach>
			</aui:select>
		</aui:fieldset>
		
		<aui:fieldset column="true">
			<div id="<portlet:namespace/>preloader" style="width:16px;float:left;display:none;"><img src="<%=request.getContextPath()%>/images/preloader.gif"/></div>
		</aui:fieldset>
		
		<div style="clear:both;"></div>
	</aui:form>
</div>

<aui:script>

function submitPortletsForm() {
	enableWait();
	<portlet:namespace/>portletsForm.submit();
}

function enableWait() {
	AUI().use('node', function (A) {
		A.one("#<portlet:namespace/>preloader").attr('display', 'block');
		A.one("#<portlet:namespace/>pageScope").attr('readonly', 'readonly');
		A.one("#<portlet:namespace/>selectedPortlet").attr('readonly', 'readonly');
	});
}

function disableWait() {
	AUI().use('node', function (A) {
		A.one("#<portlet:namespace/>preloader").attr('display', 'none');
		A.one("#<portlet:namespace/>pageScope").attr('readonly', '');
		A.one("#<portlet:namespace/>selectedPortlet").attr('readonly', '');
	});
}


AUI().ready('aui-io-request', function(A) {
	
	function <portlet:namespace/>populatePortlets() {
		enableWait();
		var action = '<portlet:namespace/>json<%=Constants.ATTRIBUTE_ACTION %>';
		var actionValue = '<%= Constants.ACTION_PAGE_SCOPE_PORTLETS %>';
		
		var selectedPortlet = '<portlet:namespace/>json<%= Constants.ATTRIBUTE_SELECTED_PORTLET %>';
		var selectedPortletValue = A.one("#<portlet:namespace/>selectedPortlet").val();
		
		var selectedPrivate = '<portlet:namespace/>json<%= Constants.ATTRIBUTE_SELECTED_PAGES_SCOPE %>';
		var selectedPrivateValue = A.one("#<portlet:namespace/>pageScope").val();
		
		var preSelectedPortlet = '<c:out value="${selectedPortlet}" />';
		
		var url = "<portlet:resourceURL />&" + action + "=" + actionValue +"&" + selectedPrivate + "=" + selectedPrivateValue + "&" + selectedPortlet + "=" + selectedPortletValue;
		console.log("URL: " + url);
		console.log("action:" + action);
		console.log("actionValue:" + actionValue);
		console.log("selectedPortlet:" + selectedPortlet);
		console.log("selectedPortletValue:" + selectedPortletValue);
		console.log("selectedPrivate:" + selectedPrivate);
		console.log("selectedPrivateValue:" + selectedPrivateValue);
		console.log("preSelectedPortlet:" + preSelectedPortlet);
		
		A.io.request(url, {
			method: 'GET',
			dataType: 'json',
			on: {
				failure: function() {},
				success: function(event, id, obj) {
					var portletNamesArray = this.get('responseData');
					A.one("#<portlet:namespace/>selectedPortlet").html("");
					//A.one("#<portlet:namespace/>selectedPortlet").append("<option value='0'>None</option>");
					for (var i = 0; i < portletNamesArray.length; i++) {
						var portletName = portletNamesArray[i];
						A.one("#<portlet:namespace/>selectedPortlet").append("<option " + (preSelectedPortlet == portletName.portletName?"selected='true'":"") + " value='" + portletName.portletName + "'>" + portletName.portletDisplayName + "</option>");
						
					}
					disableWait();
					submitPortletsForm();
				}
			}
		});
	}

	A.one("#<portlet:namespace/>pageScope").on('change', function() {
		<portlet:namespace/>populatePortlets();
	});
});

<c:set var="enableFilters" value="<%= enableFilters %>"></c:set>
<c:if test="${enableFilters}">
AUI().use('get', function(A){     
	A.Get.script('<%=request.getContextPath()%>/js/jquery-1.10.0.min.js', {
		onSuccess: function(){
			A.Get.script('<%=request.getContextPath()%>/js/select2.js', {
			   onSuccess: function(){
			        $(document).ready(function() { $("#<portlet:namespace/>pageScope").select2(); });
			        
			        $(document).ready(function() { $("#<portlet:namespace/>selectedPortlet").select2(); });
			   }
			}); 
		}
	}); 
});
</c:if>

</aui:script>

	<div id="<portlet:namespace/>results">
		<liferay-ui:search-container  emptyResultsMessage="site-portlets-no-portlets-were-found">
			<liferay-ui:search-container-results results="${portletLayouts}" total="${portletLayoutsSize}"/>
			<liferay-ui:search-container-row
					className="gr.open.admin.portlet.views.LayoutView"
					keyProperty="layoutId"
					modelVar="layoutView">
			
				<portlet:actionURL name="showLayoutPortlets" var="showLayoutPortletsFromTableURL">
					<portlet:param name="selectedLayout" value="<%=String.valueOf(layoutView.getLayout().getPlid())%>"/>
					<portlet:param name="selectedPrivate" value="${selectedPrivate}"/>
				</portlet:actionURL>
				
				<%
			
				String goToLayoutLinkIcon = "<a title='List the portlets of this page...' class='tooltip' href='" + showLayoutPortletsFromTableURL + "'><img src='" +
								request.getContextPath() + "/images/application_go.png'/> " + 
								layoutView.getLayout().getName(themeDisplay.getLocale()) + " </a>";
								
				String goToLayoutUrl = WhereIsMyPortletUtil.getLayoutHREF(layoutView.getLayout(), themeDisplay, true, "Go to this portal page...", "tooltip", showBaseUrl, selectedPrivate);
				%>
				
				<liferay-ui:search-container-column-text
					name="site-portlets-layout-id"
						value="<%=String.valueOf(layoutView.getLayout().getLayoutId())%>"
				/>
				
				<liferay-ui:search-container-column-text
					name="site-portlets-layout-explore-layout-portlets"
						value="<%=goToLayoutLinkIcon%>"
				/>
			
				<liferay-ui:search-container-column-text
						name="site-portlets-layout-friendlyUrl"
						value='<%=goToLayoutUrl%>'
				/>		
				
				<liferay-ui:search-container-column-text
							name="site-portlets-layout-portlets">	
					<% 
					for (Portlet layoutPortlet : layoutView.getPortletInstancesForPortletName()) {
						PortletView portletView = new PortletView(layoutPortlet, layoutView.getLayout());
					%>
					<portlet:renderURL var="portletPopUpURL" windowState="<%= LiferayWindowState.EXCLUSIVE.toString() %>">
				   		<portlet:param name="portletId" value="<%=layoutPortlet.getPortletId()%>"/>
				   		<portlet:param name="jspPage" value="/html/where-is-my-portlet/portletPopUp.jsp"/>
				   	</portlet:renderURL>
				   	<div>
					   	<a onClick="javascript:showPortletPopup<%=layoutPortlet.getPortletId()%>('<%= portletPopUpURL %>')" href="#" style="text-decoration: none;">
							<img src='<%=request.getContextPath()%>/images/information.png'/>
						</a>
						<span>
							<%= portletView.getPortletBarName(themeDisplay) %>
						</span>
						<span style="font-style: italic;">
							(<%=layoutPortlet.getPortletId() %>)
						</span>
				   	</div>
					<script type="text/javascript">
						function showPortletPopup<%=layoutPortlet.getPortletId()%>(url) {
						  AUI().use('aui-dialog', 'aui-io', 'event', 'event-custom', function(A) {
						    var dialog = new A.Dialog({
						            title: '<%= portletView.getPortletBarName(themeDisplay) %>',
								   	height:<%=popupHeight%>,
								   	width:<%=popupWidth%>,
						            centered: true,
						            draggable: true,
						            destroyOnClose: true,
						            stack: true,
						            modal: true
						        }).plug(A.Plugin.IO, {uri: url}).render();     
						        dialog.show();     
						  });
						}
					</script>
					<%
					}
					%>
				</liferay-ui:search-container-column-text>		
				
				<liferay-ui:search-container-column-text name="actions">		
					<liferay-ui:icon-menu >
						<liferay-ui:icon image="view_tasks"  message="goToLayoutsTab" url="<%=showLayoutPortletsFromTableURL.toString() %>" />
						<liferay-ui:icon image="view_templates" target="_blank" message="goToLayout" url="<%=layoutView.getLayout().getFriendlyURL()%>" />
					</liferay-ui:icon-menu>
				</liferay-ui:search-container-column-text>
			
			</liferay-ui:search-container-row>
			
			<liferay-ui:search-iterator  paginate="<%=true%>" />
			
		</liferay-ui:search-container>
	</div>
