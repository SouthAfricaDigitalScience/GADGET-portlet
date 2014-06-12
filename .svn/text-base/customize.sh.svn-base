#!/bin/sh
#
# Script that customizes the myFirst portlet
# just fill properly any environment variable
# accordingly to your application and then run
#
# $ ./customize.sh
# 
# Author: riccardo.bruno@ct.infn.it

# Author' information
# Used to fill-up portlet' licence information
AUTH_EMAIL=riccardo.bruno@ct.infn.it
AUTH_NAME='Riccardo Bruno'
AUTH_INSTITUTE='COMETA'

# Application information
APP_NAME=myFirst
APP_VERSION=

#
# docroot/WEB-INF/portlet.xml tag values
#

# <portlet-name>
PORTLET_NAME=$APP_NAME-portlet

# <title>
PORTLET_TITLE=$APP_NAME-portlet

# <short-title>
PORTLET_SHTITLE=$APP_NAME-portlet

# <keywords>
PORTLET_KEYWORDS="$APP_NAME-portlet"

# <display-name>
DISPLAY_NAME=$APP_NAME-portlet

# <portlet-class>
# Do not use '-' character; it's illegal in java class name (use '_' instead)
BASE_CLASS=it.infn.ct
CLASS_NAME=${APP_NAME}_portlet

#
# Init parameters
#

#init_PortletVersion
# Use this value to specify the portlet version
INI_PVERSION=1.0

#init_logLevel
# The portlet template code uses a customizable log levels: trace, info, debug, error, fatal
# Log outputs having a lower level will be not printed out while the portlet executes
#INI_LOGLEVEL=inf7o

#init_bdiiHost
# specify the information system BDII in the form ldap://<info_provider_hostname>:<info_provide_port>
#INI_BDIIHOST=ldap://bdii.eumedgrid.eu:2170

#init_wmsHost
# The wms host can be obtained from an UI with the gLite command line
# lcg-infosites --vo eumed wms
#
#INI_WMSHOST=wms://wms-4.dir.garr.it:7443/glite_wms_wmproxy_server

#init_pxServerHost
#INI_PXHOST=myproxy.ct.infn.it

#init_pxServerPort
#INI_PXPORT=

#init_pxServerSecure
#INI_PXSECURE=

#init_pxRobotId
#INI_ROBOTID=21057

#init_pxRobotVO
#INI_ROBOTVO=eumed

#init_pxRobotRole
#INI_ROBOROLE=eumed

#init_pxUserProxy
#INI_USERPX=

#init_pxRobotRenewalFlag (true/false)
#INI_RENEWALFLAG=true

#init_sciGwyAppId (Refer to UserTracking database table 'GridInteractions')
#UTDB_APPID=9

#init_sciGwyUserTrackingDB_Hostname  
#UTDB_HOSTNAME=localhost

#init_sciGwyUserTrackingDB_Username
#UTDB_USERNAME=tracking_user

#init_sciGwyUserTrackingDB_Password
#UTDB_PASSWORD=usertracking         

#init_sciGwyUserTrackingDB_Database
#UTDB_DATABASE=userstracking

#init_jobRequirements
# More requirements can be specified by a ';' separated list of items
#INI_JOBREQUIREMENTS=''

#init_pilotScript
# The pilot scrit is not yet supported by the init_parameters
# leave this value empty unless it uses only one line
#INI_PILOTSCRIPT=


#
# docroot/WEB-INF/liferay-display.xml tag values
#
PORTLET_CATEGORYNAME=CataniaSG
PORTLET_IDENTIFIER=$PORTLET_NAME

#
# docroot/WEB-INF/liferay-portlet.xml tag values
#

# <portlet-name>
LFRY_PORTLETNAME=$PORTLET_NAME
# <css-class-wrapper> (! this filed does not accept '-')
LFRY_CSSCLWRAPPER=$CLASS_NAME


#
# docroot/WEB-INF/glassfish-web.xml tag values
#
GLFH_CONTEXTROOT=$PORTLET_NAME

#-----------------------------
# Customization script ...
#-----------------------------

#
# Generates the portlet.xml file
#
cat > docroot/WEB-INF/portlet.xml <<EOF
<?xml version="1.0"?>

<portlet-app
	version="2.0"
	xmlns="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:schemaLocation="http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd http://java.sun.com/xml/ns/portlet/portlet-app_2_0.xsd"
>
	<portlet>
		<portlet-name>${PORTLET_NAME}</portlet-name>
		<display-name>${DISPLAY_NAME}</display-name>
		<portlet-class>${BASE_CLASS}.${CLASS_NAME}</portlet-class>
		<init-param>    
			<name>portletVersion</name>
			<value>${INI_PVERSION}</value>
		</init-param> 
		<init-param>    
			<name>prefItem</name>
			<value>valuePrefItem</value>
		</init-param>
		<!-- init-param>
			<name>logLevel</name>
			<value>${INI_LOGLEVEL}</value>
		</init-param>
		<init-param>    
			<name>bdiiHost</name>
			<value>${INI_BDIIHOST}</value>
		</init-param>
		<init-param>    
			<name>wmsHost</name>
			<value>${INI_WMSHOST}</value>
		</init-param>
		<init-param>
			<name>pxServerHost</name>
			<value>${INI_PXHOST}</value>
		</init-param>
		<init-param>
			<name>pxServerPort</name>
			<value>${INI_PXPORT}</value>
			</init-param>
		<init-param>
			<name>pxServerSecure</name>
			<value>${INI_PXPORT}</value>
		</init-param>
		<init-param>
			<name>pxRobotId</name>
			<value>${INI_ROBOTID}</value>
		</init-param>
		<init-param>
			<name>pxRobotVO</name>
			<value>${INI_ROBOTVO}</value>
		</init-param>
		<init-param>
			<name>pxRobotRole</name>
			<value>${INI_ROBOROLE}</value>
		</init-param>
		<init-param>
			<name>pxUserProxy</name>
			<value>${INI_USERPX}</value>
		</init-param>
		<init-param>
			<name>pxRobotRenewalFlag</name>
			<value>${INI_RENEWALFLAG}</value>
		</init-param>
		<init-param>
			<name>sciGwyAppId</name>
			<value>${UTDB_APPID}</value>
		</init-param>
		<init-param>
			<name>sciGwyUserTrackingDB_Hostname</name>
			<value>${UTDB_HOSTNAME}</value>
		</init-param>
		<init-param>
			<name>sciGwyUserTrackingDB_Username</name>
			<value>${UTDB_USERNAME}</value>
		</init-param>
		<init-param>
			<name>sciGwyUserTrackingDB_Password</name>
			<value>${UTDB_PASSWORD}</value>
		</init-param>
		<init-param>
			<name>sciGwyUserTrackingDB_Database</name>
			<value>${UTDB_DATABASE}</value>
		</init-param>
		<init-param>    
			<name>jobRequirements</name>
			<value>${INI_JOBREQUIREMENTS}</value>
		</init-param>            
		<init-param>    
			<name>pilotScript</name>
			<value>${INI_PILOTSCRIPT}</value>
		</init-param -->
		<expiration-cache>0</expiration-cache>
		<supports>
			<mime-type>text/html</mime-type>
			<portlet-mode>view</portlet-mode>
			<portlet-mode>edit</portlet-mode>
			<portlet-mode>help</portlet-mode>
		</supports>
		<portlet-info>
			<title>${PORTLET_TITLE}</title>
			<short-title>${PORTLET_SHTITLE}</short-title>
			<keywords>${PORTLET_KEYWORDS}</keywords>
		</portlet-info>
		<security-role-ref>
			<role-name>administrator</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>guest</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>power-user</role-name>
		</security-role-ref>
		<security-role-ref>
			<role-name>user</role-name>
		</security-role-ref>
	</portlet>
</portlet-app>
EOF

# Create the portlet class directory
mkdir -p docroot/WEB-INF/src/$(echo $BASE_CLASS | sed s/'\.'/'\/'/g)

#
# Generates the liferay-display.xml
#
cat > docroot/WEB-INF/liferay-display.xml <<EOF
<?xml version="1.0"?>
<!DOCTYPE display PUBLIC "-//Liferay//DTD Display 6.0.0//EN" "http://www.liferay.com/dtd/liferay-display_6_0_0.dtd">

<display>
	<category name="${PORTLET_CATEGORYNAME}">
		<portlet id="${PORTLET_IDENTIFIER}" />
	</category>
</display>
EOF

#
# Generates the docroot/WEB-INF/liferay-portlet.xml
#
cat > docroot/WEB-INF/liferay-portlet.xml << EOF
<?xml version="1.0"?>
<!DOCTYPE liferay-portlet-app PUBLIC "-//Liferay//DTD Portlet Application 6.0.0//EN" "http://www.liferay.com/dtd/liferay-portlet-app_6_0_0.dtd">

<liferay-portlet-app>
	<portlet>
		<portlet-name>${LFRY_PORTLETNAME}</portlet-name>
		<icon>/images/icon.png</icon>
		<instanceable>true</instanceable>
		<header-portlet-css>/css/main.css</header-portlet-css>
		<footer-portlet-javascript>/js/main.js</footer-portlet-javascript>
		<css-class-wrapper>${LFRY_CSSCLWRAPPER}</css-class-wrapper>
	</portlet>
	<role-mapper>
		<role-name>administrator</role-name>
		<role-link>Administrator</role-link>
	</role-mapper>
	<role-mapper>
		<role-name>guest</role-name>
		<role-link>Guest</role-link>
	</role-mapper>
	<role-mapper>
		<role-name>power-user</role-name>
		<role-link>Power User</role-link>
	</role-mapper>
	<role-mapper>
		<role-name>user</role-name>
		<role-link>User</role-link>
	</role-mapper>
</liferay-portlet-app>
EOF

#
# Generates the docroot/WEB-INF/glassfish-web.xml
# 
cat > docroot/WEB-INF/glassfish-web.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE glassfish-web-app PUBLIC "-//GlassFish.org//DTD GlassFish Application Server 3.1 Servlet 3.0//EN" "http://glassfish.org/dtds/glassfish-web-app_3_0-1.dtd">
<glassfish-web-app error-url="">
  <context-root>/${GLFH_CONTEXTROOT}</context-root>
  <class-loader delegate="true"/>
  <jsp-config>
    <property name="keepgenerated" value="true">
      <description>Keep a copy of the generated servlet class' java code.</description>
    </property>
  </jsp-config>
</glassfish-web-app>
EOF

#
# Generates the java code
#
cat > docroot/WEB-INF/src/$(echo $BASE_CLASS | sed s/'\.'/'\/'/g)/${CLASS_NAME}.java <<EOF
/**************************************************************************
Copyright (c) 2011:
Istituto Nazionale di Fisica Nucleare (INFN), Italy
Consorzio COMETA (COMETA), Italy

See http://www.infn.it and and http://www.consorzio-cometa.it for details on
the copyright holders.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

@author <a href="mailto:${AUTH_NAME}">${AUTH_NAME}</a>(${AUTH_INSTITUTE})
****************************************************************************/
package ${BASE_CLASS};


// Importing liferay libraries
import java.io.IOException;
import javax.portlet.*;

public class ${CLASS_NAME} extends GenericPortlet {
     // This portlet uses Aciont/Views enumerations in order to 
    // manage the different portlet modes and the corresponding 
    // view to display
    // You may override the current values with your own business
    // logic best identifiers and manage them through: jsp and java code
    // The jsp parameter PortletStatus will be the responsible of
    // portlet mode switching. This parameter will be read by
    // the processAction method who will select the proper view mode
    // registering again into 'PortletStatus' renderResponse parameter
    // the next view mode.
    // The default prortlet mode by default is: ACTION_INPUT (see ProcessAction)
    private enum Actions {

        ACTION_INPUT // Called before to show the INPUT view
        , ACTION_SUBMIT   // Called after the user press the submit button    
    }

    private enum Views {

        VIEW_INPUT // View containing application input field
        , VIEW_SUBMIT     // View reporting input value    
        ,VIEW_NO_ACTION
    }

    // The init values will be read form portlet.xml from <init-param> xml tag
    // This tag will be useful to setup defaults values for your own portlet
    class App_Init {

        String default_prefvalue;

        public App_Init() {
            default_prefvalue = "";
        }
    } // App_Init
    // Instanciate the App_Init object
    public App_Init appInit = new App_Init();

    //
    // Application input values
    //
    class App_Input {

        String inputValue;   //Text for application input field

        public App_Input() {

            inputValue = "";
        }
    } // App_Input

    class App_Preferences {

        String pref_value;

        public App_Preferences() {
            pref_value = "";
        }
    }
    public App_Preferences appPreferences = new App_Preferences();
    // Liferay portlet data        
    PortletSession portletSession;  // PorteltSession
    PortletContext portletContext;  // PortletContext
    public String appServerPath;   // This variable stores the absolute path of the Web applications
    // Other misc valuse
    // (!) Pay attention that altough the use of the LS variable
    //     the replaceAll("\n","") has to be used 
    public String LS = System.getProperty("line.separator");

    //
    // Portlet Methods
    // 
    //
    // init
    //
    // The init method will be called when installing the portlet for the first time 
    // This is the right time to get default values from WEBINF/portlet.xml file
    // Those values will be assigned into parameters the first time the processAction
    // will be called thanks to the appPreferences object
    //
    @Override
    public void init()
            throws PortletException {
        // Load default values from portlet.xml              
        appInit.default_prefvalue = getInitParameter("prefItem");
    } // init

    //
    // processAction
    //
    // This method allows the portlet to process an action request; this method is normally
    // called upon each user interaction (a submit button inside a jsp' <form statement)
    //
    @Override
    public void processAction(ActionRequest request, ActionResponse response)
            throws PortletException, IOException {
        System.out.println("calling processAction ...");

        // Determine the application pathname                
        portletSession = request.getPortletSession();
        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        System.out.println("Web Application path: '" + appServerPath + "'");

        // Determine the current portlet mode and forward this state to the response
        // Accordingly to JSRs168/286 the standard portlet modes are:
        // VIEW, EDIT, HELP
        PortletMode mode = request.getPortletMode();
        response.setPortletMode(request.getPortletMode());

        // Switch among different portlet modes: VIEW, EDIT, HELP
        // Custom modes are not covered by this template
        if (mode.equals(PortletMode.VIEW)) {
            // The VIEW mode is the normal portlet mode where normal portlet
            // content will be shown to the user
            System.out.println("Portlet mode: VIEW");

            // The actionStatus value will be taken from the calling jsp file
            // through the 'PortletStatus' parameter; the corresponding
            // VIEW mode will be stored registering the portlet status
            // as render parameter. See the call to setRenderParameter
            // If the actionStatus parameter is null or empty the default
            // action will be the ACTION_INPUT (input form)
            // This happens the first time the portlet is shown
            // The PortletStatus variable is managed by jsp and this java code
            String actionStatus = request.getParameter("PortletStatus");
            // Assigns the default ACTION
            if (null == actionStatus
                    || actionStatus.equals("")) {
                actionStatus = "" + Actions.ACTION_INPUT;
            }

            // Different actions will be performed accordingly to the
            // different possible statuses
            switch (Actions.valueOf(actionStatus)) {
                case ACTION_INPUT:
                    System.out.println("Got action: 'ACTION_INPUT'");

                    // Assign the correct view
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
                    break;
                case ACTION_SUBMIT:
                    System.out.println("Got action: 'ACTION_SUBMIT'");



                    // Create the appInput object
                    App_Input appInput = new App_Input();



                    // Process input field
                    getInputForm(request, appInput);



                    // Send the inputValue and assign the correct view                    
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_SUBMIT);

                    response.setRenderParameter("inputValue", "" + appInput.inputValue);
                    break;
                default:
                    System.out.println("Unhandled action: '" + actionStatus + "'");
                    response.setRenderParameter("PortletStatus", "" + Views.VIEW_INPUT);
            }
        } else if (mode.equals(PortletMode.HELP)) {
            // The HELP mode used to give portlet usage HELP to the user
            // This code will be called after the call to doHelp method                         
            System.out.println("Portlet mode: HELP");
        } else if (mode.equals(PortletMode.EDIT)) {
             System.out.println("Portlet mode: EDIT");
            // The EDIT mode is used to view/setup portlet preferences
            PortletPreferences portletPreferences = request.getPreferences();

           
            String old_pref_value = portletPreferences.getValue("prefItem", appInit.default_prefvalue);
            String new_pref_value = request.getParameter("pref_value");
            
             response.setRenderParameter("pref_value", "" + new_pref_value);
             appPreferences.pref_value=new_pref_value;
            // request.setAttribute("pref_value", new_pref_value);
            portletPreferences.setValue("pref_value", new_pref_value);
        } else {
            // Unsupported portlet modes come here
            System.out.println("Custom portlet mode: '" + mode.toString() + "'");
        }
    } // processAction

    //
    // Method responsible to show portlet content to the user accordingly to the current view mode
    //
    @Override
    protected void doView(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        System.out.println("calling doView ...");
        response.setContentType("text/html");


        PortletPreferences portletPreferences = request.getPreferences();
        
        
      

        
        appPreferences.pref_value = portletPreferences.getValue("pref_value", appPreferences.pref_value);
        if (appPreferences.pref_value.equals(null)  || appPreferences.pref_value.equals("")) {
            
            
            appPreferences.pref_value = appInit.default_prefvalue;
            
            portletPreferences.setValue("pref_value",  appPreferences.pref_value);
        }

        // Determine the application pathname                
        portletSession = request.getPortletSession();
        portletContext = portletSession.getPortletContext();
        appServerPath = portletContext.getRealPath("/");
        System.out.println("Web Application path: '" + appServerPath + "'");

        // Switch among supported views; the currentView is determined by the
        // portlet render parameter value stored into PortletStatus identifier
        // this value has been assigned by the actionStatus or it will be 
        // null in case the doView method will be called without a
        // previous processAction call; in such a case the default VIEW_INPUT
        // will be selected.
        //The PortletStatus variable is managed by jsp and this java code
        String currentView = request.getParameter("PortletStatus");
        if (null == currentView
                || currentView.equals("")) {
            currentView = "" + Views.VIEW_INPUT;
        }

        // Different actions will be performed accordingly to the
        // different possible view modes
        switch (Views.valueOf(currentView)) {
            // The following code is responsible to call the proper jsp file
            // that will provide the correct portlet interface
            case VIEW_INPUT: {
                System.out.println("VIEW_INPUT Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/input.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_SUBMIT: {
                System.out.println("VIEW_SUBMIT Selected ...");

                String inputValue = request.getParameter("inputValue");

                request.setAttribute("inputValue", inputValue);
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/submit.jsp");
                dispatcher.include(request, response);
            }
            break;
            case VIEW_NO_ACTION:{
                System.out.println("VIEW_NO_ACTION Selected ...");
                PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/view_without_action.jsp");
                dispatcher.include(request, response); 
            }
            break;    
            default:
                System.out.println("Unknown view mode: " + currentView.toString());
        } // switch            
    } // doView

    //
    // doEdit
    //
    // This methods prepares an actionURL that will be used by edit.jsp file into a <input ...> form
    // As soon the user press the action button the processAction will be called and the portlet mode
    // will be set as EDIT.
    @Override
    public void doEdit(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
       
       
        PortletPreferences portletPreferences = request.getPreferences();
      
		 System.out.println("calling doEdit ...");
       
       // PortletPreferences portletPreferences = request.getPreferences();
        request.setAttribute("pref_value", appPreferences.pref_value);
       
        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/edit.jsp");
        dispatcher.include(request, response);

    } // doEdit

    //
    // doHelp
    //
    // This method just calls the jsp responsible to show the portlet information
    @Override
    public void doHelp(RenderRequest request, RenderResponse response)
            throws PortletException, IOException {
        response.setContentType("text/html");
        System.out.println("calling doHelp ...");
        //request.setAttribute("portletVersion", appInit.portletVersion);
        PortletRequestDispatcher dispatcher = getPortletContext().getRequestDispatcher("/help.jsp");
        dispatcher.include(request, response);
    } // doHelp

    //
    // getInputForm (method)
    //
    public void getInputForm(ActionRequest request, App_Input appInput) {

        // Retrieve from the input form the given application values
        appInput.inputValue = (String) request.getParameter("inputValue");

        // Show into the log the taken inputs
        System.out.println(
                LS + "Taken input parameters:"
                + LS + "-----------------------"
                + LS + "myValue: '" + appInput.inputValue + "'"
                + LS);
    } // getInputForm 
  
    
            
  
} // ${CLASS_NAME} 
EOF

#
# docroot/edit.jsp 
#
mv docroot/edit.jsp docroot/edit.jsp_old
cat docroot/edit.jsp_old | sed s/'hostname-portlet'/'${CLASS_NAME}'/g > docroot/edit.jsp 
rm -f docroot/edit.jsp_old

#
# docroot/help.jsp
#
mv docroot/help.jsp docroot/help.jsp_old
cat docroot/help.jsp_old | sed s/'Author: Riccardo Bruno (COMETA)'/'Author: ${AUTH_NAME} (${AUTH_INSTITUTE}) - ${AUTH_EMAIL}'/g > docroot/help.jsp
rm -f docroot/help.jsp_old

#--------------------------------
# Final Report
#--------------------------------
echo ""
echo "Reporting configured variables ..."
echo ""
echo "AUTH_EMAIL          : '"$AUTH_EMAIL"'"
echo "AUTH_NAME           : '"$AUTH_NAME"'"
echo "AUTH_INSTITUTE      : '"$AUTH_INSTITUTE"'"
echo "PORTLET_NAME        : '"$PORTLET_NAME"'"
echo "PORTLET_TITLE       : '"$PORTLET_TITLE"'"
echo "PORTLET_SHTITLE     : '"$PORTLET_SHTITLE"'"
echo "PORTLET_KEYWORDS    : '"$PORTLET_KEYWORDS"'"
echo "DISPLAY_NAME        : '"$DISPLAY_NAME"'"
echo "BASE_CLASS          : '"$BASE_CLASS"'"
echo "CLASS_NAME          : '"$CLASS_NAME"'"
echo "INI_PVERSION        : '"$INI_PVERSION"'"
echo "PORTLET_CATEGORYNAME: '"$PORTLET_CATEGORYNAME"'"
echo "PORTLET_IDENTIFIER  : '"$PORTLET_IDENTIFIER"'"
echo "LFRY_PORTLETNAME    : '"$LFRY_PORTLETNAME"'"
echo "LFRY_CSSCLWRAPPER   : '"$LFRY_CSSCLWRAPPER"'"
echo "GLFH_CONTEXTROOT    : '"$GLFH_CONTEXTROOT"'"
echo ""
echo "Customization done!"
echo ""

# Check directory name
DIR_NAME=$(basename $(pwd))
if [ $DIR_NAME != $PORTLET_NAME ]
then
  echo "!ATTENTION: The portlet name and the current direcory have a different name"
  echo "            Please rename your directory to: '"$PORTLET_NAME"'"
  echo ""
fi

# Remove existing classes
rm -rf docroot/WEB-INF/classes
mkdir -p docroot/WEB-INF/classes

